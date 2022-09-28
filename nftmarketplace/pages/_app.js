import '../styles/globals.css'


//here we are doing internal import
import { Navbar } from '../components/componentindex';


const MyApp = ({ Component, pageProps }) => 
<div>
    <Navbar/>
    <Component {...pageProps} />
</div>


export default MyApp;
