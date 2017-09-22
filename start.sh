#!/bin/bash
# set -e

# TODO: only do this for certain commands (serve, test?), otherwise only do a regular install

# Watch package.json and re-install on changes
node -e "
const fs = require('fs');
exec = require('child_process').exec;
fs.watchFile('package.json',() => {
  console.log('package.json has changed; a install is triggered.\n');
  exec('${PACKAGE_MANAGER} install',(error, stdout, stderr) => {
      if (stdout) console.log(stdout);
      if (stderr) console.error(stderr);
      if (error) {
        console.error('${PACKAGE_MANAGER} install has not finished sucessfully: '+ error);
      } else {
        console.log('${PACKAGE_MANAGER} install has finished succesfully.\n')
      }
  });
});
console.log('A watcher on package.json has been setup and will trigger a install on file changes\n')

exec('${PACKAGE_MANAGER} install',(error, stdout, stderr) => {
      if (stdout) console.log(stdout);
      if (stderr) console.error(stderr);
      if (error) {
        console.error('${PACKAGE_MANAGER} install has not finished sucessfully: '+ error);
      } else {
        console.log('${PACKAGE_MANAGER} install has finished succesfully.\n')
      }
  });
});

" &



exec "$@"