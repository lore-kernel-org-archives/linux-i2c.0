From: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] eeprom: add non-cached sysfs read access to EEPROM data
Date: Tue,  1 Sep 2009 16:15:00 -0700 (PDT)
Message-ID: <20090901231500.AA737254211@localhost>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add "eeprom-nc" sysfs attribute to provide non-cached read access
to EEPROM data. This is needed because some EEPROM-like devices
contain constantly changing real-time diagnostic data that cannot
be cached in kernel memory.

Signed-off-by: Petri Gynther <pgynther-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/misc/eeprom/eeprom.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
index 2c27193..101260b 100644
--- a/drivers/misc/eeprom/eeprom.c
+++ b/drivers/misc/eeprom/eeprom.c
@@ -39,6 +39,10 @@ I2C_CLIENT_INSMOD_1(eeprom);
 /* Size of EEPROM in bytes */
 #define EEPROM_SIZE		256
 
+/* EEPROM read modes */
+#define EEPROM_READ_CACHED      0
+#define EEPROM_READ_NONCACHED   1
+
 /* possible types of eeprom devices */
 enum eeprom_nature {
 	UNKNOWN,
@@ -55,14 +59,16 @@ struct eeprom_data {
 };
 
 
-static void eeprom_update_client(struct i2c_client *client, u8 slice)
+static void eeprom_update_client(struct i2c_client *client, u8 slice,
+				 int eeprom_read_mode)
 {
 	struct eeprom_data *data = i2c_get_clientdata(client);
 	int i;
 
 	mutex_lock(&data->update_lock);
 
-	if (!(data->valid & (1 << slice)) ||
+	if (eeprom_read_mode == EEPROM_READ_NONCACHED ||
+	    !(data->valid & (1 << slice)) ||
 	    time_after(jiffies, data->last_updated[slice] + 300 * HZ)) {
 		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
 
@@ -102,7 +108,7 @@ static ssize_t eeprom_read(struct kobject *kobj, struct bin_attribute *bin_attr,
 
 	/* Only refresh slices which contain requested bytes */
 	for (slice = off >> 5; slice <= (off + count - 1) >> 5; slice++)
-		eeprom_update_client(client, slice);
+		eeprom_update_client(client, slice, (int)bin_attr->private);
 
 	/* Hide Vaio private settings to regular users:
 	   - BIOS passwords: bytes 0x00 to 0x0f
@@ -132,6 +138,17 @@ static struct bin_attribute eeprom_attr = {
 	},
 	.size = EEPROM_SIZE,
 	.read = eeprom_read,
+	.private = (void *)EEPROM_READ_CACHED,
+};
+
+static struct bin_attribute eeprom_nc_attr = {
+	.attr = {
+		.name = "eeprom-nc",
+		.mode = S_IRUGO,
+	},
+	.size = EEPROM_SIZE,
+	.read = eeprom_read,
+	.private = (void *)EEPROM_READ_NONCACHED,
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
@@ -202,8 +219,14 @@ static int eeprom_probe(struct i2c_client *client,
 	if (err)
 		goto exit_kfree;
 
+	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_nc_attr);
+	if (err)
+		goto exit_sysfs_clean;
+
 	return 0;
 
+exit_sysfs_clean:
+	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
 exit_kfree:
 	kfree(data);
 exit:
@@ -212,6 +235,7 @@ exit:
 
 static int eeprom_remove(struct i2c_client *client)
 {
+	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_nc_attr);
 	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
 	kfree(i2c_get_clientdata(client));
 
-- 
1.5.4.3
