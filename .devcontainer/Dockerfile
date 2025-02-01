FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    wget \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get update \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash vscode
USER vscode
WORKDIR /home/vscode

# Install Android SDK
ENV ANDROID_SDK_ROOT /home/vscode/android-sdk
ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools

RUN mkdir -p ${ANDROID_SDK_ROOT} \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O android-commandline-tools.zip \
    && unzip -q android-commandline-tools.zip -d ${ANDROID_SDK_ROOT} \
    && rm android-commandline-tools.zip \
    && mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools/latest \
    && mv ${ANDROID_SDK_ROOT}/cmdline-tools/bin ${ANDROID_SDK_ROOT}/cmdline-tools/latest/ \
    && mv ${ANDROID_SDK_ROOT}/cmdline-tools/lib ${ANDROID_SDK_ROOT}/cmdline-tools/latest/ \
    && yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# Install Flutter
# RUN git clone https://github.com/flutter/flutter.git -b stable /home/vscode/flutter
RUN git config --global http.postBuffer 524288000 && \
    git config --global http.version HTTP/1.1 && \
    git clone https://github.com/flutter/flutter.git -b stable /home/vscode/flutter

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Add flutter to PATH
ENV PATH="/home/vscode/flutter/bin:${PATH}"
ENV PATH="$PATH:$HOME/.pub-cache/bin"

# Pre-download Flutter artifacts
RUN flutter precache

# Enable Flutter web support
RUN flutter config --enable-web --jdk-dir=/usr/lib/jvm/java-17-openjdk-amd64

# Set Chrome executable path
ENV CHROME_EXECUTABLE=/usr/bin/google-chrome

# Verify installation
RUN flutter doctor

# Accept Android licenses
RUN yes | flutter doctor --android-licenses
