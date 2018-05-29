From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 4/6] i2c: rcar: remove spinlock
Date: Tue, 29 May 2018 14:33:14 +0100
Message-ID: <1527600796-25901-5-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ff2316b87a336bff940939cd9fc56287ed48e578 upstream.

After making sure to reinit the HW and clear interrupts in the timeout
case, we know that interrupts are always disabled in the sections
protected by the spinlock. Thus, we can simply remove it which is a
preparation for further refactoring. While here, rename the timeout
variable to time_left which is way more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[fabrizio: cherry-pick to 4.4]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 7510733..46b6a5f 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -33,7 +33,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 
 /* register offsets */
 #define ICSCR	0x00	/* slave ctrl */
@@ -110,7 +109,6 @@ struct rcar_i2c_priv {
 	struct i2c_msg	*msg;
 	struct clk *clk;
 
-	spinlock_t lock;
 	wait_queue_head_t wait;
 
 	int pos;
@@ -429,9 +427,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	irqreturn_t result = IRQ_HANDLED;
 	u32 msr;
 
-	/*-------------- spin lock -----------------*/
-	spin_lock(&priv->lock);
-
 	if (rcar_i2c_slave_irq(priv))
 		goto exit;
 
@@ -478,9 +473,6 @@ out:
 	}
 
 exit:
-	spin_unlock(&priv->lock);
-	/*-------------- spin unlock -----------------*/
-
 	return result;
 }
 
@@ -490,9 +482,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
-	unsigned long flags;
 	int i, ret;
-	long timeout;
+	long time_left;
 
 	pm_runtime_get_sync(dev);
 
@@ -507,9 +498,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		/*-------------- spin lock -----------------*/
-		spin_lock_irqsave(&priv->lock, flags);
-
 		/* init each data */
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
@@ -519,13 +507,11 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 		rcar_i2c_prepare_msg(priv);
 
-		spin_unlock_irqrestore(&priv->lock, flags);
-		/*-------------- spin unlock -----------------*/
-
-		timeout = wait_event_timeout(priv->wait,
+		time_left = wait_event_timeout(priv->wait,
 					     rcar_i2c_flags_has(priv, ID_DONE),
 					     adap->timeout);
-		if (!timeout) {
+		if (!time_left) {
+			rcar_i2c_init(priv);
 			ret = -ETIMEDOUT;
 			break;
 		}
@@ -656,7 +642,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
-	spin_lock_init(&priv->lock);
 
 	adap = &priv->adap;
 	adap->nr = pdev->id;
-- 
2.7.4
