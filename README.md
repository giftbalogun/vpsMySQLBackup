# MySQL Backup Script for VPS

### Automate MySQL backups on Debian-based VPS systems with optional compression.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Author](https://img.shields.io/badge/author-Gift%20Balogun-brightgreen)

## 📌 About

This script automates **MySQL database backups** on **Debian-based VPS systems**. It allows you to **compress backups**, **store them in a custom directory**, and **delete old backups** automatically.

## 🚀 Features

✅ **Automatic MySQL Backups** – Backs up all databases except system databases.  
✅ **Compression Support** – Optionally compress backups with `gzip`.  
✅ **Old Backup Cleanup** – Automatically deletes backups older than a set number of days.  
✅ **Timestamped Backups** – Avoids overwriting backups by including a date-time stamp.  
✅ **Error Handling & Logging** – Displays `[INFO]`, `[SUCCESS]`, and `[ERROR]` messages.  
✅ **Auto Directory Creation** – Ensures the backup directory exists before starting.  

## 📂 Folder Structure
/root/backup/mysql/ ├── 2024-02-19_12-30-00-database1.sql ├── 2024-02-19_12-30-00-database2.sql.gz ├── 

## 🔧 Configuration

Edit the script before running:

```bash
MYSQL_USER=""         # MySQL Username
MYSQL_PASSWORD=""     # MySQL Password
DAYS_TO_KEEP=5        # Set to 0 to keep backups forever
GZIP=0               # 1 = Enable compression, 0 = No compression
BACKUP_PATH="/root/backup/mysql"  # Change backup path if needed
```

**Next Steps:**  
- **Replace `MYSQL_USER` and `MYSQL_PASSWORD`** in `mysql_backup.sh` before running.  
- **Customize the backup path** if needed.  
- **Set up a cron job** to run the script daily.  


### 1️⃣ Clone the Repository and RUN
```bash
git clone https://github.com/giftbalogun/vpsMySQLBackup
cd vpsMySQLBackup
chmod +x mysql_backup.sh
sudo ./mysql_backup.sh
```

---
### **Highlights of this README:**
✅ **Professional Formatting** with **icons**, `bash` code blocks, and structured sections.  
✅ **Usage Guide** with **cron job scheduling** to automate backups.  
✅ **Proper Licensing & Author Recognition** with your GitHub and portfolio links.  


Let me know if you need modifications! 🚀
