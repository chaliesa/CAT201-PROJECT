<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.bookstore.model.*" %>
<%
    // Check if admin is logged in
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn == null || !isLoggedIn) {
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
        return;
    }
    
    String adminUsername = (String) session.getAttribute("adminUsername");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KopiCatz Admin Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #fff5f8 0%, #ffe5f0 50%, #fff5f8 100%);
        }

        .header {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid rgba(255, 192, 203, 0.3);
        }

        .header-content {
            max-width: 1280px;
            margin: 0 auto;
            padding: 16px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            padding: 8px;
            background: linear-gradient(135deg, #ff8fc7, #ff69b4);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo-icon svg {
            width: 32px;
            height: 32px;
            color: white;
        }

        .logo-text {
            font-size: 24px;
            font-weight: bold;
            background: linear-gradient(135deg, #ff69b4, #ff1493);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: linear-gradient(135deg, #ff8fc7, #ff69b4);
            color: white;
            font-weight: 600;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 6px -1px rgba(255, 105, 180, 0.3);
            transition: transform 0.2s;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 8px -1px rgba(255, 105, 180, 0.4);
        }

        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 32px 24px;
        }

        .tabs-container {
            display: flex;
            gap: 8px;
            margin-bottom: 32px;
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            padding: 8px;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 192, 203, 0.3);
            width: fit-content;
        }

        .tab-btn {
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            background: transparent;
            color: #6b7280;
            transition: all 0.3s;
        }

        .tab-btn.active {
            background: linear-gradient(135deg, #ff8fc7, #ff69b4);
            color: white;
            box-shadow: 0 10px 15px -3px rgba(255, 105, 180, 0.3);
        }

        .table-container {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            overflow: hidden;
            border: 1px solid rgba(255, 192, 203, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead tr {
            background: linear-gradient(135deg, #ffe5f0, #ffb6d9);
            border-bottom: 2px solid rgba(255, 192, 203, 0.5);
        }

        th {
            text-align: left;
            padding: 16px 24px;
            font-weight: bold;
            color: #374151;
        }

        tbody tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.5);
        }

        tbody tr:nth-child(odd) {
            background: rgba(255, 192, 203, 0.1);
        }

        tbody tr {
            border-bottom: 1px solid rgba(255, 192, 203, 0.2);
        }

        td {
            padding: 16px 24px;
            color: #374151;
        }

        .stock-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
        }

        .stock-high {
            background: #d1fae5;
            color: #047857;
        }

        .stock-medium {
            background: #fef3c7;
            color: #92400e;
        }

        .stock-low {
            background: #fee2e2;
            color: #991b1b;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
        }

        .status-completed {
            background: #d1fae5;
            color: #047857;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .update-btn {
            background: linear-gradient(135deg, #ff8fc7, #ff69b4);
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            box-shadow: 0 4px 6px -1px rgba(255, 105, 180, 0.3);
            transition: transform 0.2s;
        }

        .update-btn:hover {
            transform: translateY(-1px);
        }

        .fulfill-btn {
            background: linear-gradient(135deg, #6ee7b7, #34d399);
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            box-shadow: 0 4px 6px -1px rgba(52, 211, 153, 0.3);
            transition: transform 0.2s;
        }

        .fulfill-btn:hover {
            transform: translateY(-1px);
        }

        .hidden {
            display: none;
        }

        #loading {
            text-align: center;
            padding: 40px;
            color: #6b7280;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <div class="logo-section">
                <div class="logo-icon">
                    <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                    </svg>
                </div>
                <h1 class="logo-text">KopiCatz Admin Dashboard</h1>
            </div>
            <form action="<%= request.getContextPath() %>/admin/logout" method="post" style="margin: 0;">
                <button type="submit" class="logout-btn">
                    <svg style="width: 20px; height: 20px;" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                    </svg>
                    Logout
                </button>
            </form>
        </div>
    </div>

    <div class="container">
        <!-- Tabs -->
        <div class="tabs-container">
            <button class="tab-btn active" onclick="switchTab('inventory')">
                📦 Inventory
            </button>
            <button class="tab-btn" onclick="switchTab('orders')">
                📋 Orders
            </button>
        </div>

        <!-- Loading indicator -->
        <div id="loading">Loading data...</div>

        <!-- Inventory Table -->
        <div id="inventoryTable" class="table-container hidden">
            <table>
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Name</th>
                        <th>Stock</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="inventoryTableBody">
                    <!-- Dynamic content loaded by JavaScript -->
                </tbody>
            </table>
        </div>

        <!-- Orders Table -->
        <div id="ordersTable" class="table-container hidden">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Product ID</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="ordersTableBody">
                    <!-- Dynamic content loaded by JavaScript -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- SweetAlert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        let currentTab = 'inventory';
        let inventory = [];
        let orders = [];

        // Switch between tabs
        function switchTab(tab) {
            currentTab = tab;
            
            // Update active tab styling
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');

            // Show/hide tables
            if (tab === 'inventory') {
                document.getElementById('inventoryTable').classList.remove('hidden');
                document.getElementById('ordersTable').classList.add('hidden');
            } else {
                document.getElementById('inventoryTable').classList.add('hidden');
                document.getElementById('ordersTable').classList.remove('hidden');
            }
        }

        // Load data on page load
        window.addEventListener('DOMContentLoaded', async function() {
            await loadInventory();
            await loadOrders();
            document.getElementById('loading').classList.add('hidden');
            document.getElementById('inventoryTable').classList.remove('hidden');
        });

        // Load inventory from servlet
        async function loadInventory() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/admin/inventory');
                const data = await response.json();
                inventory = data.products || [];
                renderInventory();
            } catch (error) {
                console.error('Error loading inventory:', error);
                Swal.fire('Error', 'Failed to load inventory', 'error');
            }
        }

        // Load orders from servlet
        async function loadOrders() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/admin/orders');
                const data = await response.json();
                orders = data.orders || [];
                renderOrders();
            } catch (error) {
                console.error('Error loading orders:', error);
                Swal.fire('Error', 'Failed to load orders', 'error');
            }
        }

        // Render inventory table
        function renderInventory() {
            const tbody = document.getElementById('inventoryTableBody');
            tbody.innerHTML = inventory.map((p, index) => {
                const stockClass = p.stock > 20 ? 'stock-high' : p.stock > 10 ? 'stock-medium' : 'stock-low';
                const bgColor = index % 2 === 0 ? 'rgba(255, 255, 255, 0.5)' : 'rgba(255, 192, 203, 0.1)';
                
                return '<tr style="background: ' + bgColor + '">' +
                            '<td style="font-weight: 500;">' + p.id + '</td>' +
                            '<td style="color: #1f2937;">' + p.name + '</td>' +
                            '<td>' +
                                '<span class="stock-badge ' + stockClass + '">' + p.stock + ' units</span>' +
                            '</td>' +
                            '<td>' +
                                '<button class="update-btn" onclick="handleUpdateStock(\'' + p.id + '\')">' +
                                    'Update Stock' +
                                '</button>' +
                            '</td>' +
                        '</tr>';
            }).join('');
        }

        // Render orders table
        function renderOrders() {
            const tbody = document.getElementById('ordersTableBody');
            tbody.innerHTML = orders.map((o, index) => {
                const statusClass = o.status === 'Completed' ? 'status-completed' : 'status-pending';
                const bgColor = index % 2 === 0 ? 'rgba(255, 255, 255, 0.5)' : 'rgba(255, 192, 203, 0.1)';
                
                const actionButton = o.status === 'Pending' ? 
                    '<button class="fulfill-btn" onclick="fulfillOrder(\'' + o.orderId + '\', \'' + o.productId + '\', ' + o.quantity + ')">' +
                        '✓ Fulfill Order' +
                    '</button>' : 
                    '';
                
                return '<tr style="background: ' + bgColor + '">' +
                            '<td style="font-weight: 500;">' + o.orderId + '</td>' +
                            '<td style="color: #1f2937;">' + o.productId + '</td>' +
                            '<td>' + o.quantity + '</td>' +
                            '<td>' +
                                '<span class="status-badge ' + statusClass + '">' + o.status + '</span>' +
                            '</td>' +
                            '<td>' + actionButton + '</td>' +
                        '</tr>';
            }).join('');
        }

        // Handle stock update
        async function handleUpdateStock(productId) {
            const { value: newQty } = await Swal.fire({
                title: 'Update Stock Quantity',
                input: 'number',
                inputLabel: 'Enter the new total stock',
                showCancelButton: true,
                confirmButtonColor: '#ff8fc7',
                cancelButtonColor: '#d1d5db',
                inputValidator: (value) => {
                    if (!value || value < 0) {
                        return 'Please enter a valid quantity!';
                    }
                }
            });

            if (newQty) {
                try {
                    const response = await fetch('<%= request.getContextPath() %>/admin/updateStock', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'productId=' + encodeURIComponent(productId) + '&quantity=' + encodeURIComponent(newQty)
                    });

                    const result = await response.json();
                    
                    if (result.status === 'success') {
                        // Update local data
                        inventory = inventory.map(p => 
                            p.id === productId ? { ...p, stock: parseInt(newQty) } : p
                        );
                        renderInventory();
                        Swal.fire('Updated!', 'Stock quantity updated successfully.', 'success');
                    } else {
                        Swal.fire('Error', result.message || 'Failed to update stock', 'error');
                    }
                } catch (error) {
                    console.error('Error updating stock:', error);
                    Swal.fire('Error', 'Failed to update stock', 'error');
                }
            }
        }

        // Fulfill order
        async function fulfillOrder(orderId, productId, quantity) {
            const result = await Swal.fire({
                title: 'Fulfill Order?',
                text: 'This will deduct ' + quantity + ' units from inventory',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#34d399',
                cancelButtonColor: '#d1d5db',
                confirmButtonText: 'Yes, fulfill it!'
            });

            if (result.isConfirmed) {
                try {
                    const response = await fetch('<%= request.getContextPath() %>/admin/fulfillOrder', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'orderId=' + encodeURIComponent(orderId) + '&productId=' + encodeURIComponent(productId) + '&quantity=' + encodeURIComponent(quantity)
                    });

                    const data = await response.json();
                    
                    if (data.status === 'success') {
                        // Update local data
                        inventory = inventory.map(p => 
                            p.id === productId ? { ...p, stock: p.stock - quantity } : p
                        );
                        orders = orders.map(o => 
                            o.orderId === orderId ? { ...o, status: 'Completed' } : o
                        );
                        renderInventory();
                        renderOrders();
                        Swal.fire('Order Shipped!', 'Inventory has been automatically deducted!', 'success');
                    } else {
                        Swal.fire('Error', data.message || 'Failed to fulfill order', 'error');
                    }
                } catch (error) {
                    console.error('Error fulfilling order:', error);
                    Swal.fire('Error', 'Failed to fulfill order', 'error');
                }
            }
        }
    </script>
</body>
</html>