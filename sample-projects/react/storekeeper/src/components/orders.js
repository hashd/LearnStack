import React from 'react'
import PageHeader from './page_header'
import OrdersTable from './orders/orders_table'
import ORDERS_DATA from '../../mock/orders'

class Orders extends React.Component {
  render() {
    return (
      <div className="orders">
        <PageHeader>
          <h1>Orders</h1>
        </PageHeader>
        <OrdersTable orders={ORDERS_DATA} />
      </div>
    )
  }
}

export default Orders