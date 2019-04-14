const fs = require('fs');

const FILE_TO_UPDATE = './node_modules/verdaccio-ldap/index.js';

const fileContent = fs.readFileSync(FILE_TO_UPDATE, 'utf8');

const TEXT_TO_REPLACE = '[].concat(ldapUser._groups).map((group) => group.cn)';

const TEXT_REPLACEMENT = '[].concat(ldapUser._groups).map((group) => group[this._config.groupNameAttribute])';

const replacedFileContent = fileContent.replace(TEXT_TO_REPLACE, TEXT_REPLACEMENT);

// console.log('\n\n$$$$$$$$$$$$$$ here\n\n');

// console.log(replacedFileContent);

// console.log('\n\n$$$$$$$$$$$$$$ end here\n\n');


fs.writeFileSync(FILE_TO_UPDATE, replacedFileContent);

