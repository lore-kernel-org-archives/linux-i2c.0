From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c/eeprom: Fall back to SMBus read word transactions
Date: Tue, 3 Jun 2008 16:12:35 +0200
Message-ID: <20080603161235.381b7866@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When I2C block reads are not supported by the underlying adapter, use
SMBus read word transactions instead of consecutive byte reads.
Reasons for this change are:

* The consecutive byte read approach is not safe on multi-master buses.

* While consecutive byte reads have less overhead if you only count the
  bytes on the bus, it takes more than twice as many transactions as
  with SMBus read word transactions, and each transaction has a cost:
  taking and releasing the adapter mutex, and for polling drivers,
  waiting for the transaction to complete.

This change yields a significant performance boost at HZ=250 with
EEPROMs on an Intel 82801 bus (basically twice as fast.)

SMBus read word transactions are widely supported so I don't expect
compatibility issues.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/chips/eeprom.c |   39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/i2c/chips/eeprom.c	2008-06-03 15:24:16.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/chips/eeprom.c	2008-06-03 15:24:27.000000000 +0200
@@ -78,7 +78,7 @@ static struct i2c_driver eeprom_driver =
 static void eeprom_update_client(struct i2c_client *client, u8 slice)
 {
 	struct eeprom_data *data = i2c_get_clientdata(client);
-	int i, j;
+	int i;
 
 	mutex_lock(&data->update_lock);
 
@@ -93,15 +93,12 @@ static void eeprom_update_client(struct 
 							!= 32)
 					goto exit;
 		} else {
-			if (i2c_smbus_write_byte(client, slice << 5)) {
-				dev_dbg(&client->dev, "eeprom read start has failed!\n");
-				goto exit;
-			}
-			for (i = slice << 5; i < (slice + 1) << 5; i++) {
-				j = i2c_smbus_read_byte(client);
-				if (j < 0)
+			for (i = slice << 5; i < (slice + 1) << 5; i += 2) {
+				int word = i2c_smbus_read_word_data(client, i);
+				if (word < 0)
 					goto exit;
-				data->data[i] = (u8) j;
+				data->data[i] = word & 0xff;
+				data->data[i + 1] = word >> 8;
 			}
 		}
 		data->last_updated[slice] = jiffies;
@@ -177,14 +174,15 @@ static int eeprom_detect(struct i2c_adap
 	if (!(adapter->class & I2C_CLASS_SPD) && address >= 0x51)
 		goto exit;
 
-	/* There are three ways we can read the EEPROM data:
+	/* There are four ways we can read the EEPROM data:
 	   (1) I2C block reads (faster, but unsupported by most adapters)
-	   (2) Consecutive byte reads (100% overhead)
-	   (3) Regular byte data reads (200% overhead)
-	   The third method is not implemented by this driver because all
-	   known adapters support at least the second. */
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA
-					    | I2C_FUNC_SMBUS_BYTE))
+	   (2) Word reads (128% overhead)
+	   (3) Consecutive byte reads (88% overhead, unsafe)
+	   (4) Regular byte data reads (265% overhead)
+	   The third and fourth methods are not implemented by this driver
+	   because all known adapters support one of the first two. */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA)
+	 && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
 		goto exit;
 
 	if (!(data = kzalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
@@ -212,13 +210,14 @@ static int eeprom_detect(struct i2c_adap
 
 	/* Detect the Vaio nature of EEPROMs.
 	   We use the "PCG-" or "VGN-" prefix as the signature. */
-	if (address == 0x57) {
+	if (address == 0x57
+	 && i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
 		char name[4];
 
 		name[0] = i2c_smbus_read_byte_data(new_client, 0x80);
-		name[1] = i2c_smbus_read_byte(new_client);
-		name[2] = i2c_smbus_read_byte(new_client);
-		name[3] = i2c_smbus_read_byte(new_client);
+		name[1] = i2c_smbus_read_byte_data(new_client, 0x81);
+		name[2] = i2c_smbus_read_byte_data(new_client, 0x82);
+		name[3] = i2c_smbus_read_byte_data(new_client, 0x83);
 
 		if (!memcmp(name, "PCG-", 4) || !memcmp(name, "VGN-", 4)) {
 			dev_info(&new_client->dev, "Vaio EEPROM detected, "


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
