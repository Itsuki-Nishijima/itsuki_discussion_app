// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const flashes = document.querySelectorAll(".flash");

  flashes.forEach((flash) => {
    setTimeout(() => {
      flash.style.transition = "all .5s ease";
      flash.style.opacity = "0";
      flash.style.transform = "translate(-50%, -20px)";

      setTimeout(() => {
        flash.remove();
      }, 500);

    }, 3000);
  });
});