$(function () {
  "use strict";

  const CMD_RX = /^\$ (\S[^\\\n]*(\\\n(?!\$ )[^\\\n]*)*)(?=\n|$)/gm;
  const LINE_CONTINUATION_RX = /( ) *\\\n *|\\\n( ?) */g;
  const TRAILING_SPACE_RX = / +$/gm;

  const supportsCopy = !!navigator.clipboard;
  document.querySelectorAll(".ctc pre.highlight, .ctc .literalblock pre").forEach((pre) => {
    let code, language, langLabel, copyButton, toast, toolbox;

    if (pre.classList.contains("highlight")) {
      code = pre.querySelector("code");
      language = code?.dataset?.lang;

      if (language && language !== "console") {
        langLabel = document.createElement("span");
        langLabel.className = "source-lang";
        langLabel.textContent = language;
      }
    } else if (pre.innerText.startsWith("$ ")) {
      const block = pre.closest(".literalblock");
      if (block) {
        block.classList.replace("literalblock", "listingblock");
        pre.classList.add("highlightjs", "highlight");

        code = document.createElement("code");
        code.className = "language-console hljs";
        code.dataset.lang = "console";
        code.appendChild(pre.firstChild);
        pre.appendChild(code);
      }
    } else {
      return;
    }
    toolbox = document.createElement("div");
    toolbox.className = "source-toolbox";
    if (langLabel) toolbox.appendChild(langLabel);

    if (supportsCopy) {
      copyButton = document.createElement("button");
      copyButton.className = "copy-button";
      copyButton.title = "Copy to clipboard";

      copyButton.innerHTML = `<ion-icon size="large" name="copy-outline" class="copy-icon"></ion-icon>`;

      toast = document.createElement("span");
      toast.className = "copy-toast";
      toast.textContent = "Copied!";
      copyButton.appendChild(toast);
      toolbox.appendChild(copyButton);

      copyButton.addEventListener("click", () => writeToClipboard(code, copyButton));
    }

    pre.parentNode.appendChild(toolbox);
  });

  function extractCommands(text) {
    const cmds = [];
    let match;
    while ((match = CMD_RX.exec(text))) {
      cmds.push(match[1].replace(LINE_CONTINUATION_RX, "$1$2"));
    }
    return cmds.join(" && ");
  }

  function writeToClipboard(code, button) {
    let text = code.innerText.replace(TRAILING_SPACE_RX, "");
    if (code.dataset.lang === "console" && text.startsWith("$ ")) {
      text = extractCommands(text);
    }

    navigator.clipboard.writeText(text).then(() => {
      button.classList.add("clicked");
      void button.offsetHeight;
      button.classList.remove("clicked");
    });
  }
});
