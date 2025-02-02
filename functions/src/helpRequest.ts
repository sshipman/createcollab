import {DocumentSnapshot} from "firebase-admin/firestore";

export class HelpRequest {
  id: string;
  geohash: string;
  lat: number;
  lng: number;
  description: string;
  status: HelpRequestStatus;

  constructor(id: string, geohash:string, lat: number, lng: number,
    description: string, status: HelpRequestStatus = HelpRequestStatus.OPEN) {
    this.id = id;
    this.geohash = geohash;
    this.lat = lat;
    this.lng = lng;
    this.description = description;
    this.status = status;
  }

  static fromDoc(doc:DocumentSnapshot): HelpRequest {
    // it had better exist!
    // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
    const data = doc.data()!;
    return new HelpRequest(data.id, data.geohash, data.lat, data.lng, data.description);
  }
}

export enum HelpRequestStatus {
    OPEN,
    IN_PROGRESS,
    CLOSED,
}
