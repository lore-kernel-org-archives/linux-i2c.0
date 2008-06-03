From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] i2c/eeprom: Only probe buses with DDC or SPD class
Date: Tue, 3 Jun 2008 13:03:43 +0200
Message-ID: <20080603130343.1a4704a9@hyperion.delvare>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The eeprom driver shouldn't probe i2c buses which don't want to be
probed.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/chips/eeprom.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.26-rc4.orig/drivers/i2c/chips/eeprom.c	2008-06-03 09:57:31.000000000 +0200
+++ linux-2.6.26-rc4/drivers/i2c/chips/eeprom.c	2008-06-03 10:46:09.000000000 +0200
@@ -159,6 +159,8 @@ static struct bin_attribute eeprom_attr 
 
 static int eeprom_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & (I2C_CLASS_DDC | I2C_CLASS_SPD)))
+		return 0;
 	return i2c_probe(adapter, &addr_data, eeprom_detect);
 }
 
@@ -169,6 +171,12 @@ static int eeprom_detect(struct i2c_adap
 	struct eeprom_data *data;
 	int err = 0;
 
+	/* EDID EEPROMs are often 24C00 EEPROMs, which answer to all
+	   addresses 0x50-0x57, but we only care about 0x50. So decline
+	   attaching to addresses >= 0x51 on DDC buses */
+	if (!(adapter->class & I2C_CLASS_SPD) && address >= 0x51)
+		goto exit;
+
 	/* There are three ways we can read the EEPROM data:
 	   (1) I2C block reads (faster, but unsupported by most adapters)
 	   (2) Consecutive byte reads (100% overhead)


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
