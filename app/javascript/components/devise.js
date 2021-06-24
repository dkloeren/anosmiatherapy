const initAvatarImgPreview = (formInputAvatar) => {
  const formInputAvatarPreview = document.getElementById("image_preview")
  formInputAvatar.onchange = evt => {
    const [file] = formInputAvatar.files
    if (file) {
      formInputAvatarPreview.src = URL.createObjectURL(file)
      hideToggle(formInputAvatarPreview)
    }
  }
}

export {initAvatarImgPreview}
