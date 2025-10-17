# LDAP (Lightweight Directory Access protocol ):
LDAP, which stands for Lightweight Directory Access Protocol, is a protocol for accessing and managing information in a directory. Think of a directory like a phone book or a company's organizational chart. It's a structured database that is optimized for reading information quickly. It's often used to store data about users, groups, and network resources.

used for accessing and maintaining **distributed directory information services** over an Internet Protocol (IP) network.


389 is the default LDAP port

## Install and Configure LDAP

#### Step 1
**Debian/Ubuntu**
```bash
sudo apt update
sudo apt install -y slapd ldap-utils

# You may be prompted to set an admin password during package install; you can reconfigure:
sudo dpkg-reconfigure slapd
```
**RHEL/CentOS (EPEL might be needed):**
```bash
yum install -y openldap openldap-servers openldap-clients
dnf install -y openldap openldap-servers openldap-clients

# enable slapd service
sudo systemctl start slapd
sudo systemctl enable --now slapd
```

openldap >> core libraries
openldap-servers >> slapd service (ldap server)
openldap-clients >> ldapadd, ldapsearch, and slappasswd


#### Step 2: Set the LDAP Root Password
`slappasswd`



#### Step 3: Configure the LDAP Database
Modern OpenLDAP uses a `dynamic configuration database (cn=config)` managed via LDIF (LDAP Data Interchange Format) files, rather than the old slapd.conf file. You need to prepare the default database files.
```bash
# Copy the sample configuration file for the database
sudo cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

# Set the correct permissions for the LDAP database directory
sudo chown -R ldap:ldap /var/lib/ldap/
```


#### Step 4: Configure the Root DN and Password
You now need to apply your specific domain information (the Base DN) and the administrative password hash to the OpenLDAP configuration.


nano root_db.ldif

```bash
cat << EOF > root_db.ldif
dn: olcDatabase={3}mdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=example,dc=com

dn: olcDatabase={3}mdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=example,dc=com

dn: olcDatabase={3}mdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: {SSHA}S/mu+cF++TJOyU8har5IKHvF9vpnWbxt
EOF
```

`sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f root_db.ldif`


#### Step 5: Add Initial Schemas
LDAP uses **schemas** to define the types of objects and attributes that can be stored in the directory (e.g., users, groups, organizations). The standard ones like cosine, nis (for Unix attributes), and inetorgperson are essential.

```bash
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
```

#### Step 6: Create the Base DN Structure
Finally, you need to create the root entry of your LDAP tree (the Base DN) and initial organizational units (OUs) for users and groups.

nano base.ldif
```bash
cat << EOF > base.ldif
dn: dc=example,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Example Company
dc: example

dn: cn=Manager,dc=example,dc=com
objectClass: organizationalRole
cn: Manager
description: Directory Manager

dn: ou=People,dc=example,dc=com
objectClass: organizationalUnit
ou: People

dn: ou=Groups,dc=example,dc=com
objectClass: organizationalUnit
ou: Groups
EOF
```

```ldapadd -x -W -D "cn=Manager,dc=example,dc=com" -f base.ldif```

#### Step 7: Configure Firewall
To allow other systems to connect to your LDAP server, you must open the standard LDAP port.
```bash
sudo firewall-cmd --permanent --add-port=389/tcp
sudo firewall-cmd --reload
```

#### Step 8: Testing and Verification
```bash
ldapsearch -x -LLL -b "dc=example,dc=com"
```



























#### Step 
Before adding users, you must ensure the basic organizational units (OUs) for users and groups exist. You can use an **LDIF (LDAP Data Interchange Format)** file to import the basic structure.


vim base.ldif

**nano base.ldif**
```
dn: dc=example,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Example Corp
dc: example

dn: cn=admin,dc=example,dc=com
objectClass: organizationalRole
cn: admin
description: LDAP administrator
```
`ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f base.ldif`

**nano base.ldif**
```
dn: dc=example,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Example Company

dn: ou=groups,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: groups

dn: ou=users,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: users
```

`sudo ldapadd -x -W -D "cn=admin,dc=example,dc=com" -f base.ldif`




ldapmodify/ldapadd

slapd, schema, entries, and ldif


A `Distinguished Name (DN)` is the unique, absolute path to an entry (like a user or a group) within that LDAP directory. It's like the full path to a file on a computer

A DN is a string of comma-separated components that specifies the exact location of an entry within the hierarchical directory structure. It acts like a file path, tracing the entry back to the root of the directory tree. For example, cn=John Doe,ou=Sales,dc=example,dc=com uniquely identifies a user named John Doe.


