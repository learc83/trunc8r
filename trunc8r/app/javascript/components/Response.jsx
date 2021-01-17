import React from "react";

const rootUrl = document.querySelector("[name=root-url]")?.content;

function copyString(str) {
  var input = document.createElement("input");
  input.value = str;
  document.body.appendChild(input);
  input.select();
  document.execCommand("copy");
  document.body.removeChild(input);
  alert(str + " copied to clipboard!");
}

export default function Response({ status, messages, slug }) {
  if (status == "error") {
    console.log("akjlads;lkadslkj");
    return (
      <p className="link_shortener__response link_shortener__response--error">
        Error: {messages.join(", ")}
      </p>
    );
  } else if (status == "success") {
    const url = rootUrl + "/" + slug;
    return (
      <p className="link_shortener__response">
        <span className="link_shortener__prompt">Here's your short url:</span>
        <span className="link_shortener__short_url" id="short_url">
          {url}
        </span>
        <button
          className="link_shortener__copy_button"
          onClick={() => copyString(url)}
        >
          Copy
        </button>
      </p>
    );
  } else {
    return null;
  }
}
