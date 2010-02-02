From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c/highlander: remover superflous variable
Date: Tue,  2 Feb 2010 13:17:43 +0100
Message-ID: <1265113063-22894-1-git-send-email-w.sang@pengutronix.de>
References: <20100201101509.GB3288@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100201101509.GB3288-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When cppcheck found this flaw

[./i2c/busses/i2c-highlander.c:284]: (style) Warning - using char variable in bit operation

it was noted that the 'read'-variable could just be removed as read_write can
only be 0 or 1 anyhow. So, we remove the flaw by simplifying the code.

Reported-by: d binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---

There was no patch following the original report, so I picked it up. Not
tested, due to no hardware.

Jean, I put you on CC as you commented on the original mail, although it is
more an embedded driver.

 drivers/i2c/busses/i2c-highlander.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c-highlander.c
index 87ecace..db290b9 100644
--- a/drivers/i2c/busses/i2c-highlander.c
+++ b/drivers/i2c/busses/i2c-highlander.c
@@ -281,7 +281,6 @@ static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 				  union i2c_smbus_data *data)
 {
 	struct highlander_i2c_dev *dev = i2c_get_adapdata(adap);
-	int read = read_write & I2C_SMBUS_READ;
 	u16 tmp;
 
 	init_completion(&dev->cmd_complete);
@@ -336,11 +335,11 @@ static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 	highlander_i2c_done(dev);
 
 	/* Set slave address */
-	iowrite16((addr << 1) | read, dev->base + SMSMADR);
+	iowrite16((addr << 1) | read_write, dev->base + SMSMADR);
 
 	highlander_i2c_command(dev, command, dev->buf_len);
 
-	if (read)
+	if (read_write)
 		return highlander_i2c_read(dev);
 	else
 		return highlander_i2c_write(dev);
-- 
1.6.5
