# GMAIL VALIDATOR
## Installation the required tools

Ubuntu/Debian:
```sh
sudo apt install wget openssl dos2unix
```

CentOS/RHEL:

```sh
sudo yum install wget openssl dos2unix
```

Termux (Android):

```sh
pkg install wget openssl dos2unix
```


## Exec

Grant Executable Permission:

```sh
chmod +x main.sh
```

If "bash: ./main.sh: cannot execute: required file not found" then:

```sh
dos2unix main.sh
```

run:

```sh
./main.sh
```

   ## Command Line Arguments

```sh
# Basic usage
./main.sh -i emails.txt -r results/

# Dengan custom settings
./main.sh -i emails.txt -r results/ -l 10 -t 2 -d

# Full options
./main.sh -i emails.txt -r results/ -l 15 -t 1 -d

# With Auto-Delete
./main.sh -i temp_emails.txt -r final_results/ -d
```

## Parameter Options
| Parameter | Description | Information |
| ------ | ------ | ------  |
| -i file | Input file email list | required
| -r folder | Folder for results | required
| -l number | Email per batch | max 3
| -t seconds | Delay per seconds | 1 sec
| -d | Delete processed emails | free
| -h | help | -

Contact me dh44ndy@gmail.com
