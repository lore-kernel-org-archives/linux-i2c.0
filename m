From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v3] i2c-ali1535: enable SPARC support
Date: Fri, 25 Nov 2011 14:23:51 +0100
Message-ID: <20111125142351.739f6b89@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Pierre-Yves Rofes <py.rofes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Corentin Labbe <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "corentin.labbe" <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>

The i2c-ali1535 driver don't work on SPARC, this is because it assumes that ioport address are 16bits wide (address stored with an unsigned short).
But on SPARC arch, ioports are mapped in memory and so are stored with an unsigned long.

This patch corrects this by using pci_resource_start for getting IOMEM base address, then reading the SMBBA of the i2c busse and using together for I/O access.

I like to thanks Jean DELVARE for reviewing of my patch.

Signed-off-by: LABBE Corentin <corentin.labbe-Um+J1D3rkBVWj0EZb7rXcA@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
Corentin, I rebased your patch so that it applies on top of the fix I
just sent. I also turned one dev_info into dev_dbg, and relaxed the
check on the PCI resource flags: I have no idea if the resource is
always defined, in particular on x86, and as it will be difficult to
find testers, I want to play it safe and guarantee that the driver will
behave the same way it used to before your patch.

Corentin, Pierre-Yves, please test this version of the patch on top of
the fix I just sent, and confirm that it works for you.

If anybody is using the i2c-ali1535 driver on x86, please test too and
report. I can provide a standalone driver if needed.

 drivers/i2c/busses/i2c-ali1535.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

--- linux-3.2-rc3.orig/drivers/i2c/busses/i2c-ali1535.c	2011-11-25 13:54:48.000000000 +0100
+++ linux-3.2-rc3/drivers/i2c/busses/i2c-ali1535.c	2011-11-25 14:12:46.000000000 +0100
@@ -132,7 +132,8 @@
 #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/
 
 static struct pci_driver ali1535_driver;
-static unsigned short ali1535_smba;
+static unsigned long ali1535_smba;
+static unsigned short ali1535_offset;
 
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -149,16 +150,28 @@ static int __devinit ali1535_setup(struc
 		- We can use the addresses
 	*/
 
+	retval = pci_enable_device(dev);
+	if (retval) {
+		dev_err(&dev->dev, "ALI1535_smb can't enable device\n");
+		goto exit;
+	}
+
 	/* Determine the address of the SMBus area */
-	pci_read_config_word(dev, SMBBA, &ali1535_smba);
-	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
-	if (ali1535_smba == 0) {
+	pci_read_config_word(dev, SMBBA, &ali1535_offset);
+	dev_dbg(&dev->dev, "ALI1535_smb is at offset 0x%04x\n", ali1535_offset);
+	ali1535_offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	if (ali1535_offset == 0) {
 		dev_warn(&dev->dev,
 			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
 		retval = -ENODEV;
 		goto exit;
 	}
 
+	if (pci_resource_flags(dev, 0) & IORESOURCE_IO)
+		ali1535_smba = pci_resource_start(dev, 0) + ali1535_offset;
+	else
+		ali1535_smba = ali1535_offset;
+
 	retval = acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 				   ali1535_driver.name);
 	if (retval)
@@ -166,7 +179,7 @@ static int __devinit ali1535_setup(struc
 
 	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 			    ali1535_driver.name)) {
-		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
+		dev_err(&dev->dev, "ALI1535_smb region 0x%lx already in use!\n",
 			ali1535_smba);
 		retval = -EBUSY;
 		goto exit;
@@ -200,7 +213,7 @@ static int __devinit ali1535_setup(struc
 	*/
 	pci_read_config_byte(dev, SMBREV, &temp);
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);
+	dev_dbg(&dev->dev, "ALI1535_smba = 0x%lx\n", ali1535_smba);
 
 	return 0;
 
@@ -501,7 +514,7 @@ static int __devinit ali1535_probe(struc
 	ali1535_adapter.dev.parent = &dev->dev;
 
 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),
-		"SMBus ALI1535 adapter at %04x", ali1535_smba);
+		"SMBus ALI1535 adapter at %04x", ali1535_offset);
 	return i2c_add_adapter(&ali1535_adapter);
 }
 


-- 
Jean Delvare
