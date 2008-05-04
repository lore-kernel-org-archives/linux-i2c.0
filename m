From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-piix4: Blacklist two mainboards
Date: Sun, 4 May 2008 14:57:17 +0200
Message-ID: <20080504145717.75063c54@hyperion.delvare>
References: <481B851A.10800@ag-web.biz>
	<20080503091831.30cef838@hyperion.delvare>
	<1209828454.4289.1.camel@debian-9850.ag-home.muc>
	<20080503182701.58a0c146@hyperion.delvare>
	<20080503201659.2ab17cbc@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080503201659.2ab17cbc-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

We had a report that running sensors-detect on a Sapphire AM2RD790
motherbord killed the CPU. While the exact cause is still unknown,
I'd rather play it safe and prevent any access to the SMBus on that
machine by not letting the i2c-piix4 driver attach to the SMBus host
device on that machine. Also blacklist a similar board made by DFI.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Updated to also blacklist the DFI Lanparty UT 790FX, as it has the same
issue.

 drivers/i2c/busses/i2c-piix4.c |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- linux-2.6.25.orig/drivers/i2c/busses/i2c-piix4.c	2008-04-19 11:11:56.000000000 +0200
+++ linux-2.6.25/drivers/i2c/busses/i2c-piix4.c	2008-05-04 09:44:42.000000000 +0200
@@ -108,7 +108,25 @@ static unsigned short piix4_smba;
 static struct pci_driver piix4_driver;
 static struct i2c_adapter piix4_adapter;
 
-static struct dmi_system_id __devinitdata piix4_dmi_table[] = {
+static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] = {
+	{
+		.ident = "Sapphire AM2RD790",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "SAPPHIRE Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "PC-AM2RD790"),
+		},
+		.ident = "DFI Lanparty UT 790FX",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "DFI Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "LP UT 790FX"),
+		},
+	},
+	{ }
+};
+
+/* The IBM entry is in a separate table because we only check it
+   on Intel-based systems */
+static struct dmi_system_id __devinitdata piix4_dmi_ibm[] = {
 	{
 		.ident = "IBM",
 		.matches = { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
@@ -123,8 +141,16 @@ static int __devinit piix4_setup(struct 
 
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
+	/* On some motherboards, it was reported that accessing the SMBus
+	   caused severe hardware problems */
+	if (dmi_check_system(piix4_dmi_blacklist)) {
+		dev_err(&PIIX4_dev->dev,
+			"Accessing the SMBus on this system is unsafe!\n");
+		return -EPERM;
+	}
+
 	/* Don't access SMBus on IBM systems which get corrupted eeproms */
-	if (dmi_check_system(piix4_dmi_table) &&
+	if (dmi_check_system(piix4_dmi_ibm) &&
 			PIIX4_dev->vendor == PCI_VENDOR_ID_INTEL) {
 		dev_err(&PIIX4_dev->dev, "IBM system detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
