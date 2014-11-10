From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 4/4] i2c-i801: Drop useless debug message
Date: Mon, 10 Nov 2014 22:32:31 +0100
Message-ID: <20141110223231.4e1b70c2@endymion.delvare>
References: <20141110222655.13660613@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141110222655.13660613-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Don't log the host status register value in i801_isr(), it has very
little value and fills up the log when debugging is enabled.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |    3 ---
 1 file changed, 3 deletions(-)

--- linux-3.18-rc4.orig/drivers/i2c/busses/i2c-i801.c	2014-11-10 19:54:05.042326020 +0100
+++ linux-3.18-rc4/drivers/i2c/busses/i2c-i801.c	2014-11-10 19:56:51.562907696 +0100
@@ -507,9 +507,6 @@ static irqreturn_t i801_isr(int irq, voi
 		return IRQ_NONE;
 
 	status = inb_p(SMBHSTSTS(priv));
-	if (status != 0x42)
-		dev_dbg(&priv->pci_dev->dev, "irq: status = %02x\n", status);
-
 	if (status & SMBHSTSTS_BYTE_DONE)
 		i801_isr_byte_done(priv);
 

-- 
Jean Delvare
SUSE L3 Support
