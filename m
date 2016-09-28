From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v3 3/7] i2c: bcm2835: Use dev_dbg logging on transfer errors
Date: Wed, 28 Sep 2016 19:50:52 +0200
Message-ID: <1475085056-5205-4-git-send-email-noralf@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.55]:56033 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbcI1Rvl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Sep 2016 13:51:41 -0400
In-Reply-To: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, swarren@wwwdotorg.org, eric@anholt.net
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>

Writing to an AT24C32 generates on average 2x i2c transfer errors per
32-byte page write. Which amounts to a lot for a 4k write. This is due
to the fact that the chip doesn't respond during it's internal write
cycle when the at24 driver tries and retries the next write.
Only a handful drivers use dev_err() on transfer error, so switch to
dev_dbg() instead.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---

Changes:
- use dev_dbg instead of dev_err_ratelimited

 drivers/i2c/busses/i2c-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index df036ed..8cdb139 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -207,7 +207,7 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
 	    (msg->flags & I2C_M_IGNORE_NAK))
 		return 0;

-	dev_err(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);
+	dev_dbg(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);

 	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
 		return -EREMOTEIO;
--
2.8.2
