import { Link } from "react-router-dom";
import "./Navbar.css";

export default function Navbar() {
  return (
    <nav className="navbar">
      <div className="logo">🎬 JustBook</div>
      <div className="links">
      <Link to="/">Home</Link>
      <Link to="/checkout">Checkout</Link>
      <Link to="/signin">Sign In</Link>
</div>

    </nav>
  );
}
