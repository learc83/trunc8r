import React from "react";
import ReactDOM from "react-dom";
import LinkShortener from "../components/LinkShortener";

const dom = document.getElementById("react-app");

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<LinkShortener></LinkShortener>, dom);
});
