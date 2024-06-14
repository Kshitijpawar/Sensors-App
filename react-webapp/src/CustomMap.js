import React from "react";
import { MapContainer, Marker, Popup, TileLayer, Polyline, useMap } from "react-leaflet";

const CustomMap = ({coordinates}) => {
    const center = [coordinates[0][0], coordinates[0][1]];
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
        <Marker position={coordinates.at(-1)}>
          <Popup>End</Popup>
        </Marker>
        <Polyline positions={coordinates} color="blue"></Polyline>
      </MapContainer>
    </div>
  );
};

export default CustomMap;
