From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 07/10] i2c: meson: improve interrupt handler and detect
 spurious interrupts
Date: Sat, 25 Mar 2017 14:10:08 +0100
Message-ID: <3248cfbd-a6be-06ac-47be-d7f3e8239996@gmail.com>
References: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36083 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdCYNOn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 25 Mar 2017 09:14:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so2846407wmf.3
        for <linux-i2c@vger.kernel.org>; Sat, 25 Mar 2017 06:14:41 -0700 (PDT)
In-Reply-To: <645519b8-93e6-57b1-ae8f-7804c6beb9b1@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org

If state is STATE_IDLE no interrupt should occur. Return IRQ_NONE
if such a spurious interrupt is detected.
Not having to take care of STATE_IDLE later in the interrupt handler
allows to further simplify the interrupt handler in subsequent
patches of this series.

In addition move resetting REG_CTRL_START bit to the start of the
interrupt handler to ensure that the start bit is always reset.
Currently the start bit is not reset for STATE_STOP because
i2c->state is set to STATE_IDLE.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- don't print an error if spurious interrupt is detected
v3:
- don't remove a start bit reset, we need it to properly handle timeouts
- extend commit message
v4:
- no changes
v5:
- no changes
---
 drivers/i2c/busses/i2c-meson.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index f7d3fa32..081d5b0c 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -231,12 +231,18 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
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
@@ -279,15 +285,12 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
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
-- 
2.12.0
