From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 3/3] i2c-piix4: Pre-shift the port number
Date: Fri, 29 Jan 2016 10:46:37 +0100
Message-ID: <20160129104637.582b95ea@endymion.delvare>
References: <20160129104146.50f06562@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59298 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbcA2Jqk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 04:46:40 -0500
In-Reply-To: <20160129104146.50f06562@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

Shift the port number at initialization time, so that it is ready to
use at run time. That way we don't have to do it again for every SMBus
transaction.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Christian Fetzer <fetzer.ch@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-piix4.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-29 07:57:13.706365999 +0100
+++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-29 10:38:34.720453729 +0100
@@ -158,7 +158,7 @@ struct i2c_piix4_adapdata {
 
 	/* SB800 */
 	bool sb800_main;
-	u8 port;
+	u8 port;		/* Port number, shifted */
 };
 
 static int piix4_setup(struct pci_dev *PIIX4_dev,
@@ -589,8 +589,8 @@ static s32 piix4_access_sb800(struct i2c
 	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
 
 	port = adapdata->port;
-	if ((smba_en_lo & SB800_PIIX4_PORT_IDX_MASK) != (port << 1))
-		outb_p((smba_en_lo & ~SB800_PIIX4_PORT_IDX_MASK) | (port << 1),
+	if ((smba_en_lo & SB800_PIIX4_PORT_IDX_MASK) != port)
+		outb_p((smba_en_lo & ~SB800_PIIX4_PORT_IDX_MASK) | port,
 		       SB800_PIIX4_SMB_IDX + 1);
 
 	retval = piix4_access(adap, addr, flags, read_write,
@@ -676,7 +676,7 @@ static int piix4_add_adapter(struct pci_
 
 	adapdata->smba = smba;
 	adapdata->sb800_main = sb800_main;
-	adapdata->port = port;
+	adapdata->port = port << 1;
 
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
@@ -812,7 +812,7 @@ static void piix4_adap_remove(struct i2c
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		if (adapdata->port == 0) {
+		if (adapdata->port == (0 << 1)) {
 			release_region(adapdata->smba, SMBIOSIZE);
 			if (adapdata->sb800_main)
 				release_region(SB800_PIIX4_SMB_IDX, 2);

-- 
Jean Delvare
SUSE L3 Support
