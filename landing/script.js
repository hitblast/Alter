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
        setTimeout(function () {
          isCopied = false;
          codeBlock.innerHTML = iconHTML + originalText;
        }, 3000);
      })
      .catch(function (err) {
        console.error("Failed to copy text: ", err);
      });
  });
})();
