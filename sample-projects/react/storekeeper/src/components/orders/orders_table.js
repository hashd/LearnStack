import React from 'react'
import OrderRow from './order_row'

class OrdersTable extends React.Component {
  render() {
    const ORDER_ROWS = this.props.orders.map((order, idx) => {
      return <OrderRow order={order} key={idx} />
    })

    return (
      <table className="orders-table mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp" style={{width:"100%"}}>
        <thead>
          <tr>
            <th className="mdl-data-table__cell--non-numeric">Order #</th>
            <th className="mdl-data-table__cell--non-numeric">Customer</th>
            <th className="mdl-data-table__cell--non-numeric sorted-by">Ordered At</th>
            <th className="mdl-data-table__cell--non-numeric">Product(s)</th>
            <th className="amount">Amount</th>
            <th className="mdl-data-table__cell--non-numeric status">Payment Status</th>
            <th className="mdl-data-table__cell--non-numeric status">Order Status</th>
          </tr>
        </thead>
        <tbody>
          {ORDER_ROWS}
        </tbody>
      </table>
    )
  }
}

export default OrdersTable