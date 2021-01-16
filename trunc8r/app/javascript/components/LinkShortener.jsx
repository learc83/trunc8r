import React, { useState } from "react";

function copyString(str) {
  var input = document.createElement("input");
  input.value = str;
  document.body.appendChild(input);
  input.select();
  document.execCommand("copy");
  document.body.removeChild(input);
  alert(str + " copied to clipboard!");
}

export default function LinkShortener() {
  const token = document.querySelector("[name=csrf-token]").content;
  const [state, setState] = useState({ status: "ready", long_link: "" });

  function handleInput(e) {
    const inputText = e.target.value;
    const regex = /^(h$|ht$|htt$|http$|https?$|https?:$|https?:\/$|https?:\/\/)/;

    if (regex.test(inputText)) {
      setState({
        status: "ready",
        long_link: inputText,
      });
    } else {
      setState({
        status: "error",
        messages: ["Url must be a valid url ( must start with http(s):// )"],
        long_link: inputText,
      });
    }
  }

  function shortenLink(e) {
    e.preventDefault();
    setState({ status: "loading" });

    const params = { link: { url: state.long_link } };

    fetch("/links", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token,
      },
      body: JSON.stringify(params),
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.errors) {
          setState({ status: "error", messages: data.errors });
        } else {
          setState({ status: "success", slug: data.slug });
        }
      })
      .catch((error) => {
        // setState({ status: "error", messages: [error] });
      });
  }

  let response = "";

  if (state.status == "loading")
    return (
      <div className="spinner">
        <img
          className="sinner__svg"
          src="/assets/spinner.svg"
          alt="Spinning arrow loading indicator"
        ></img>
      </div>
    );
  if (state.status == "error")
    response = (
      <p className="link_shortener__response link_shortener__response--error">
        Error: {state.messages.join(", ")}
      </p>
    );
  if (state.status == "success") {
    const url = "http://localhost:8080/" + state.slug;
    response = (
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
  }

  return (
    <section className="link_shortener">
      <form onSubmit={shortenLink} className="link_shortener__form">
        <input
          type="text"
          placeholder="http://yourlongurl.com"
          className="link_shortener__input"
          onChange={handleInput}
        />
        <button type="submit" className="link_shortener__button">
          Shorten!
        </button>
      </form>
      {response}
    </section>
  );
}
