import React, { useState } from "react";
import Spinner from "../components/Spinner";
import Response from "../components/Response";

export default function LinkShortener() {
  const token = document.querySelector("[name=csrf-token]")?.content;
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
    setState({ status: "loading", long_link: state.long_link });
    // Don't show the spinner if the request takes less than 100 ms because it flashes and looks bad
    const spinStart = setTimeout(
      () => setState({ status: "spinning", long_link: state.long_link }),
      100
    );

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
        clearTimeout(spinStart);
        if (data.errors) {
          setState({
            status: "error",
            messages: data.errors,
            long_link: state.long_link,
          });
        } else {
          setState({
            status: "success",
            slug: data.slug,
            long_link: state.long_link,
          });
        }
      })
      .catch((error) => {
        clearTimeout(spinStart);
        setState({
          status: "error",
          messages: [error],
          long_link: state.long_link,
        });
      });
  }

  if (state.status === "spinning") return <Spinner></Spinner>;

  return (
    <section className="link_shortener">
      <form onSubmit={shortenLink} className="link_shortener__form">
        <input
          type="text"
          placeholder="http://yourlongurl.com"
          className="link_shortener__input"
          onChange={handleInput}
        />
        <button
          type="submit"
          className="link_shortener__button"
          disabled={state.status == "loading"}
        >
          Shorten!
        </button>
      </form>
      <Response
        status={state.status}
        messages={state.messages}
        slug={state.slug}
      ></Response>
    </section>
  );
}
