From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 07/10] i2c: meson: improve interrupt handler and detect
 spurious interrupts
Date: Thu, 9 Mar 2017 07:53:26 +0100
Message-ID: <372c966f-253d-fdd0-9675-6f928e02d401@gmail.com>
References: <f39c9314-4314-3d98-aef2-3bc3c815e63b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34687 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdCIHKi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 9 Mar 2017 02:10:38 -0500
Received: by mail-wr0-f194.google.com with SMTP id u48so6764877wrc.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 23:10:37 -0800 (PST)
In-Reply-To: <f39c9314-4314-3d98-aef2-3bc3c815e63b@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

If state is STATE_IDLE no interrupt should occur. Detect this case and
warn.
In addition move resetting REG_CTRL_START bit to the start of the
interrupt handler and remove a unneeded REG_CTRL_START bit reset
in meson_i2c_xfer_msg.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- don't print an error if spurious interrupt is detected
---
 drivers/i2c/busses/i2c-meson.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 56e15a74..74d433cd 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -228,12 +228,18 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
 	spin_lock(&i2c->lock);
 
 	meson_i2c_reset_tokens(i2c);
+	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
 	ctrl = readl(i2c->regs + REG_CTRL);
 
 	dev_dbg(i2c->dev, "irq: state %d, pos %d, count %d, ctrl %08x\n",
 		i2c->state, i2c->pos, i2c->count, ctrl);
 
-	if (ctrl & REG_CTRL_ERROR && i2c->state != STATE_IDLE) {
+	if (i2c->state == STATE_IDLE) {
+		spin_unlock(&i2c->lock);
+		return IRQ_NONE;
+	}
+
+	if (ctrl & REG_CTRL_ERROR) {
 		/*
 		 * The bit is set when the IGNORE_NAK bit is cleared
 		 * and the device didn't respond. In this case, the
@@ -276,15 +282,12 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
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
@@ -344,9 +347,6 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c, struct i2c_msg *msg,
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
