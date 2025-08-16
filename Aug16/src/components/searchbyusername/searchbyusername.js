import { useState } from 'react';
import axios from 'axios';

const CustomerSearchByUsername = () => {
  const [username, setUsername] = useState('');
  const [customer, setCustomer] = useState(null);
  const [message, setMessage] = useState('');

  const handleSearch = async () => {
    try {
      const res = await axios.get(`http://localhost:5129/api/Customers/byusername/${username}`);
      setCustomer(res.data);
      setMessage('');
    } catch (err) {
      console.error('Error fetching customer:', err);
      setCustomer(null);
      setMessage('Customer not found.');
    }
  };

  return (
    <div>
      <h2>Search Customer by Username</h2>
      <input
        placeholder="Enter Username"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
      />
      <button onClick={handleSearch}>Search</button>

      {message && <p>{message}</p>}

      {customer && (
        <div style={{ border: '1px solid #ccc', padding: '10px', marginTop: '10px' }}>
          <p><strong>ID:</strong> {customer.custId}</p>
          <p><strong>Name:</strong> {customer.custName}</p>
          <p><strong>Username:</strong> {customer.custUserName}</p>
          <p><strong>City:</strong> {customer.city}</p>
          <p><strong>State:</strong> {customer.state}</p>
          <p><strong>Email:</strong> {customer.email}</p>
          <p><strong>Mobile:</strong> {customer.mobileNo}</p>
        </div>
      )}
    </div>
  );
};

export default CustomerSearchByUsername;
