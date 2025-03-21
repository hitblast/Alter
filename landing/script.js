ScrollReveal().reveal(".content > *", {
  delay: 500,
  interval: 100,
  distance: "50px",
  origin: "bottom",
});
ScrollReveal().reveal("footer", {
  delay: 400,
  distance: "50px",
  origin: "bottom",
});

(function () {
  var imageElement = document.querySelector(".image");
  var images = [
    "assets/static/hero.png",
    "assets/static/hero_alt.png",
    "assets/static/hero_ble.png",
  ];
  var currentIndex = 0;

  imageElement.addEventListener("click", function () {
    imageElement.classList.add("clicked");
    setTimeout(function () {
      currentIndex = (currentIndex + 1) % images.length;
      imageElement.src = images[currentIndex];
      imageElement.classList.remove("clicked");
    }, 150);
  });
})();

(function () {
  var codeBlock = document.querySelector(".code-block");
  var iconHTML = '<i class="fa-brands fa-apple"></i>';
  var originalText = " brew install hitblast/tap/alter";
  var hoverText = " Copy command to clipboard";
  var copiedText = " Copied to clipboard!";
  var isCopied = false;

  codeBlock.addEventListener("mouseover", function () {
    if (!isCopied) {
      codeBlock.innerHTML = iconHTML + hoverText;
    }
  });

  codeBlock.addEventListener("mouseout", function () {
    if (!isCopied) {
      codeBlock.innerHTML = iconHTML + originalText;
    }
  });

  codeBlock.addEventListener("click", function () {
    navigator.clipboard
      .writeText(originalText.trim())
      .then(function () {
        isCopied = true;
        codeBlock.innerHTML = iconHTML + copiedText;
      })
      .catch(function (err) {
        console.error("Failed to copy text: ", err);
      });
  });
})();

// Apply dark mode based on the system preference
if (
  window.matchMedia &&
  window.matchMedia("(prefers-color-scheme: dark)").matches
) {
  document.body.classList.add("dark");
}

(function () {
  var themeBtn = document.querySelector(".theme-toggle");
  function updateIcon() {
    if (document.body.classList.contains("dark")) {
      themeBtn.innerHTML =
        '<i class="fa-solid fa-sun" style="color: grey;"></i>';
    } else {
      themeBtn.innerHTML =
        '<i class="fa-solid fa-moon" style="color: black;"></i>';
    }
  }
  updateIcon();
  themeBtn.addEventListener("click", function () {
    document.body.classList.toggle("dark");
    updateIcon();
  });
})();
