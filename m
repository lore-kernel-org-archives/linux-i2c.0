From: Pierre-Yves Rofes <py.rofes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-ali1535: enable SPARC support
Date: Mon, 21 Nov 2011 21:06:53 +0100
Message-ID: <4ECAAF5D.3010502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(sorry if you get this mail twice, but apparently my first try failed
because attachments are forbidden...)

On Mon, 31 Oct 2011 10:52:07 +0100, Jean Delvare wrote:
>On Mon, 5 Sep 2011 10:15:00 +0200, Jean Delvare wrote:
>> Please adjust these small mistakes, resend, and I'll be happy to take
>> your patch in kernel 3.2.
>
>Corentin, any update for this patch?

Hi,

I found this thread when googling for sun blade 100 sensors.

I applied your suggestions on Corentin's patch, and it works great
on my Sun Blade 100 too, with kernel 3.1.1:

% sensors
adm1023-i2c-0-18
Adapter: SMBus ALI1535 adapter at 1fe02000600
temp1: +28.0 C (low = -55.0 C, high = +127.0 C)
temp2: +59.0 C (low = -55.0 C, high = +127.0 C)

Hopefully the patch can make its way into a future kernel
so I don't need to maintain it next time I upgrade.

Thanks,

-- 
Pierre-Yves Rofes

--- linux/drivers/i2c/busses/i2c-ali1535.c.orig	2011-10-24
09:10:05.000000000 +0200

+++ linux/drivers/i2c/busses/i2c-ali1535.c	2011-11-19 23:28:31.000000000
+0100
@@ -132,7 +132,7 @@
 #define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable		*/

 static struct pci_driver ali1535_driver;
-static unsigned short ali1535_smba;

+static unsigned long ali1535_smba;

 /* Detect whether a ALI1535 can be found, and initialize it, where
necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -142,6 +142,7 @@

 {
 	int retval = -ENODEV;
 	unsigned char temp;
+	unsigned short offset;

 	/* Check the following things:
 		- SMB I/O address is initialized
@@ -149,15 +150,28 @@
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
+	pci_read_config_word(dev, SMBBA, &offset);
+	dev_dbg(&dev->dev, "ALI1535_smb is at offset 0x%04x", offset);

+	offset &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	if (offset == 0) {
 		dev_warn(&dev->dev,
 			"ALI1535_smb region uninitialized - upgrade BIOS?\n");
 		goto exit;
 	}

+	if ((pci_resource_flags(dev, 0) & IORESOURCE_IO) == 0) {

+		dev_err(&dev->dev, "ALI1535_smb bar 0 is not IORESOURCE_IO\n");
+		goto exit;
+	}
+	ali1535_smba = pci_resource_start(dev, 0) + offset;
+
 	retval = acpi_check_region(ali1535_smba, ALI1535_SMB_IOSIZE,

 				   ali1535_driver.name);
 	if (retval)
@@ -165,7 +179,7 @@

 	if (!request_region(ali1535_smba, ALI1535_SMB_IOSIZE,
 			    ali1535_driver.name)) {

-		dev_err(&dev->dev, "ALI1535_smb region 0x%x already in use!\n",
+		dev_err(&dev->dev, "ALI1535_smb region 0x%lx already in use!\n",
 			ali1535_smba);
 		goto exit;
 	}

@@ -196,7 +210,7 @@
 	*/
 	pci_read_config_byte(dev, SMBREV, &temp);
 	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&dev->dev, "ALI1535_smba = 0x%X\n", ali1535_smba);

+	dev_dbg(&dev->dev, "ALI1535_smba = 0x%lx\n", ali1535_smba);

 	retval = 0;
 exit:
@@ -498,7 +512,7 @@
 	ali1535_adapter.dev.parent = &dev->dev;

 	snprintf(ali1535_adapter.name, sizeof(ali1535_adapter.name),

-		"SMBus ALI1535 adapter at %04x", ali1535_smba);
+		"SMBus ALI1535 adapter at %04lx", ali1535_smba);
 	return i2c_add_adapter(&ali1535_adapter);
 }
