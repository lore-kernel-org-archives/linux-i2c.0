From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] Input: apanel - convert to new i2c binding
Date: Tue, 11 Nov 2008 18:49:27 +0100
Message-ID: <20081111184927.7a85ab4f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Stephen Hemminger <shemminger-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Convert the apanel driver to the new i2c device driver binding model,
as the legacy model is going away soon. In the new model, the apanel
driver is no longer scanning all the i2c adapters, instead the
relevant bus driver (i2c-i801) is instantiating the device as needed.

One side benefit is that the apanel driver will now load automatically
on all systems where it is needed.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Stephen Hemminger <shemminger-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
---
I don't have a Fujitsu Lifebook myself so I couldn't test this patch.
Stephen, any chance you could give it some testing and confirm that I
didn't break anything, or know someone who could? Thanks.

 drivers/i2c/busses/i2c-i801.c |   50 ++++++++++++++++++++++++-
 drivers/input/misc/apanel.c   |   81 +++++++++++++----------------------------
 2 files changed, 76 insertions(+), 55 deletions(-)

--- linux-2.6.28-rc4.orig/drivers/input/misc/apanel.c	2008-10-10 09:21:54.000000000 +0200
+++ linux-2.6.28-rc4/drivers/input/misc/apanel.c	2008-11-11 18:36:17.000000000 +0100
@@ -57,7 +57,7 @@ static enum apanel_chip device_chip[APAN
 
 struct apanel {
 	struct input_polled_dev *ipdev;
-	struct i2c_client client;
+	struct i2c_client *client;
 	unsigned short keymap[MAX_PANEL_KEYS];
 	u16    nkeys;
 	u16    led_bits;
@@ -66,16 +66,7 @@ struct apanel {
 };
 
 
-static int apanel_probe(struct i2c_adapter *, int, int);
-
-/* for now, we only support one address */
-static unsigned short normal_i2c[] = {0, I2C_CLIENT_END};
-static unsigned short ignore = I2C_CLIENT_END;
-static struct i2c_client_address_data addr_data = {
-	.normal_i2c	= normal_i2c,
-	.probe		= &ignore,
-	.ignore		= &ignore,
-};
+static int apanel_probe(struct i2c_client *, const struct i2c_device_id *);
 
 static void report_key(struct input_dev *input, unsigned keycode)
 {
@@ -103,12 +94,12 @@ static void apanel_poll(struct input_pol
 	s32 data;
 	int i;
 
-	data = i2c_smbus_read_word_data(&ap->client, cmd);
+	data = i2c_smbus_read_word_data(ap->client, cmd);
 	if (data < 0)
 		return;	/* ignore errors (due to ACPI??) */
 
 	/* write back to clear latch */
-	i2c_smbus_write_word_data(&ap->client, cmd, 0);
+	i2c_smbus_write_word_data(ap->client, cmd, 0);
 
 	if (!data)
 		return;
@@ -124,7 +115,7 @@ static void led_update(struct work_struc
 {
 	struct apanel *ap = container_of(work, struct apanel, led_work);
 
-	i2c_smbus_write_word_data(&ap->client, 0x10, ap->led_bits);
+	i2c_smbus_write_word_data(ap->client, 0x10, ap->led_bits);
 }
 
 static void mail_led_set(struct led_classdev *led,
@@ -140,7 +131,7 @@ static void mail_led_set(struct led_clas
 	schedule_work(&ap->led_work);
 }
 
-static int apanel_detach_client(struct i2c_client *client)
+static int apanel_remove(struct i2c_client *client)
 {
 	struct apanel *ap = i2c_get_clientdata(client);
 
@@ -148,43 +139,33 @@ static int apanel_detach_client(struct i
 		led_classdev_unregister(&ap->mail_led);
 
 	input_unregister_polled_device(ap->ipdev);
-	i2c_detach_client(&ap->client);
 	input_free_polled_device(ap->ipdev);
 
 	return 0;
 }
 
-/* Function is invoked for every i2c adapter. */
-static int apanel_attach_adapter(struct i2c_adapter *adap)
-{
-	dev_dbg(&adap->dev, APANEL ": attach adapter id=%d\n", adap->id);
-
-	/* Our device is connected only to i801 on laptop */
-	if (adap->id != I2C_HW_SMBUS_I801)
-		return -ENODEV;
-
-	return i2c_probe(adap, &addr_data, apanel_probe);
-}
-
 static void apanel_shutdown(struct i2c_client *client)
 {
-	apanel_detach_client(client);
+	apanel_remove(client);
 }
 
+static struct i2c_device_id apanel_id[] = {
+	{ "fujitsu_apanel", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, apanel_id);
+
 static struct i2c_driver apanel_driver = {
 	.driver = {
 		.name = APANEL,
 	},
-	.attach_adapter = &apanel_attach_adapter,
-	.detach_client  = &apanel_detach_client,
+	.probe		= &apanel_probe,
+	.remove		= &apanel_remove,
 	.shutdown	= &apanel_shutdown,
+	.id_table	= apanel_id,
 };
 
 static struct apanel apanel = {
-	.client = {
-		.driver = &apanel_driver,
-		.name   = APANEL,
-	},
 	.keymap = {
 		[0] = KEY_MAIL,
 		[1] = KEY_WWW,
@@ -204,7 +185,8 @@ static struct apanel apanel = {
 };
 
 /* NB: Only one panel on the i2c. */
-static int apanel_probe(struct i2c_adapter *bus, int address, int kind)
+static int apanel_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct apanel *ap;
 	struct input_polled_dev *ipdev;
@@ -212,9 +194,6 @@ static int apanel_probe(struct i2c_adapt
 	u8 cmd = device_chip[APANEL_DEV_APPBTN] == CHIP_OZ992C ? 0 : 8;
 	int i, err = -ENOMEM;
 
-	dev_dbg(&bus->dev, APANEL ": probe adapter %p addr %d kind %d\n",
-		bus, address, kind);
-
 	ap = &apanel;
 
 	ipdev = input_allocate_polled_device();
@@ -222,18 +201,13 @@ static int apanel_probe(struct i2c_adapt
 		goto out1;
 
 	ap->ipdev = ipdev;
-	ap->client.adapter = bus;
-	ap->client.addr = address;
-
-	i2c_set_clientdata(&ap->client, ap);
+	ap->client = client;
 
-	err = i2c_attach_client(&ap->client);
-	if (err)
-		goto out2;
+	i2c_set_clientdata(client, ap);
 
-	err = i2c_smbus_write_word_data(&ap->client, cmd, 0);
+	err = i2c_smbus_write_word_data(client, cmd, 0);
 	if (err) {
-		dev_warn(&ap->client.dev, APANEL ": smbus write error %d\n",
+		dev_warn(&client->dev, APANEL ": smbus write error %d\n",
 			 err);
 		goto out3;
 	}
@@ -246,7 +220,7 @@ static int apanel_probe(struct i2c_adapt
 	idev->name = APANEL_NAME " buttons";
 	idev->phys = "apanel/input0";
 	idev->id.bustype = BUS_HOST;
-	idev->dev.parent = &ap->client.dev;
+	idev->dev.parent = &client->dev;
 
 	set_bit(EV_KEY, idev->evbit);
 
@@ -264,7 +238,7 @@ static int apanel_probe(struct i2c_adapt
 
 	INIT_WORK(&ap->led_work, led_update);
 	if (device_chip[APANEL_DEV_LED] != CHIP_NONE) {
-		err = led_classdev_register(&ap->client.dev, &ap->mail_led);
+		err = led_classdev_register(&client->dev, &ap->mail_led);
 		if (err)
 			goto out4;
 	}
@@ -273,8 +247,6 @@ static int apanel_probe(struct i2c_adapt
 out4:
 	input_unregister_polled_device(ipdev);
 out3:
-	i2c_detach_client(&ap->client);
-out2:
 	input_free_polled_device(ipdev);
 out1:
 	return err;
@@ -301,6 +273,7 @@ static int __init apanel_init(void)
 	void __iomem *bios;
 	const void __iomem *p;
 	u8 devno;
+	unsigned char i2c_addr;
 	int found = 0;
 
 	bios = ioremap(0xF0000, 0x10000); /* Can't fail */
@@ -313,7 +286,7 @@ static int __init apanel_init(void)
 
 	/* just use the first address */
 	p += 8;
-	normal_i2c[0] = readb(p+3) >> 1;
+	i2c_addr = readb(p + 3) >> 1;
 
 	for ( ; (devno = readb(p)) & 0x7f; p += 4) {
 		unsigned char method, slave, chip;
@@ -322,7 +295,7 @@ static int __init apanel_init(void)
 		chip = readb(p + 2);
 		slave = readb(p + 3) >> 1;
 
-		if (slave != normal_i2c[0]) {
+		if (slave != i2c_addr) {
 			pr_notice(APANEL ": only one SMBus slave "
 				  "address supported, skiping device...\n");
 			continue;
--- linux-2.6.28-rc4.orig/drivers/i2c/busses/i2c-i801.c	2008-10-24 09:27:58.000000000 +0200
+++ linux-2.6.28-rc4/drivers/i2c/busses/i2c-i801.c	2008-11-11 18:39:05.000000000 +0100
@@ -64,7 +64,7 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/acpi.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 /* I801 SMBus address offsets */
 #define SMBHSTSTS	(0 + i801_smba)
@@ -583,6 +583,40 @@ static struct pci_device_id i801_ids[] =
 
 MODULE_DEVICE_TABLE (pci, i801_ids);
 
+#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
+static unsigned char apanel_addr;
+
+/* Scan the system ROM for the signature "FJKEYINF" */
+static __init const void __iomem *bios_signature(const void __iomem *bios)
+{
+	ssize_t offset;
+	const unsigned char signature[] = "FJKEYINF";
+
+	for (offset = 0; offset < 0x10000; offset += 0x10) {
+		if (check_signature(bios + offset, signature,
+				    sizeof(signature)-1))
+			return bios + offset;
+	}
+	return NULL;
+}
+
+static void __init input_apanel_init(void)
+{
+	void __iomem *bios;
+	const void __iomem *p;
+
+	bios = ioremap(0xF0000, 0x10000); /* Can't fail */
+	p = bios_signature(bios);
+	if (p) {
+		/* just use the first address */
+		apanel_addr = readb(p + 8 + 3) >> 1;
+	}
+	iounmap(bios);
+}
+#else
+static void __init input_apanel_init(void) {}
+#endif
+
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char temp;
@@ -667,6 +701,19 @@ static int __devinit i801_probe(struct p
 		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
 		goto exit_release;
 	}
+
+	/* Register optional slaves */
+#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
+	if (apanel_addr) {
+		struct i2c_board_info info;
+
+		memset(&info, 0, sizeof(struct i2c_board_info));
+		info.addr = apanel_addr;
+		strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
+		i2c_new_device(&i801_adapter, &info);
+	}
+#endif
+
 	return 0;
 
 exit_release:
@@ -717,6 +764,7 @@ static struct pci_driver i801_driver = {
 
 static int __init i2c_i801_init(void)
 {
+	input_apanel_init();
 	return pci_register_driver(&i801_driver);
 }
 

-- 
Jean Delvare
