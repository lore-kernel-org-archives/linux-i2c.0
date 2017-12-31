From: Darren Stevens <darren@stevens-zone.net>
Subject: [RESEND PATCH] i2c/busses/pasemi: Remove hardcoded bus numbers on
 smbus
Date: Sun, 31 Dec 2017 20:53:55 +0000 (GMT)
Message-ID: <4b3d0f2cad0.58555470@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_BOUNDARY.6c3689407220717c.e5"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:57770 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbdLaWQx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 31 Dec 2017 17:16:53 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c3689407220717c.e5
Content-Type: text/plain

The pasemi smbus controller uses PCI_FUNC(dev->devfn) to define which
number bus to attach to, however this fails when something else is 
probed first, for example an ATI Radeon graphics card will claim 9 or
10 busses, including the ones the pasemi wants.
Patch the driver to call i2c_add_adapter rather than
i2c_add_numbered_adapter.

Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---


----=_BOUNDARY.6c3689407220717c.e5
Content-Type: text/plain;
	name="i2c.patch"
Content-Disposition: attachment;
	filename="i2c.patch";
	size=826

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index df1dbc9..05847fd 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -365,7 +365,6 @@ static int pasemi_smb_probe(struct pci_dev *dev,
 	smbus->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
-	smbus->adapter.nr = PCI_FUNC(dev->devfn);
 
 	/* set up the sysfs linkage to our parent device */
 	smbus->adapter.dev.parent = &dev->dev;
@@ -373,7 +372,7 @@ static int pasemi_smb_probe(struct pci_dev *dev,
 	reg_write(smbus, REG_CTL, (CTL_MTR | CTL_MRR |
 		  (CLK_100K_DIV & CTL_CLK_M)));
 
-	error = i2c_add_numbered_adapter(&smbus->adapter);
+	error = i2c_add_adapter(&smbus->adapter);
 	if (error)
 		goto out_release_region;
 

----=_BOUNDARY.6c3689407220717c.e5--
