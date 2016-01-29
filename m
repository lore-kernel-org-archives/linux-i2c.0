From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 2/3] i2c-piix4: Always use the same type for port
Date: Fri, 29 Jan 2016 10:45:30 +0100
Message-ID: <20160129104530.1ba78e8b@endymion.delvare>
References: <20160129104146.50f06562@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59254 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbcA2Jpd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 04:45:33 -0500
In-Reply-To: <20160129104146.50f06562@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

Sometimes u8 is used to store the port number, sometimes unsigned
short is used. Consistently stick to a single type, for consistency
and to avoid implicit casts.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Christian Fetzer <fetzer.ch@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-piix4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-29 07:54:35.135765313 +0100
+++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-29 07:57:13.706365999 +0100
@@ -158,7 +158,7 @@ struct i2c_piix4_adapdata {
 
 	/* SB800 */
 	bool sb800_main;
-	unsigned short port;
+	u8 port;
 };
 
 static int piix4_setup(struct pci_dev *PIIX4_dev,
@@ -649,7 +649,7 @@ static struct i2c_adapter *piix4_main_ad
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
-			     bool sb800_main, unsigned short port,
+			     bool sb800_main, u8 port,
 			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;

-- 
Jean Delvare
SUSE L3 Support
