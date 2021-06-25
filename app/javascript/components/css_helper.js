// css class names
const hide = 'hide'

// set/toggle elements visibility
const toggleHide = (element) => {
  element.classList.toggle(hide);
}
const addHide = (element) => {
  element.classList.add(hide);
}
const removeHide = (element) => {
  element.classList.remove(hide);
}
export {addHide, removeHide, toggleHide}
