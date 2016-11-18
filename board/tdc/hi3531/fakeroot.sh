#!/bin/bash

tput setaf 3;
echo "### Fix GnuPG home directory.";
tput setaf 6;

# Replace with shell scripts
pushd "${TARGET_DIR}/usr/bin"

if [[ `file --mime-type -b gpg` = "application/x-executable" ]]; then
mv gpg gpg-r
cat << EOF > gpg
#!/bin/sh
gpg-r --homedir /etc/gnupg \$*
exit \$?
EOF
chmod a+x gpg
fi

if [[ `file --mime-type -b gpgsplit` = "application/x-executable" ]]; then
mv gpgsplit gpgsplit-r
cat << EOF > gpgsplit
#!/bin/sh
gpgsplit-r --homedir /etc/gnupg \$*
exit \$?
EOF
chmod a+x gpgsplit
fi

if [[ `file --mime-type -b gpgv` = "application/x-executable" ]]; then
mv gpgv gpgv-r
cat << EOF > gpgv
#!/bin/sh
gpgv-r --homedir /etc/gnupg \$*
exit \$?
EOF
chmod a+x gpgv
fi

if [[ `file --mime-type -b gpg-zip` = "application/x-executable" ]]; then
mv gpg-zip gpg-zip-r
cat << EOF > gpg-zip
#!/bin/sh
gpg-zip-r --homedir /etc/gnupg \$*
exit \$?
EOF
chmod a+x gpg-zip
fi

popd

tput sgr0;
