From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Fwd: [PATCH 2/3] I2C: at24: add kernel interface for
	reading/writing EEPROM
Date: Mon, 25 Aug 2008 19:41:54 -0700
Message-ID: <200808251941.54964.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

My own comments on this:

	- I'd like to see at24.c use something running before
	  device_initcall, so suitably configured system can
	  have drivers calling platform_device_probe() from
	  their own initcalls and yet have access to the config
	  data from the EEPROMs.

	- Seems to me that "struct at24_iface" should be more
	  generic ... the same notion works for SPI eeproms,
	  NVRAM as found in RTCs, etc.

Comments?

- Dave

----------  Forwarded Message  ----------

Subject: [PATCH 2/3] I2C: at24: add kernel interface for reading/writing EEPROM
Date: Monday 25 August 2008
From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org

This patch adds an interface by which other kernel code can read/write
detected EEPROM.

The platform code registers a 'setup' callback with the
at24_platform_data.  When the at24 driver detects an EEPROM, it fills
out the read and write functions of at24_iface and calls the setup
callback.  The platform code can then use the read/write functions in
the at24_iface struct for reading and writing the EEPROM.

Original idea, review and updates by David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>

Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 drivers/i2c/chips/at24.c |   42 +++++++++++++++++++++++++++++++++++-------
 include/linux/i2c/at24.h |   10 ++++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/chips/at24.c b/drivers/i2c/chips/at24.c
index 2a4acb2..ce6423d 100644
--- a/drivers/i2c/chips/at24.c
+++ b/drivers/i2c/chips/at24.c
@@ -53,6 +53,7 @@
 
 struct at24_data {
 	struct at24_platform_data chip;
+	struct at24_iface iface;
 	bool use_smbus;
 
 	/*
@@ -264,13 +265,6 @@ static ssize_t at24_bin_read(struct kobject *kobj, struct bin_attribute *attr,
 
 
 /*
- * REVISIT: export at24_bin{read,write}() to let other kernel code use
- * eeprom data. For example, it might hold a board's Ethernet address, or
- * board-specific calibration data generated on the manufacturing floor.
- */
-
-
-/*
  * Note that if the hardware write-protect pin is pulled high, the whole
  * chip is normally write protected. But there are plenty of product
  * variants here, including OTP fuses and partial chip protect.
@@ -386,6 +380,30 @@ static ssize_t at24_bin_write(struct kobject *kobj, struct bin_attribute *attr,
 
 /*-------------------------------------------------------------------------*/
 
+/*
+ * This lets other kernel code access the eeprom data. For example, it
+ * might hold a board's Ethernet address, or board-specific calibration
+ * data generated on the manufacturing floor.
+ */
+
+static ssize_t at24_iface_read(struct at24_iface *iface, char *buf,
+			      off_t offset, size_t count)
+{
+	struct at24_data *at24 = container_of(iface, struct at24_data, iface);
+
+	return at24_eeprom_read(at24, buf, offset, count);
+}
+
+static ssize_t at24_iface_write(struct at24_iface *iface, char *buf,
+			       off_t offset, size_t count)
+{
+	struct at24_data *at24 = container_of(iface, struct at24_data, iface);
+
+	return at24_eeprom_write(at24, buf, offset, count);
+}
+
+/*-------------------------------------------------------------------------*/
+
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct at24_platform_data chip;
@@ -413,6 +431,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		 * is recommended anyhow.
 		 */
 		chip.page_size = 1;
+
+		chip.setup = NULL;
+		chip.context = NULL;
 	}
 
 	if (!is_power_of_2(chip.byte_len))
@@ -449,6 +470,9 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto err_out;
 	}
 
+	at24->iface.read = at24_iface_read;
+	at24->iface.write = at24_iface_write;
+
 	mutex_init(&at24->lock);
 	at24->use_smbus = use_smbus;
 	at24->chip = chip;
@@ -521,6 +545,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		at24->write_max,
 		use_smbus ? ", use_smbus" : "");
 
+	/* export data to kernel code */
+	if (chip.setup)
+		chip.setup(&at24->iface, chip.context);
+
 	return 0;
 
 err_clients:
diff --git a/include/linux/i2c/at24.h b/include/linux/i2c/at24.h
index f6edd52..50008cc 100644
--- a/include/linux/i2c/at24.h
+++ b/include/linux/i2c/at24.h
@@ -15,6 +15,13 @@
  * is bigger than what the chip actually supports!
  */
 
+struct at24_iface {
+	ssize_t (*read)(struct at24_iface *, char *buf, off_t offset,
+			size_t count);
+	ssize_t (*write)(struct at24_iface *, char *buf, off_t offset,
+			 size_t count);
+};
+
 struct at24_platform_data {
 	u32		byte_len;		/* size (sum of all addr) */
 	u16		page_size;		/* for writes */
@@ -23,6 +30,9 @@ struct at24_platform_data {
 #define AT24_FLAG_READONLY	0x40	/* sysfs-entry will be read-only */
 #define AT24_FLAG_IRUGO		0x20	/* sysfs-entry will be world-readable */
 #define AT24_FLAG_TAKE8ADDR	0x10	/* take always 8 addresses (24c00) */
+
+	int             (*setup)(struct at24_iface *, void *context);
+	void		*context;
 };
 
 #endif /* _LINUX_AT24_H */
-- 
1.5.6.4


-------------------------------------------------------

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
