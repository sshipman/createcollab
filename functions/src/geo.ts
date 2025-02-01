import {getFirestore, GeoPoint, Timestamp} from "firebase-admin/firestore";
import * as geofire from "geofire-common";
import {HelpRequest} from "./helpRequest";

export async function getRecentRequestsNearLocation(center: GeoPoint, radiusInM: number): Promise<Array<HelpRequest>> {
  const recentHorizon = 60 * 60; // hour in seconds
  const firestore = getFirestore();

  // Each item in 'bounds' represents a startAt/endAt pair. We have to issue
  // a separate query for each pair. There can be up to 9 pairs of bounds
  // depending on overlap, but in most cases there are 4.
  const bounds = geofire.geohashQueryBounds([center.latitude, center.longitude], radiusInM);
  const promises = [];
  for (const b of bounds) {
    const q = firestore.collection("helpRequests").
      orderBy("geohash").
      startAt(b[0]).
      endAt(b[1]);

    promises.push(q.get());
  }

  // Collect all the query results together into a single list
  const snapshots = await Promise.all(promises);

  const helpRequests= [];
  for (const snap of snapshots) {
    for (const doc of snap.docs) {
      const timestamp = doc.get("timestamp");
      const now = Timestamp.now();
      if (timestamp.seconds - now.seconds > recentHorizon) {
        continue;
      }
      const lat = doc.get("lat");
      const lng = doc.get("lng");

      // We have to filter out a few false positives due to GeoHash
      // accuracy, but most will match
      const distanceInKm = geofire.distanceBetween([lat, lng], [center.latitude, center.longitude]);
      const distanceInM = distanceInKm * 1000;
      if (distanceInM <= radiusInM) {
        helpRequests.push(HelpRequest.fromDoc(doc));
      }
    }
  }
  return helpRequests;
}
