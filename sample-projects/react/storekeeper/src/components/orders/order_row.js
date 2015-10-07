import React from 'react'
import { toDateTime, toMoney, toTitleCase } from '../../lib/formatters'

class OrderRow extends React.Component {
  render() {
    const { order } = this.props
    const products = order.products.map(p => p.name).join(', ')

    return (
      <tr className="order-row">
        <td className="mdl-data-table__cell--non-numeric">{order.reference}</td>
        <td className="mdl-data-table__cell--non-numeric">{order.customer}</td>
        <td className="mdl-data-table__cell--non-numeric sorted-by">{toDateTime(order.orderedAt)}</td>
        <td className="mdl-data-table__cell--non-numeric">{products}</td>
        <td className="amount">{toMoney(order.amount)}</td>
        <td className="mdl-data-table__cell--non-numeric status">{toTitleCase(order.paymentStatus)}</td>
        <td className="mdl-data-table__cell--non-numeric status">{toTitleCase(order.orderStatus)}</td>
      </tr>
    )
  }
}

export default OrderRow