import React, { useState } from 'react';
import Swal from 'sweetalert2';
import initialData from './data/productData.json';

const Admin = () => {
  if (localStorage.getItem('isLoggedIn') !== 'true') {
    return (
      <div style={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: 'linear-gradient(135deg, #ffe5f0 0%, #fff5f8 50%, #ffe5f0 100%)'
      }}>
        <div style={{
          background: 'rgba(255, 255, 255, 0.8)',
          backdropFilter: 'blur(10px)',
          padding: '40px',
          borderRadius: '24px',
          boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
          textAlign: 'center',
          border: '1px solid rgba(255, 182, 217, 0.3)'
        }}>
          <div style={{
            display: 'inline-block',
            padding: '16px',
            background: 'linear-gradient(135deg, #ff8fc7, #ff69b4)',
            borderRadius: '16px',
            marginBottom: '16px'
          }}>
            <svg style={{ width: '40px', height: '40px', color: 'white' }} fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
            </svg>
          </div>
          <h1 style={{ fontSize: '28px', fontWeight: 'bold', color: '#1f2937', margin: '0 0 16px 0' }}>Access Denied</h1>
          <p style={{ color: '#6b7280', margin: '0 0 24px 0' }}>Please log in to access the admin dashboard</p>
          <button 
            onClick={() => window.location.href = '/'} 
            style={{
              background: 'linear-gradient(135deg, #ff8fc7, #ff69b4)',
              color: 'white',
              fontWeight: '600',
              padding: '12px 32px',
              borderRadius: '12px',
              border: 'none',
              cursor: 'pointer',
              fontSize: '16px',
              boxShadow: '0 10px 15px -3px rgba(255, 105, 180, 0.3)'
            }}
          >
            Go to Login
          </button>
        </div>
      </div>
    );
  }

  const [activeTab, setActiveTab] = useState('inventory');
  const [inventory, setInventory] = useState(initialData.products);
  const [orders, setOrders] = useState(initialData.orders);

  const handleLogout = () => {
    localStorage.removeItem('isLoggedIn');
    window.location.href = '/';
  };

  const handleUpdateStock = async (id: string) => {
    const { value: newQty } = await Swal.fire({
      title: 'Update Stock Quantity',
      input: 'number',
      inputLabel: 'Enter the new total stock',
      showCancelButton: true,
      confirmButtonColor: '#ff8fc7',
      cancelButtonColor: '#d1d5db'
    });

    if (newQty) {
      const qtyNum = parseInt(newQty);
      setInventory(prev => prev.map(p => p.id === id ? { ...p, stock: qtyNum } : p));

      try {
        const details: any = { 'productId': id, 'quantity': qtyNum.toString() };
        let formBody: any = [];
        for (let property in details) {
            formBody.push(encodeURIComponent(property) + "=" + encodeURIComponent(details[property]));
        }

        const response = await fetch('http://localhost:8080/backend/ProductAddQuantityServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: formBody.join("&")
        });

        const result = await response.json();
        if (result.status === 'success') {
            Swal.fire('Updated!', 'Backend synced successfully.', 'success');
        } else {
            Swal.fire('Error', result.message, 'error');
        }
      } catch (error) {
        console.error("Java Server offline:", error);
        Swal.fire('Warning', 'Could not connect to Java Server. UI updated locally only.', 'warning');
      }
    }
  };

  const fulfillOrder = (orderId: string, productId: string, qty: number) => {
    setInventory(inventory.map(p => 
      p.id === productId ? { ...p, stock: p.stock - qty } : p
    ));
    setOrders(orders.map(o => 
      o.orderId === orderId ? { ...o, status: 'Completed' } : o
    ));
    Swal.fire('Order Shipped', 'Inventory has been automatically deducted!', 'success');
  };

  return (
    <div style={{
      minHeight: '100vh',
      background: 'linear-gradient(135deg, #fff5f8 0%, #ffe5f0 50%, #fff5f8 100%)'
    }}>
      {/* Header */}
      <div style={{
        background: 'rgba(255, 255, 255, 0.8)',
        backdropFilter: 'blur(10px)',
        boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
        borderBottom: '1px solid rgba(255, 192, 203, 0.3)'
      }}>
        <div style={{
          maxWidth: '1280px',
          margin: '0 auto',
          padding: '16px 24px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
            <div style={{
              padding: '8px',
              background: 'linear-gradient(135deg, #ff8fc7, #ff69b4)',
              borderRadius: '12px'
            }}>
              <svg style={{ width: '32px', height: '32px', color: 'white' }} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
              </svg>
            </div>
            <h1 style={{
              fontSize: '24px',
              fontWeight: 'bold',
              background: 'linear-gradient(135deg, #ff69b4, #ff1493)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              margin: 0
            }}>KopiCatz Admin Dashboard</h1>
          </div>
          <button 
            onClick={handleLogout}
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '8px',
              padding: '8px 16px',
              background: 'linear-gradient(135deg, #ff8fc7, #ff69b4)',
              color: 'white',
              fontWeight: '600',
              borderRadius: '12px',
              border: 'none',
              cursor: 'pointer',
              boxShadow: '0 4px 6px -1px rgba(255, 105, 180, 0.3)'
            }}
          >
            <svg style={{ width: '20px', height: '20px' }} fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
            </svg>
            Logout
          </button>
        </div>
      </div>

      <div style={{ maxWidth: '1280px', margin: '0 auto', padding: '32px 24px' }}>
        {/* Tabs */}
        <div style={{
          display: 'flex',
          gap: '8px',
          marginBottom: '32px',
          background: 'rgba(255, 255, 255, 0.6)',
          backdropFilter: 'blur(10px)',
          padding: '8px',
          borderRadius: '16px',
          boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 192, 203, 0.3)',
          width: 'fit-content'
        }}>
          <button 
            onClick={() => setActiveTab('inventory')} 
            style={{
              padding: '12px 24px',
              borderRadius: '12px',
              fontWeight: '600',
              border: 'none',
              cursor: 'pointer',
              background: activeTab === 'inventory' ? 'linear-gradient(135deg, #ff8fc7, #ff69b4)' : 'transparent',
              color: activeTab === 'inventory' ? 'white' : '#6b7280',
              boxShadow: activeTab === 'inventory' ? '0 10px 15px -3px rgba(255, 105, 180, 0.3)' : 'none'
            }}
          >
            📦 Inventory
          </button>
          <button 
            onClick={() => setActiveTab('orders')} 
            style={{
              padding: '12px 24px',
              borderRadius: '12px',
              fontWeight: '600',
              border: 'none',
              cursor: 'pointer',
              background: activeTab === 'orders' ? 'linear-gradient(135deg, #ff8fc7, #ff69b4)' : 'transparent',
              color: activeTab === 'orders' ? 'white' : '#6b7280',
              boxShadow: activeTab === 'orders' ? '0 10px 15px -3px rgba(255, 105, 180, 0.3)' : 'none'
            }}
          >
            📋 Orders
          </button>
        </div>

        {/* Tables */}
        <div style={{
          background: 'rgba(255, 255, 255, 0.8)',
          backdropFilter: 'blur(10px)',
          borderRadius: '24px',
          boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
          overflow: 'hidden',
          border: '1px solid rgba(255, 192, 203, 0.3)'
        }}>
          <table style={{ width: '100%', borderCollapse: 'collapse' }}>
            <thead>
              <tr style={{ background: 'linear-gradient(135deg, #ffe5f0, #ffb6d9)', borderBottom: '2px solid rgba(255, 192, 203, 0.5)' }}>
                {activeTab === 'inventory' ? (
                  <>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Product ID</th>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Name</th>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Stock</th>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Action</th>
                  </>
                ) : (
                  <>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Order ID</th>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Product ID</th>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Quantity</th>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Status</th>
                    <th style={{ textAlign: 'left', padding: '16px 24px', fontWeight: 'bold', color: '#374151' }}>Action</th>
                  </>
                )}
              </tr>
            </thead>
            <tbody>
              {activeTab === 'inventory' ? (
                inventory.map((p, index) => (
                  <tr key={p.id} style={{
                    background: index % 2 === 0 ? 'rgba(255, 255, 255, 0.5)' : 'rgba(255, 192, 203, 0.1)',
                    borderBottom: '1px solid rgba(255, 192, 203, 0.2)'
                  }}>
                    <td style={{ padding: '16px 24px', color: '#374151', fontWeight: '500' }}>{p.id}</td>
                    <td style={{ padding: '16px 24px', color: '#1f2937' }}>{p.name}</td>
                    <td style={{ padding: '16px 24px' }}>
                      <span style={{
                        display: 'inline-block',
                        padding: '4px 12px',
                        borderRadius: '12px',
                        fontSize: '14px',
                        fontWeight: '600',
                        background: p.stock > 20 ? '#d1fae5' : p.stock > 10 ? '#fef3c7' : '#fee2e2',
                        color: p.stock > 20 ? '#047857' : p.stock > 10 ? '#92400e' : '#991b1b'
                      }}>
                        {p.stock} units
                      </span>
                    </td>
                    <td style={{ padding: '16px 24px' }}>
                      <button 
                        onClick={() => handleUpdateStock(p.id)} 
                        style={{
                          background: 'linear-gradient(135deg, #ff8fc7, #ff69b4)',
                          color: 'white',
                          padding: '8px 16px',
                          borderRadius: '8px',
                          border: 'none',
                          cursor: 'pointer',
                          fontWeight: '500',
                          boxShadow: '0 4px 6px -1px rgba(255, 105, 180, 0.3)'
                        }}
                      >
                        Update Stock
                      </button>
                    </td>
                  </tr>
                ))
              ) : (
                orders.map((o, index) => (
                  <tr key={o.orderId} style={{
                    background: index % 2 === 0 ? 'rgba(255, 255, 255, 0.5)' : 'rgba(255, 192, 203, 0.1)',
                    borderBottom: '1px solid rgba(255, 192, 203, 0.2)'
                  }}>
                    <td style={{ padding: '16px 24px', color: '#374151', fontWeight: '500' }}>{o.orderId}</td>
                    <td style={{ padding: '16px 24px', color: '#1f2937' }}>{o.productId}</td>
                    <td style={{ padding: '16px 24px' }}>{o.quantity}</td>
                    <td style={{ padding: '16px 24px' }}>
                      <span style={{
                        display: 'inline-block',
                        padding: '4px 12px',
                        borderRadius: '12px',
                        fontSize: '14px',
                        fontWeight: '600',
                        background: o.status === 'Completed' ? '#d1fae5' : '#fef3c7',
                        color: o.status === 'Completed' ? '#047857' : '#92400e'
                      }}>
                        {o.status}
                      </span>
                    </td>
                    <td style={{ padding: '16px 24px' }}>
                      {o.status === 'Pending' && (
                        <button 
                          onClick={() => fulfillOrder(o.orderId, o.productId, o.quantity)} 
                          style={{
                            background: 'linear-gradient(135deg, #6ee7b7, #34d399)',
                            color: 'white',
                            padding: '8px 16px',
                            borderRadius: '8px',
                            border: 'none',
                            cursor: 'pointer',
                            fontWeight: '500',
                            boxShadow: '0 4px 6px -1px rgba(52, 211, 153, 0.3)'
                          }}
                        >
                          ✓ Fulfill Order
                        </button>
                      )}
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default Admin;