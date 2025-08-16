import { useState } from 'react';
import axios from 'axios';

const AddCustomer = () => {
  const [form, setForm] = useState({
    custId: '',
    custName: '',
    custUserName: '',
    custPassword: '',
    City: '',
    State: '',
    email: '',
    mobileNo: ''
  });

  const [message, setMessage] = useState('');

  // Update form fields
  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  // Submit form to backend
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post('http://localhost:5129/api/Customers/add', form);
      console.log('Response:', res.data);
      setMessage('Customer added successfully!');
      // Reset form
      setForm({
        custId: '',
        custName: '',
        custUserName: '',
        custPassword: '',
        City: '',
        State: '',
        email: '',
        mobileNo: ''
      });
    } catch (err) {
      console.error('Error adding customer:', err.response ? err.response.data : err);
      setMessage(err.response?.data?.message || 'Error adding customer. Please try again.');
    }
  };

  return (
    <div>
      <h2>Add Customer</h2>
      <form onSubmit={handleSubmit}>
        <input name="custId" placeholder="Customer ID" value={form.custId} onChange={handleChange} />
        <input name="custName" placeholder="Name" value={form.custName} onChange={handleChange} />
        <input name="custUserName" placeholder="Username" value={form.custUserName} onChange={handleChange} />
        <input name="custPassword" type="password" placeholder="Password" value={form.custPassword} onChange={handleChange} />
        <input name="City" placeholder="City" value={form.City} onChange={handleChange} />
        <input name="State" placeholder="State" value={form.State} onChange={handleChange} />
        <input name="email" placeholder="Email" value={form.email} onChange={handleChange} />
        <input name="mobileNo" placeholder="Mobile No" value={form.mobileNo} onChange={handleChange} />
        <button type="submit">Add Customer</button>
      </form>
      {message && <p>{message}</p>}
    </div>
  );
};

export default AddCustomer;
