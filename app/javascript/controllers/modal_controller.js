import {Controller} from 'stimulus';
import $ from 'jquery';

export default class extends Controller {
  connect() {
    this.showModal();
    this.putCursorInFirstInput();
  }

  showModal() {
    $(this.element).modal('show');
  }

  putCursorInFirstInput() {
    $(this.element).on('shown.bs.modal', () => {
      this.firstInput.focus();
      this.firstInput.select();
    });
  }

  get firstInput() {
    return this.element.querySelector('input[type="text"]');
  }
}
