From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 07/12] i2c: meson: improve interrupt handler and detect
 spurious interrupts
Date: Wed, 8 Mar 2017 07:47:16 +0100
Message-ID: <c772d1d8-eaae-43c2-c206-7c349c134db8@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36049 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756730AbdCHGus (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 01:50:48 -0500
Received: by mail-wr0-f195.google.com with SMTP id l37so2832526wrc.3
        for <linux-i2c@vger.kernel.org>; Tue, 07 Mar 2017 22:50:45 -0800 (PST)
In-Reply-To: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

If state is STATE_IDLE no interrupt should occur. Detect this case and
warn.
In addition move resetting REG_CTRL_START bit to the start of the
interrupt handler and remove a unneeded REG_CTRL_START bit reset
in meson_i2c_xfer_msg.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/i2c/busses/i2c-meson.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 81304840..b3b881f9 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -233,7 +233,15 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 	dev_dbg(i2c->dev, "irq: state %d, pos %d, count %d, ctrl %08x\n",
 		i2c->state, i2c->pos, i2c->count, ctrl);
 
-	if (ctrl & REG_CTRL_ERROR && i2c->state != STATE_IDLE) {
+	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
+
+	if (i2c->state == STATE_IDLE) {
+		dev_notice(i2c->dev, "spurious interrupt detected\n");
+		spin_unlock(&i2c->lock);
+		return IRQ_NONE;
+	}
+
+	if (ctrl & REG_CTRL_ERROR) {
 		/*
 		 * The bit is set when the IGNORE_NAK bit is cleared
 		 * and the device didn't respond. In this case, the
@@ -276,15 +284,12 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 		i2c->state = STATE_IDLE;
 		complete(&i2c->done);
 		break;
-	case STATE_IDLE:
-		break;
 	}
 
 out:
 	if (i2c->state != STATE_IDLE) {
 		/* Restart the processing */
 		meson_i2c_write_tokens(i2c);
-		meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
 		meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START,
 				   REG_CTRL_START);
 	}
@@ -344,9 +349,6 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
 	 */
 	spin_lock_irqsave(&i2c->lock, flags);
 
-	/* Abort any active operation */
-	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
-
 	if (!time_left) {
 		i2c->state = STATE_IDLE;
 		ret = -ETIMEDOUT;
-- 
2.12.0
