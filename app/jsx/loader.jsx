import ReactDOM from 'react-dom';
import Routes from './routes'
import {browserHistory} from 'react-router';
import Footer from './components/footer'
import Navbar from './components/navbar'

var translate = require('counterpart');
translate.registerTranslations('en', require('./locales/en'));

$(document).on('ready page:load', function () {
  ReactDOM.render(<Navbar/>,
    document.getElementById('nav_bar'));
  ReactDOM.render(<Footer/>,
    document.getElementById('footer'));
  ReactDOM.render(<Routes history={browserHistory}/>,
    document.getElementById('root'));
});
