import {getRecentRequestsNearLocation} from "../src/geo";
import { GeoPoint, getFirestore, Timestamp } from "firebase-admin/firestore";
import * as geofire from "geofire-common";
import {HelpRequestStatus} from "../src/helpRequest";
import * as admin from "firebase-admin";
import * as firebaseTest from "firebase-functions-test";
import { expect } from "chai";

process.env.FIRESTORE_EMULATOR_HOST = "localhost:8080"; // Port may vary
admin.initializeApp({
  projectId: "demo-test" // Use a fake project ID
});const testEnv = firebaseTest();

const db = getFirestore();

describe("Cloud Functions", () => {
    after(() => {
        testEnv.cleanup();
    });
    it("test 1", async () => {
        const testCenter: GeoPoint = new GeoPoint(47.6471, -122.3046);
        const testRadius = 2400;
        const testData1 = await db.collection("helpRequests").add({
            id: "testUser1",
            geohash: geofire.geohashForLocation([47.6404, -122.3022]),
            lat: 47.6404,
            lng: -122.3022,
            description: "I need help with fixing my bike!",
            timestamp: Timestamp.now(),
            status: HelpRequestStatus.OPEN
        });
        const testData2 = await db.collection("helpRequests").add({
            id: "testUser2",
            geohash: geofire.geohashForLocation([47.6538, -122.3068]),
            lat: 47.6538,
            lng: -122.3068,
            description: "I need help changing the oil in my car!",
            timestamp: Timestamp.now(),
            status: HelpRequestStatus.OPEN
        });
        const result = await getRecentRequestsNearLocation(testCenter, testRadius);
        expect(result).to.be.an("array");
        expect(result.length).to.be.at.least(2);
        console.log(result[0]);
        console.log(result[1]);
        expect(result[0]).to.deep.include({
            id: "testUser2",
            lat: 47.6538,
            lng: -122.3068,
            description: "I need help changing the oil in my car!",
            status: HelpRequestStatus.OPEN
        });
        expect(result[1]).to.deep.include({
            id: "testUser1",
            lat: 47.6404,
            lng: -122.3022,
            description: "I need help with fixing my bike!",
            status: HelpRequestStatus.OPEN
        });
        //await db.collection("helpRequests").doc(testData1.id).delete();
        //await db.collection("helpRequests").doc(testData2.id).delete();
    });
});
