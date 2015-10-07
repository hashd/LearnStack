import React from 'react'
import PageHeader from './page_header'
import OrdersTable from './orders/orders_table'
import { toTitleCase } from '../lib/formatters'
import ORDERS_DATA from '../../mock/orders'

const STATUSES = ['all', 'open', 'shipped']

class Orders extends React.Component {
  constructor(props) {
    super(props)
    this.state = { selectedStatus: 'all' }
  }

  render() {
    const { selectedStatus } = this.state
    const statuses = STATUSES.map((status, idx) => {
      const className = (status === selectedStatus)? 'selected status': 'status';
      return (
        <a key={idx} className={className} onClick={this.handleStatusClick.bind(this, status)}>
          {toTitleCase(status)}
        </a>
      )
    })
    const orders = ORDERS_DATA.filter((order) => order.orderStatus === selectedStatus || selectedStatus === 'all')

    return (
      <div className="orders">
        <PageHeader>
          <h4>Orders</h4>
          <nav>
            {statuses}
          </nav>
        </PageHeader>
        <OrdersTable orders={orders} />
      </div>
    )
  }

  handleStatusClick(status) {
    this.setState({ selectedStatus: status })
  }
}

export default Orders