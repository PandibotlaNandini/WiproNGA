import { useState } from 'react';
import axios from 'axios';

const Login = () => {
  const [credentials, setCredentials] = useState({ custUserName: '', custPassword: '' });
  const [message, setMessage] = useState('');

  const handleChange = (e) => {
    setCredentials({ ...credentials, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await axios.post('http://localhost:5129/api/Customers/login', credentials);
      setMessage(`Login successful! Token: ${res.data.token}`);
      // Optional: store token in localStorage if needed
      // localStorage.setItem('token', res.data.token);
    } catch (err) {
      console.error('Login error:', err);
      setMessage('Invalid username or password.');
    }
  };

  return (
    <div>
      <h2>Customer Login</h2>
      <form onSubmit={handleSubmit}>
        <input
          name="custUserName"
          placeholder="Username"
          value={credentials.custUserName}
          onChange={handleChange}
        />
        <input
          name="custPassword"
          type="password"
          placeholder="Password"
          value={credentials.custPassword}
          onChange={handleChange}
        />
        <button type="submit">Login</button>
      </form>
      {message && <p>{message}</p>}
    </div>
  );
};

export default Login;
