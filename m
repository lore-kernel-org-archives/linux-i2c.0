From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] at24: Fall back to byte or word reads if needed
Date: Mon, 8 Mar 2010 08:50:08 +0100
Message-ID: <20100308085008.366915c3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: at24: Fall back to byte or word reads if needed

Increase the portability of the at24 driver by letting it read from
EEPROM chips connected to cheap SMBus controllers that support neither
raw I2C messages nor even I2C block reads. All SMBus controllers
should support either word reads or byte reads, so read support
becomes universal, much like with the legacy "eeprom" driver.

Obviously, this only works with EEPROM chips up to AT24C16, that use
8-bit offset addressing. 16-bit offset addressing is almost impossible
to support on SMBus controllers.

I did not add universal support for writes, as I had no immediate need
for this, but it could be added later if needed (with the same
performance issue as byte and word reads have, of course.)

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
---
Konstantin, please test and report.

 drivers/misc/eeprom/at24.c |   47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

--- linux-2.6.33.orig/drivers/misc/eeprom/at24.c	2010-02-25 09:10:35.000000000 +0100
+++ linux-2.6.33/drivers/misc/eeprom/at24.c	2010-03-06 14:19:03.000000000 +0100
@@ -54,7 +54,7 @@
 struct at24_data {
 	struct at24_platform_data chip;
 	struct memory_accessor macc;
-	bool use_smbus;
+	int use_smbus;
 
 	/*
 	 * Lock protects against activities from other Linux tasks,
@@ -184,10 +184,14 @@ static ssize_t at24_eeprom_read(struct a
 	if (count > io_limit)
 		count = io_limit;
 
-	if (at24->use_smbus) {
+	if (at24->use_smbus == I2C_SMBUS_I2C_BLOCK_DATA) {
 		/* Smaller eeproms can work given some SMBus extension calls */
 		if (count > I2C_SMBUS_BLOCK_MAX)
 			count = I2C_SMBUS_BLOCK_MAX;
+	} else if (at24->use_smbus == I2C_SMBUS_WORD_DATA) {
+		count = 2;
+	} else if (at24->use_smbus == I2C_SMBUS_BYTE_DATA) {
+		count = 1;
 	} else {
 		/*
 		 * When we have a better choice than SMBus calls, use a
@@ -219,9 +223,22 @@ static ssize_t at24_eeprom_read(struct a
 	timeout = jiffies + msecs_to_jiffies(write_timeout);
 	do {
 		read_time = jiffies;
-		if (at24->use_smbus) {
+		if (at24->use_smbus == I2C_SMBUS_I2C_BLOCK_DATA) {
 			status = i2c_smbus_read_i2c_block_data(client, offset,
 					count, buf);
+		} else if (at24->use_smbus == I2C_SMBUS_WORD_DATA) {
+			status = i2c_smbus_read_word_data(client, offset);
+			if (status >= 0) {
+				buf[0] = status & 0xff;
+				buf[1] = status >> 8;
+				status = count;
+			}
+		} else if (at24->use_smbus == I2C_SMBUS_BYTE_DATA) {
+			status = i2c_smbus_read_byte_data(client, offset);
+			if (status >= 0) {
+				buf[0] = status;
+				status = count;
+			}
 		} else {
 			status = i2c_transfer(client->adapter, msg, 2);
 			if (status == 2)
@@ -434,7 +451,7 @@ static int at24_probe(struct i2c_client
 {
 	struct at24_platform_data chip;
 	bool writable;
-	bool use_smbus = false;
+	int use_smbus = 0;
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
@@ -475,12 +492,19 @@ static int at24_probe(struct i2c_client
 			err = -EPFNOSUPPORT;
 			goto err_out;
 		}
-		if (!i2c_check_functionality(client->adapter,
+		if (i2c_check_functionality(client->adapter,
 				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
+		} else if (i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+			use_smbus = I2C_SMBUS_WORD_DATA;
+		} else if (i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
+			use_smbus = I2C_SMBUS_BYTE_DATA;
+		} else {
 			err = -EPFNOSUPPORT;
 			goto err_out;
 		}
-		use_smbus = true;
 	}
 
 	if (chip.flags & AT24_FLAG_TAKE8ADDR)
@@ -565,11 +589,16 @@ static int at24_probe(struct i2c_client
 	dev_info(&client->dev, "%zu byte %s EEPROM %s\n",
 		at24->bin.size, client->name,
 		writable ? "(writable)" : "(read-only)");
+	if (use_smbus == I2C_SMBUS_WORD_DATA ||
+	    use_smbus == I2C_SMBUS_BYTE_DATA) {
+		dev_notice(&client->dev, "Falling back to %s reads, "
+			   "performance will suffer\n", use_smbus ==
+			   I2C_SMBUS_WORD_DATA ? "word" : "byte");
+	}
 	dev_dbg(&client->dev,
-		"page_size %d, num_addresses %d, write_max %d%s\n",
+		"page_size %d, num_addresses %d, write_max %d, use_smbus %d\n",
 		chip.page_size, num_addresses,
-		at24->write_max,
-		use_smbus ? ", use_smbus" : "");
+		at24->write_max, use_smbus);
 
 	/* export data to kernel code */
 	if (chip.setup)


-- 
Jean Delvare
