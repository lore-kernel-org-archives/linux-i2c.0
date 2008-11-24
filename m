From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Use snprintf to set adapter names
Date: Mon, 24 Nov 2008 18:58:22 +0100
Message-ID: <20081124185822.0e4302fc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use snprintf instead of sprintf to set adapter names, it's safer.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-ali1563.c      |    4 ++--
 drivers/i2c/busses/i2c-amd756-s4882.c |    4 ++--
 drivers/i2c/busses/i2c-amd756.c       |    5 +++--
 drivers/i2c/busses/i2c-at91.c         |    2 +-
 drivers/i2c/busses/i2c-sis5595.c      |    4 ++--
 drivers/i2c/busses/i2c-sis630.c       |    4 ++--
 6 files changed, 12 insertions(+), 11 deletions(-)

--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-ali1563.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-ali1563.c	2008-11-24 18:46:28.000000000 +0100
@@ -399,8 +399,8 @@ static int __devinit ali1563_probe(struc
 	if ((error = ali1563_setup(dev)))
 		goto exit;
 	ali1563_adapter.dev.parent = &dev->dev;
-	sprintf(ali1563_adapter.name,"SMBus ALi 1563 Adapter @ %04x",
-		ali1563_smba);
+	snprintf(ali1563_adapter.name, sizeof(ali1563_adapter.name),
+		 "SMBus ALi 1563 Adapter @ %04x", ali1563_smba);
 	if ((error = i2c_add_adapter(&ali1563_adapter)))
 		goto exit_shutdown;
 	return 0;
--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-amd756-s4882.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-amd756-s4882.c	2008-11-24 18:46:09.000000000 +0100
@@ -197,8 +197,8 @@ static int __init amd756_s4882_init(void
 	for (i = 1; i < 5; i++) {
 		s4882_algo[i] = *(amd756_smbus.algo);
 		s4882_adapter[i] = amd756_smbus;
-		sprintf(s4882_adapter[i].name,
-			"SMBus 8111 adapter (CPU%d)", i-1);
+		snprintf(s4882_adapter[i].name, sizeof(s4882_adapter[i].name),
+			 "SMBus 8111 adapter (CPU%d)", i-1);
 		s4882_adapter[i].algo = s4882_algo+i;
 		s4882_adapter[i].dev.parent = amd756_smbus.dev.parent;
 	}
--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-amd756.c	2008-10-24 09:27:57.000000000 +0200
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-amd756.c	2008-11-24 18:45:43.000000000 +0100
@@ -380,8 +380,9 @@ static int __devinit amd756_probe(struct
 	/* set up the sysfs linkage to our parent device */
 	amd756_smbus.dev.parent = &pdev->dev;
 
-	sprintf(amd756_smbus.name, "SMBus %s adapter at %04x",
-		chipname[id->driver_data], amd756_ioport);
+	snprintf(amd756_smbus.name, sizeof(amd756_smbus.name),
+		 "SMBus %s adapter at %04x", chipname[id->driver_data],
+		 amd756_ioport);
 
 	error = i2c_add_adapter(&amd756_smbus);
 	if (error) {
--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-at91.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-at91.c	2008-11-24 18:45:08.000000000 +0100
@@ -222,7 +222,7 @@ static int __devinit at91_i2c_probe(stru
 		rc = -ENOMEM;
 		goto fail2;
 	}
-	sprintf(adapter->name, "AT91");
+	snprintf(adapter->name, sizeof(adapter->name), "AT91");
 	adapter->algo = &at91_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 	adapter->dev.parent = &pdev->dev;
--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-sis5595.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-sis5595.c	2008-11-24 18:44:46.000000000 +0100
@@ -389,8 +389,8 @@ static int __devinit sis5595_probe(struc
 	/* set up the sysfs linkage to our parent device */
 	sis5595_adapter.dev.parent = &dev->dev;
 
-	sprintf(sis5595_adapter.name, "SMBus SIS5595 adapter at %04x",
-		sis5595_base + SMB_INDEX);
+	snprintf(sis5595_adapter.name, sizeof(sis5595_adapter.name),
+		 "SMBus SIS5595 adapter at %04x", sis5595_base + SMB_INDEX);
 	err = i2c_add_adapter(&sis5595_adapter);
 	if (err) {
 		release_region(sis5595_base + SMB_INDEX, 2);
--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-sis630.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-sis630.c	2008-11-24 18:51:03.000000000 +0100
@@ -487,8 +487,8 @@ static int __devinit sis630_probe(struct
 	/* set up the sysfs linkage to our parent device */
 	sis630_adapter.dev.parent = &dev->dev;
 
-	sprintf(sis630_adapter.name, "SMBus SIS630 adapter at %04x",
-		acpi_base + SMB_STS);
+	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
+		 "SMBus SIS630 adapter at %04x", acpi_base + SMB_STS);
 
 	return i2c_add_adapter(&sis630_adapter);
 }


-- 
Jean Delvare
