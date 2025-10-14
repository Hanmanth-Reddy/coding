Agent-less architecture
Idempotence


### Anisble config file
/etc/anisble/ansible.cfg


## Config priority order 
- export ANSIBLE_CONFIG=/path/to/ansible.cfg
- ansible.cfg in current directory (./anisble.cfg)
- ansible.cfg in use home diectory (~/.ansible.cfg)
- Default config (/etc/anisble/anisble.cfg)

## Varibale priory order 
-  roles/rolename/defaults/main.yml
- 2️⃣ Inventory /group/ host variables 
  ```
  inventory.ini
  group_vars/all.yml
  group_vars/groupname.yml
  host_vars/hostname.yml
  ```
- 3️⃣ Playbook Variables
    ```yaml
    vars:
      http_port: 8080
   ```
- 4️⃣ Task Variables
```yaml
- name: Example
  ansible.builtin.debug:
    msg: "Value is {{ myvar }}"
  vars:
    myvar: "task-level"
```
- 5️⃣ Block Variables

- 6️⃣ Role and Include Vars

- 7️⃣ Extra Vars (highest priority)
```bash
ansible-playbook site.yml -e "user=admin mode=production"
```

### Anisble commands 
```bash
ansible 
ansible <test> --ask-pass -m ping -i hosts

ansible-playbook 
anisble-config 
ansible-doc -l /--list
ansible-vault
```

## Ansible 
Variable 
loops and if condition 
inventory (hosts file)
templates (dynamic files)
roles 
files (static file)
handlers




ansible-playbook -T 2000 --check --ask-pass --ask-vault-password



































































































## XML, JSON, YAML

```yaml
# Simple key-value pairs
fruit: apple
vegetable: carrot
liquid: water
```

```yaml
# List of items
fruits:
  - apple
  - banana
  - grape

vegetables:
  - tomato
  - carrot
```


```yaml
# Dictionary example
banana:
  calories: 12.3
  fat: 1.22
  carbs: 12.1

grapes:
  calories: 15.0
  fat: 0.2
  carbs: 18.0
```