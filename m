From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/5] i2c: davinci: query STP always when NACK is received
Date: Thu, 20 Nov 2014 12:03:05 +0200
Message-ID: <1416477788-5544-3-git-send-email-grygorii.strashko@ti.com>
References: <1416477788-5544-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416477788-5544-1-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

According to I2C specification the NACK should be handled as folowing:
"When SDA remains HIGH during this ninth clock pulse, this is defined as the Not
Acknowledge signal. The master can then gene rate either a STOP condition to
abort the transfer, or a repeated START condition to start a new transfer."
[http://www.nxp.com/documents/user_manual/UM10204.pdf]

The same is recomened by TI I2C wiki:
 http://processors.wiki.ti.com/index.php/I2C_Tips

Currently, the Davinci I2C driver interrupts I2C trunsfer in case of NACK, but
It queries Stop condition DAVINCI_I2C_MDR_REG.STP=1 only if NACK has been received
during the last message transmitting/recieving.
This may lead to Bus stuck in "Bus Busy" until I2C IP reset (idle/enable) if
during SMBus reading transaction the first I2C message is NACKed.

Hence, fix it by querying Stop condition (STP) always when NACK is received.

This patch fixes Davinci I2C in the same way it was done for OMAP I2C
commit cda2109a26eb ("i2c: omap: query STP always when NACK is received").

More info can be found at:
https://lkml.org/lkml/2013/7/16/159
http://patchwork.ozlabs.org/patch/249790/

CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Reported-by: Hein Tibosch <hein_tibosch-mRCrAkd8dF0@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 9bbfb8f..2cef115 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -411,11 +411,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	if (dev->cmd_err & DAVINCI_I2C_STR_NACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return msg->len;
-		if (stop) {
-			w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-			w |= DAVINCI_I2C_MDR_STP;
-			davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
-		}
+		w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
+		w |= DAVINCI_I2C_MDR_STP;
+		davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
 		return -EREMOTEIO;
 	}
 	return -EIO;
-- 
1.9.1
