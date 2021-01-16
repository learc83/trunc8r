import React from "react";

export default function Spinner() {
  return (
    <div className="spinner">
      <img
        className="sinner__svg"
        src="/assets/spinner.svg"
        alt="Spinning arrow loading indicator"
      ></img>
    </div>
  );
}
