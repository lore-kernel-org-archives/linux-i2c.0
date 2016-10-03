From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v4 4/7] i2c: bcm2835: Can't support I2C_M_IGNORE_NAK
Date: Mon,  3 Oct 2016 22:06:11 +0200
Message-ID: <1475525174-28604-5-git-send-email-noralf@tronnes.org>
References: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:39204 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753076AbcJCUGo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Oct 2016 16:06:44 -0400
In-Reply-To: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

The controller can't support this flag, so remove it.

Documentation/i2c/i2c-protocol states that all of the message is sent:

I2C_M_IGNORE_NAK:
    Normally message is interrupted immediately if there is [NA] from the
    client. Setting this flag treats any [NA] as [A], and all of
    message is sent.

>From the BCM2835 ARM Peripherals datasheet:

    The ERR field is set when the slave fails to acknowledge either
    its address or a data byte written to it.

So when the controller doesn't receive an ack, it sets ERR and raises
an interrupt. In other words, the whole message is not sent.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 54d510a..565ef69 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -212,10 +212,6 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
 	if (likely(!i2c_dev->msg_err))
 		return 0;
 
-	if ((i2c_dev->msg_err & BCM2835_I2C_S_ERR) &&
-	    (msg->flags & I2C_M_IGNORE_NAK))
-		return 0;
-
 	dev_dbg(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);
 
 	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
-- 
2.8.2
