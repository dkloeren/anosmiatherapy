import * as css from './css_helper'

const initAvatarImgPreview = (formInputAvatar) => {
  const formInputAvatarPreview = document.getElementById("image_preview")

  // formInputAvatar.addEventListener('change', ()=> {
  //   const [file] = formInputAvatar.files
  //   if (file) {
  //     formInputAvatarPreview.src = URL.createObjectURL(file)
  //     css.removeHide(formInputAvatarPreview);
  //   }
  //   else {
  //     css.addHide(formInputAvatarPreview);
  //   }
  // });

  formInputAvatar.addEventListener('mouseover', () => {
    const [file] = formInputAvatar.files
    if (file) {
      formInputAvatarPreview.src = URL.createObjectURL(file)
      css.removeHide(formInputAvatarPreview);
    }
    else {
      css.addHide(formInputAvatarPreview);
    }

  });

  formInputAvatar.addEventListener('mouseout', () => {
    const [file] = formInputAvatar.files
    if (file) css.addHide(formInputAvatarPreview);
  });
}

export {initAvatarImgPreview}
