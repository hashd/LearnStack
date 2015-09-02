import {EventEmitter} from 'events'
import _ from 'lodash'

let ListStore = _.extend({}, EventEmitter.prototype, {
	items: [
		{ id: 0, name: 'Item 1' },
		{ id: 1, name: 'Item 2' }
	],

	getItems: function () {
		return this.items;
	},

  addItem: function (new_item) {
    this.items.push(new_item);
  },

  removeItem: function (item_id) {
    let items = this.items;
    
    _.remove(items, (item) => {
      return item_id == item.id;
    });
    
    this.items = items;
  },

  emitChange: function () {
    this.emit('change');
  },

  addChangeListener: function (callback) {
    this.on('change', callback);
  },

  removeChangeListener: function (callback) {
    this.removeListener('change', callback);
  }
});

export default ListStore