document.addEventListener("DOMContentLoaded", function () {
    var avatarSelect = document.getElementById("avatar-select");
    var avatarPreviewContainer = document.getElementById("image-preview-container");
    var avatarPreview = document.getElementById("avatar-preview");

    avatarSelect.addEventListener("change", function () {
      var selectedImage = this.options[this.selectedIndex].getAttribute("data-image");
      if (selectedImage !== "") {
        avatarPreview.src = selectedImage;
        avatarPreviewContainer.style.display = "block";
      } else {
        avatarPreviewContainer.style.display = "none";
      }
    });
  });