dc=example,dc=com
 ├── ou=Sales
 │    ├── cn=John Doe
 │    └── cn=Jane Smith
 └── ou=HR
      ├── cn=Mary Brown
      └── cn=David Wilson






**Bind:**	Authenticates a client to the LDAP server (usually with a username and password). This establishes the session and determines the client's access rights.
**Search:**	The most common operation. It retrieves information from the directory based on a specified filter and scope.
**Add/Modify/Delete:**	Allows for the creation, update, or removal of entries in the directory (requires appropriate permissions).



#### 🌍 Common Use Cases for LDAP

**✅ Centralized user authentication (login via LDAP)**
**✅ Single Sign-On (SSO)**
**✅ Managing permissions across servers/applications**
**✅ Integrating with systems like Jenkins, GitLab, Kubernetes, etc.**

#### 🗂 3️⃣ Why you might have multiple base DNs

**✅ Separate organizations or customers**
**✅ Multi-tenant setups**
**✅ Testing vs production data separation**
**✅ Different authentication domains**




#### TO create new DB
```bash
sudo mkdir /var/lib/ldap/example
sudo chown -R openldap:openldap /var/lib/ldap/example
```

nano newdb.ldif
```yaml
dn: olcDatabase={2}mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: {2}mdb
olcSuffix: dc=example,dc=org
olcDbDirectory: /var/lib/ldap/example
olcRootDN: cn=admin,dc=example,dc=org
olcRootPW: {SSHA}<your-hash>
```

```bash
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f newdb.ldif
```


#### add multiple entries in exmaple DB

nano example-db.ldif
```yaml
# Base domain
dn: dc=example,dc=org
objectClass: top
objectClass: dcObject
objectClass: organization
o: example.org
dc: example

# People organizational unit
dn: ou=People,dc=example,dc=org
objectClass: top
objectClass: organizationalUnit
ou: People

# Groups organizational unit
dn: ou=Groups,dc=example,dc=org
objectClass: top
objectClass: organizationalUnit
ou: Groups

# User 1
dn: uid=jdoe,ou=People,dc=example,dc=org
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
cn: John Doe
sn: Doe
uid: jdoe
uidNumber: 1001
gidNumber: 1001
homeDirectory: /home/jdoe
loginShell: /bin/bash
mail: jdoe@example.org
userPassword: {SSHA}ECF8UVnnExDl9ixnHOTQTcU/nz5FRMfP

# User 2
dn: uid=asmith,ou=People,dc=example,dc=org
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
cn: Alice Smith
sn: Smith
uid: asmith
uidNumber: 1002
gidNumber: 1002
homeDirectory: /home/asmith
loginShell: /bin/bash
mail: asmith@example.org
userPassword: {SSHA}ECF8UVnnExDl9ixnHOTQTcU/nz5FRMfP

# Group: developers
dn: cn=developers,ou=Groups,dc=example,dc=org
objectClass: top
objectClass: posixGroup
cn: developers
gidNumber: 1001
memberUid: jdoe
memberUid: asmith

# Group: admins
dn: cn=admins,ou=Groups,dc=example,dc=org
objectClass: top
objectClass: posixGroup
cn: admins
gidNumber: 1002
memberUid: jdoe
```

all 
```bash
ldapadd -x -D "cn=admin,dc=example,dc=org" -W -f example-db.ldif
```


#### Command to list all databases 
```bash
sudo ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config "(objectClass=olcDatabaseConfig)" olcDatabase olcSuffix
```


#### How to view Base DN

```bash
ldapsearch -x -H ldap://localhost -b cn=config "(objectClass=olcDatabaseConfig)" olcSuffix
```

#### TO add users
```bash
ldapadd -x -D "cn=admin,dc=cisco,dc=com" -W -f new-user.ldif

-D → bind DN (who is adding)
-W → prompt for password
-f → LDIF file to add
```
**TO modify a user**
```bash
ldapmodify -x -D "cn=admin,dc=cisco,dc=com" -W -f modify.ldif
```
**To delete a user**
```bash
ldapdelete -x -D "cn=admin,dc=cisco,dc=com" -W "uid=jdoe,ou=People,dc=cisco,dc=com"
```


ldapsearch -x -LLL -H ldap://localhost -b dc=cisco,dc=com
ldapsearch -x -LLL -b ou=People,dc=cisco,dc=com
ldapsearch -x -LLL -b ou=Groups,dc=cisco,dc=com
ldapsearch -x -LLL -b dc=cisco,dc=com | grep "^dn:" | wc -l



