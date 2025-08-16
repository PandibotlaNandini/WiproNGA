import { useEffect, useState } from 'react';
import axios from 'axios';

const CustomerList = () => {
  const [customers, setCustomers] = useState([]);

  useEffect(() => {
    const fetchCustomers = async () => {
      try {
        const res = await axios.get('http://localhost:5129/api/Customers');
        setCustomers(res.data);
      } catch (err) {
        console.error('Error fetching customers:', err);
      }
    };

    fetchCustomers();
  }, []);

  return (
    <div>
      <h2>Customers</h2>
      {customers.map(c => (
        <div key={c.custId}>
          {c.custName} ({c.custUserName}) - {c.email}
        </div>
      ))}
    </div>
  );
};

export default CustomerList;
