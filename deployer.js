var rokuDeploy = require('roku-deploy');

//deploy a .zip package of your project to a roku device
rokuDeploy.deployAndSignPackage().then(function(){
    //it worked
}, function(error) {
    //it failed
    console.error(error);
});