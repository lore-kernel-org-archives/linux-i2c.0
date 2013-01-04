From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/6] Add SIS964 bus support to i2c-sis630.
Date: Fri,  4 Jan 2013 14:13:30 +0100
Message-ID: <1357305215-17643-2-git-send-email-amaury.decreme@gmail.com>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
 <1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357305215-17643-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/i2c/busses/i2c-sis630 |    9 ++++
 drivers/i2c/busses/Kconfig          |    4 +-
 drivers/i2c/busses/i2c-sis630.c     |   88 +++++++++++++++++++++++----=
--------
 3 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-sis630 b/Documentation/i2c/bu=
sses/i2c-sis630
index 0b96973..ee79436 100644
--- a/Documentation/i2c/busses/i2c-sis630
+++ b/Documentation/i2c/busses/i2c-sis630
@@ -4,9 +4,11 @@ Supported adapters:
   * Silicon Integrated Systems Corp (SiS)
 	630 chipset (Datasheet: available at http://www.sfr-fresh.com/linux)
 	730 chipset
+	964 chipset
   * Possible other SiS chipsets ?
=20
 Author: Alexander Malysh <amalysh-S0/GAf8tV78@public.gmane.org>
+	Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> - SiS964 support
=20
 Module Parameters
 -----------------
@@ -18,6 +20,7 @@ Module Parameters
 * high_clock =3D [1|0] Forcibly set Host Master Clock to 56KHz (defaul=
t,
 			what your BIOS use). DANGEROUS! This should be a bit
 			faster, but freeze some systems (i.e. my Laptop).
+			SIS630/730 chip only.
=20
=20
 Description
@@ -36,6 +39,12 @@ or like this:
 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02=
)
 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
=20
+or like this:
+
+00:00.0 Host bridge: Silicon Integrated Systems [SiS] 760/M760 Host (r=
ev 02)
+00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS964 [MuTIOL Me=
dia IO]
+							LPC Controller (rev 36)
+
 in your 'lspci' output , then this driver is for your chipset.
=20
 Thank You
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index bdca511..69a59a5 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -186,11 +186,11 @@ config I2C_SIS5595
 	  will be called i2c-sis5595.
=20
 config I2C_SIS630
-	tristate "SiS 630/730"
+	tristate "SiS 630/730/964"
 	depends on PCI
 	help
 	  If you say yes to this option, support will be included for the
-	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
+	  SiS630, SiS730 and SiS964 SMBus (a subset of I2C) interface.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-sis630.
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index de6dddb..df8e20a 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -41,6 +41,20 @@
    Supports:
 	SIS 630
 	SIS 730
+	SIS 964
+
+   Notable differences between chips:
+	+------------------------+--------------------+-------------------+
+	|                        |     SIS630/730     |      SIS964       |
+	+------------------------+--------------------+-------------------+
+	| Clock                  | 14kHz/56kHz        | 55.56kHz/27.78kHz |
+	| SMBus registers offset | 0x80               | 0xE0              |
+	| SMB_CNT                | Bit 1 =3D Slave Busy | Bit 1 =3D Bus probe=
 |
