<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - Purrfect Store</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <div class="logo">
                <img src="icon/cat logo.png" alt="Purrfect Store" class="logo-icon">
                <h1>Purrfect Store</h1>
            </div>
            <ul class="nav-links">
                <li><a href="index.html">Home</a></li>
                <li><a href="products.jsp" class="active">Products</a></li>
                <li><a href="cart.jsp">🛒 Cart</a></li>
            </ul>
        </div>
    </nav>

    <section class="page-header">
        <div class="container">
            <h1>Our Products</h1>
            <p>Find everything your cat needs</p>
        </div>
    </section>

    <section class="products">
        <div class="container">
            <div class="products-grid">
                <!-- Example product card with form to POST to AddToCartServlet -->
                <div class="product-card">
                    <div class="product-image"><img src="images/WHISKAS® Adult Tuna & Salmon flavour.png" alt="WHISKAS Adult Tuna & Salmon" loading="lazy"></div>
                    <h3>WHISKAS Adult Tuna & Salmon</h3>
                    <p class="product-category">Cat Food</p>
                    <p class="product-description">100% nutritionally complete and balanced meal formulated for adult cats 1+ years.</p>
                    <p class="price">RM 28</p>
                    <form method="post" action="add-to-cart">
                        <input type="hidden" name="name" value="WHISKAS Adult Tuna & Salmon">
                        <input type="hidden" name="price" value="28">
                        <input type="hidden" name="qty" value="1">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>

                <!-- Repeat product cards: keep them static but use server form for add-to-cart -->
                <!-- WHISKAS Adult Grilled Salmon -->
                <div class="product-card">
                    <div class="product-image"><img src="images/WHISKAS%C2%AE%20Adult%20Grilled%20Salmon%20Steak%20Flavour.png" alt="WHISKAS Adult Grilled Salmon" loading="lazy"></div>
                    <h3>WHISKAS Adult Grilled Salmon</h3>
                    <p class="product-category">Cat Food</p>
                    <p class="product-description">100% nutritionally complete meal with tasty filled pocket kibbles and quality poultry ingredients.</p>
                    <p class="price">RM 29</p>
                    <form method="post" action="add-to-cart">
                        <input type="hidden" name="name" value="WHISKAS Adult Grilled Salmon">
                        <input type="hidden" name="price" value="29">
                        <input type="hidden" name="qty" value="1">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>

                <!-- Add remaining products similarly -->

                <div class="product-card">
                    <div class="product-image"><img src="images/WHISKAS® Adult Indoor Formula.png" alt="WHISKAS Adult Indoor Formula" loading="lazy"></div>
                    <h3>WHISKAS Adult Indoor Formula</h3>
                    <p class="product-category">Cat Food</p>
                    <p class="product-description">100% complete & balanced meal with reduced calories for indoor cats.</p>
                    <p class="price">RM 25</p>
                    <form method="post" action="add-to-cart">
                        <input type="hidden" name="name" value="WHISKAS Adult Indoor Formula">
                        <input type="hidden" name="price" value="25">
                        <input type="hidden" name="qty" value="1">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>

                <div class="product-card">
                    <div class="product-image"><img src="images/WHISKAS® Adult Skin & Coat.png" alt="WHISKAS Adult Skin & Coat" loading="lazy"></div>
                    <h3>WHISKAS Adult Skin & Coat</h3>
                    <p class="product-category">Cat Food</p>
                    <p class="product-description">Formulated to reduce hair fall and enhance coat beauty.</p>
                    <p class="price">RM 30</p>
                    <form method="post" action="add-to-cart">
                        <input type="hidden" name="name" value="WHISKAS Adult Skin & Coat">
                        <input type="hidden" name="price" value="30">
                        <input type="hidden" name="qty" value="1">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>

                <!-- Additional products (shortened for brevity) -->
                <div class="product-card">
                    <div class="product-image"><img src="images/WHISKAS® Tuna Cat Food.png" alt="WHISKAS Tuna Cat Food" loading="lazy"></div>
                    <h3>WHISKAS Tuna Cat Food</h3>
                    <p class="product-category">Cat Food</p>
                    <p class="price">RM 22</p>
                    <form method="post" action="add-to-cart">
                        <input type="hidden" name="name" value="WHISKAS Tuna Cat Food">
                        <input type="hidden" name="price" value="22">
                        <input type="hidden" name="qty" value="1">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>

                <div class="product-card">
                    <div class="product-image"><img src="images/Catnip Cat Wand Toy.webp" alt="Catnip Cat Wand Toy" loading="lazy"></div>
                    <h3>Catnip Cat Wand Toy</h3>
                    <p class="product-category">Toys</p>
                    <p class="price">RM 38</p>
                    <form method="post" action="add-to-cart">
                        <input type="hidden" name="name" value="Catnip Cat Wand Toy">
                        <input type="hidden" name="price" value="38">
                        <input type="hidden" name="qty" value="1">
                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                    </form>
                </div>

            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Purrfect Store. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
