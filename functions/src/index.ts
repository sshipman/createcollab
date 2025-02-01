/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import {onCall} from "firebase-functions/v2/https";
import {GeoPoint} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import {getRecentRequestsNearLocation} from "./geo";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const getHelpRequests = onCall(async (request) => {
  logger.info("Hello logs!", {structuredData: true});
  const data = request.data;
  const radius = data.radius || 500; // meters
  const center = new GeoPoint(data.lat, data.lng);
  return getRecentRequestsNearLocation(center, radius);
});
