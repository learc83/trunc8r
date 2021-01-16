import React from "react";
import ReactDOM from "react-dom";

export default function LinkShortener() {
  return (
    <section class="link_shortener">
      <input
        type="text"
        placeholder="http://google.com"
        class="link_shortener__input"
      />
      <button type="button" class="link_shortener__button">
        Shorten!
      </button>
    </section>
  );
}
