import React, { useState } from "react";

export default function LinkShortener() {
  const token = document.querySelector("[name=csrf-token]").content;
  const [state, setState] = useState({ status: "ready" });
  let inputText = "";

  function shortenLink() {
    setState({ status: "loading" });

    const params = { link: { url: inputText } };

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
        setState({ status: "error", messages: [error] });
      });
  }

  if (state.status == "loading") return <p>Loading...</p>;
  if (state.status == "error") return <p>Error: {state.messages.join(", ")}</p>;
  if (state.status == "success")
    return <p>Here's your short url: http://localhost/{state.slug}</p>;

  return (
    <section className="link_shortener">
      <form onSubmit={shortenLink} className="link_shortener__form">
        <input
          type="text"
          placeholder="http://google.com"
          className="link_shortener__input"
          onChange={(text) => {
            inputText = text.target.value;
            console.log(inputText);
          }}
        />
        <button type="submit" className="link_shortener__button">
          Shorten!
        </button>
      </form>
    </section>
  );
}