+	|         (not used yet) | Bit 3 is reserved  | Bit 3 =3D Last byte |
+	| SMB_PCOUNT		 | Offset + 0x06      | Offset + 0x14     |
+	| SMB_COUNT              | 4:0 bits           | 5:0 bits          |
+	+------------------------+--------------------+-------------------+
+	(Other differences don't affect the functions provided by the driver)
=20
    Note: we assume there can only be one device, with one SMBus interf=
ace.
 */
@@ -55,22 +69,21 @@
 #include <linux/acpi.h>
 #include <linux/io.h>
=20
-/* SIS630 SMBus registers */
-#define SMB_STS			0x80	/* status */
-#define SMB_EN			0x81	/* status enable */
-#define SMB_CNT			0x82
-#define SMBHOST_CNT		0x83
-#define SMB_ADDR		0x84
-#define SMB_CMD			0x85
-#define SMB_PCOUNT		0x86	/* processed count */
-#define SMB_COUNT		0x87
-#define SMB_BYTE		0x88	/* ~0x8F data byte field */
-#define SMBDEV_ADDR		0x90
-#define SMB_DB0			0x91
-#define SMB_DB1			0x92
-#define SMB_SAA			0x93
-
-/* register count for request_region */
+/* SIS964 id is defined here as we are the only file using it */
+#define PCI_DEVICE_ID_SI_964	0x0964
+
+/* SIS630/730/964 SMBus registers */
+#define SMB_STS			0x00	/* status */
+#define SMB_CNT			0x02	/* control */
+#define SMBHOST_CNT		0x03	/* host control */
+#define SMB_ADDR		0x04	/* address */
+#define SMB_CMD			0x05	/* command */
+#define SMB_COUNT		0x07	/* byte count */
+#define SMB_BYTE		0x08	/* ~0x8F data byte field */
+
+/* register count for request_region
+ * As we don't use SMB_PCOUNT, 20 is ok for SiS630 and SiS964
+ */
 #define SIS630_SMB_IOREGION	20
=20
 /* PCI address constants */
@@ -96,28 +109,30 @@ static struct pci_driver sis630_driver;
 static bool high_clock;
 static bool force;
 module_param(high_clock, bool, 0);
-MODULE_PARM_DESC(high_clock, "Set Host Master Clock to 56KHz (default =
14KHz).");
+MODULE_PARM_DESC(high_clock,
+	"Set Host Master Clock to 56KHz (default 14KHz) (SIS630/730 only).");
 module_param(force, bool, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the SIS630. DANGEROUS!");
=20
-/* acpi base address */
-static unsigned short acpi_base;
+/* SMBus base adress */
+static unsigned short smbus_base;
=20
 /* supported chips */
 static int supported[] =3D {
 	PCI_DEVICE_ID_SI_630,
 	PCI_DEVICE_ID_SI_730,
+	PCI_DEVICE_ID_SI_760,
 	0 /* terminates the list */
 };
=20
 static inline u8 sis630_read(u8 reg)
 {
-	return inb(acpi_base + reg);
+	return inb(smbus_base + reg);
 }
=20
 static inline void sis630_write(u8 reg, u8 data)
 {
-	outb(data, acpi_base + reg);
+	outb(data, smbus_base + reg);
 }
=20
 static int sis630_transaction_start(struct i2c_adapter *adap, int size=
, u8 *oldclock)
@@ -394,6 +409,8 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 	unsigned char b;
 	struct pci_dev *dummy =3D NULL;
 	int retval, i;
+	/* acpi base address */
+	unsigned short acpi_base;
=20
 	/* check for supported SiS devices */
 	for (i=3D0; supported[i] > 0 ; i++) {
@@ -438,16 +455,25 @@ static int sis630_setup(struct pci_dev *sis630_de=
v)
=20
 	dev_dbg(&sis630_dev->dev, "ACPI base at 0x%04x\n", acpi_base);
=20
-	retval =3D acpi_check_region(acpi_base + SMB_STS, SIS630_SMB_IOREGION=
,
+	if (supported[i] =3D=3D PCI_DEVICE_ID_SI_760)
+		smbus_base =3D acpi_base + 0xE0;
+	else
+		smbus_base =3D acpi_base + 0x80;
+
+	dev_dbg(&sis630_dev->dev, "SMBus base at 0x%04hx\n", smbus_base);
+
+	retval =3D acpi_check_region(smbus_base + SMB_STS, SIS630_SMB_IOREGIO=
N,
 				   sis630_driver.name);
 	if (retval)
 		goto exit;
=20
 	/* Everything is happy, let's grab the memory and set things up. */
-	if (!request_region(acpi_base + SMB_STS, SIS630_SMB_IOREGION,
+	if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
 			    sis630_driver.name)) {
-		dev_err(&sis630_dev->dev, "SMBus registers 0x%04x-0x%04x already "
-			"in use!\n", acpi_base + SMB_STS, acpi_base + SMB_SAA);
+		dev_err(&sis630_dev->dev,
+			"I/O Region 0x%04hx-0x%04hx for SMBus already in use.\n",
+			smbus_base + SMB_STS,
+			smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
 		retval =3D -EBUSY;
 		goto exit;
 	}
@@ -456,7 +482,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
=20
 exit:
 	if (retval)
-		acpi_base =3D 0;
+		smbus_base =3D 0;
 	return retval;
 }
=20
@@ -470,11 +496,13 @@ static struct i2c_adapter sis630_adapter =3D {
 	.owner		=3D THIS_MODULE,
 	.class		=3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.algo		=3D &smbus_algorithm,
+	.retries	=3D 3
 };
=20
 static DEFINE_PCI_DEVICE_TABLE(sis630_ids) =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_LPC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_964) },
 	{ 0, }
 };
=20
@@ -491,17 +519,17 @@ static int sis630_probe(struct pci_dev *dev, cons=
t struct pci_device_id *id)
 	sis630_adapter.dev.parent =3D &dev->dev;
=20
 	snprintf(sis630_adapter.name, sizeof(sis630_adapter.name),
-		 "SMBus SIS630 adapter at %04x", acpi_base + SMB_STS);
+		 "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
=20
 	return i2c_add_adapter(&sis630_adapter);
 }
=20
 static void sis630_remove(struct pci_dev *dev)
 {
-	if (acpi_base) {
+	if (smbus_base) {
 		i2c_del_adapter(&sis630_adapter);
-		release_region(acpi_base + SMB_STS, SIS630_SMB_IOREGION);
-		acpi_base =3D 0;
+		release_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION);
+		smbus_base =3D 0;
 	}
 }
=20
--=20
1.7.8.6
