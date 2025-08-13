import logo from './logo.svg';
import './App.css';
import CreateAccount from './components/createAccount/createAccount';
import SearchAccount from './components/searchAccount/searchAccount';
import ShowAccount from './components/showAccount/showAccount';
import Deposit from './components/deposit/deposit';
import Withdraw from './components/withdraw/withdraw';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Login from './components/login/login';
import Menu from './components/menu/menu';

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/menu" element={<Menu />} />
          <Route path="/createAccount" element={<CreateAccount />} />
          <Route path="/searchAccount" element={<SearchAccount />} /> 
          <Route path="/showAccount" element={<ShowAccount />} />
          <Route path="/depositAccount" element={<Deposit />} /> 
          <Route path="/withdrawAccount" element={<Withdraw />} />
        </Routes>
      </BrowserRouter>

    </div>
  );
}

export default App;
