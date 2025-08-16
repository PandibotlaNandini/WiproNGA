import { Link } from 'react-router-dom';

const Navbar = () => (
  <nav>
    <Link to="/">Show Customers</Link> | 
    <Link to="/add">Add Customer</Link> | 
    <Link to="/search-id">Search by ID</Link> | 
    <Link to="/search-username">Search by Username</Link> | 
    <Link to="/login">Login</Link>
  </nav>
);

export default Navbar;
