import * as css from './css_helper'

const initAvatarImgPreview = (formInputAvatar) => {
  const formInputAvatarPreview = document.getElementById("image_preview")
  formInputAvatar.addEventListener('change', ()=> {
    const [file] = formInputAvatar.files
    if (file) {
      formInputAvatarPreview.src = URL.createObjectURL(file)
      css.removeHide(formInputAvatarPreview.classList.remove("hide"));
    }
    else {
      css.addHide(formInputAvatarPreview.classList.add("hide"));
    }
  });
}

export {initAvatarImgPreview}
