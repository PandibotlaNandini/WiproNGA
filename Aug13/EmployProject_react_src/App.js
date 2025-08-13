import logo from './logo.svg';
import './App.css';
import UserShow from './components/usershow/usershow';
import EmployShow from './components/employshow/employshow';
import EmployAdd from './components/employAdd/employAdd';
import EmploySearch from './components/employsearch/employsearch';
import UserSearch from './components/usersearch/usersearch';

function App() {
  return (
    <div className="App">
      <UserShow /><br/>
      <EmployShow /> <br/>
      <UserSearch /> <br/>
      <EmploySearch /> <br/>
      <EmployAdd />
    </div>
  );
}

export default App;
