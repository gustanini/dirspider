# dirspider

## Why Dirspider

This tool is a bash script that can be used to automate the tasks of directory brute forcing and crawling/spider for pentesting. Useful for automating the task of creating a list of directories and files and then manually reviewing the source code of multiple websites. 

Upon running, dirspider returns two files: dirsearch.out and spider.out.

- **dirsearch.out** contains the name of all code 200 URLs returned from dirsearch.

- **spider.out** contains all URL's that are found within the source code of all URLs enumerated in dirsearch.out.

**Note**: spider.out will only contain URLs and subdomains that are from the same domain in order to keep results relevant.

---

## Dependencies

Needs gospider and dirsearch installed.

To install these in Kali use:

```bash
sudo apt install dirsearch -y && sudo apt install gospider -y
```

## Usage

To use this tool please read the following syntax:

```bash
#get help
./dirspider.sh -h               
Usage: ./dirspider.sh <URL> [-r]
-h: Show this help message
-f: Enable recursion

# recursive
./dirspider.sh website.com -r

#regular
./dirspider.sh website.com
```
