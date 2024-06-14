import React from "react";
import {
  MapContainer,
  Marker,
  Popup,
  TileLayer,
  Polyline,
  // useMap,
} from "react-leaflet";
import L from "leaflet";

const CustomMap = ({ coordinates }) => {
  const center = [coordinates[0][0], coordinates[0][1]];
  const greenIcon = new L.Icon({
    iconUrl:
      "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png",
    shadowUrl:
      "https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png",
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41],
  });
  return (
    <div className="new-map">
      <MapContainer center={center} zoom={13} scrollWheelZoom={true}>
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        <Marker position={coordinates[0]}>
          <Popup>Start</Popup>
        </Marker>
        <Marker position={coordinates.at(-1)} icon={greenIcon}>
          <Popup>End</Popup>
        </Marker>
        <Polyline positions={coordinates} color="blue"></Polyline>
      </MapContainer>
    </div>
  );
};

export default CustomMap;
