import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Navbar from './components/navbar/navbar';
import AddCustomer from './components/addcustomer/addcustomer';
import CustomerList from './components/customerlist/customerlist';
import CustomerSearchById from './components/searchbyId/searchbyId';
import CustomerSearchByUsername from './components/searchbyusername/searchbyusername';
import Login from './components/login/login';

function App() {
  return (
    <Router>
      <Navbar />
      <div>
        <Routes>
          <Route path="/" element={<CustomerList />} />
          <Route path="/add" element={<AddCustomer />} />
          <Route path="/search-id" element={<CustomerSearchById />} />
          <Route path="/search-username" element={<CustomerSearchByUsername />} />
          <Route path="/login" element={<Login />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
