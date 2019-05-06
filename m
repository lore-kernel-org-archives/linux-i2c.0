From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 1/2] eeprom: ee1004: Move selected page detection to a
 separate function
Date: Mon, 6 May 2019 15:15:39 +0200
Message-ID: <20190506151539.69ee75e8@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

No functional change, this is in preparation for future needs.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/eeprom/ee1004.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

--- linux-5.0.orig/drivers/misc/eeprom/ee1004.c	2019-05-06 11:23:14.833319076 +0200
+++ linux-5.0/drivers/misc/eeprom/ee1004.c	2019-05-06 11:56:58.478375343 +0200
@@ -57,6 +57,24 @@ MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
 /*-------------------------------------------------------------------------*/
 
+static int ee1004_get_current_page(void)
+{
+	int err;
+
+	err = i2c_smbus_read_byte(ee1004_set_page[0]);
+	if (err == -ENXIO) {
+		/* Nack means page 1 is selected */
+		return 1;
+	}
+	if (err < 0) {
+		/* Anything else is a real error, bail out */
+		return err;
+	}
+
+	/* Ack means page 0 is selected, returned value meaningless */
+	return 0;
+}
+
 static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 				  unsigned int offset, size_t count)
 {
@@ -190,17 +208,10 @@ static int ee1004_probe(struct i2c_clien
 	}
 
 	/* Remember current page to avoid unneeded page select */
-	err = i2c_smbus_read_byte(ee1004_set_page[0]);
-	if (err == -ENXIO) {
-		/* Nack means page 1 is selected */
-		ee1004_current_page = 1;
-	} else if (err < 0) {
-		/* Anything else is a real error, bail out */
+	err = ee1004_get_current_page();
+	if (err < 0)
 		goto err_clients;
-	} else {
-		/* Ack means page 0 is selected, returned value meaningless */
-		ee1004_current_page = 0;
-	}
+	ee1004_current_page = err;
 	dev_dbg(&client->dev, "Currently selected page: %d\n",
 		ee1004_current_page);
 	mutex_unlock(&ee1004_bus_lock);


-- 
Jean Delvare
SUSE L3 Support
