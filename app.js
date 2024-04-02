window.addEventListener('load', function() {
    if (typeof window.ethereum !== 'undefined') {
        console.log('MetaMask is installed!');
        const web3 = new Web3(window.ethereum);
        
        // Connect to the wallet
        const connectWalletButton = document.getElementById('connectWalletButton');
        connectWalletButton.addEventListener('click', async () => {
            try {
                await window.ethereum.request({ method: 'eth_requestAccounts' });
                const accounts = await web3.eth.getAccounts();
                document.getElementById('info').innerHTML = 'Wallet connected: ' + accounts[0];
            } catch (error) {
                console.error(error);
            }
        });

        // Add more functionality here to interact with your smart contract
    } else {
        document.getElementById('info').innerHTML = 'Please install MetaMask!';
    }
});
