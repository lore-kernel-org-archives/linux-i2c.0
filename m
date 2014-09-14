From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2 3/3] i2c-rcar: make rcar_i2c_irq_recv() *void*
Date: Mon, 15 Sep 2014 00:17:34 +0400
Message-ID: <19871938.mRdZLUD6Mv@wasted.cogentembedded.com>
References: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

rcar_i2c_irq_recv() always returns 0, so we can make this function return
*void* and also remove rcar_i2c_flags_set() invocation in rcar_i2c_irq().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- refreshed patch.

 drivers/i2c/busses/i2c-rcar.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux/drivers/i2c/busses/i2c-rcar.c
===================================================================
--- linux.orig/drivers/i2c/busses/i2c-rcar.c
+++ linux/drivers/i2c/busses/i2c-rcar.c
@@ -319,7 +319,7 @@ static int rcar_i2c_irq_send(struct rcar
 	return 0;
 }
 
-static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
+static void rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 {
 	struct i2c_msg *msg = priv->msg;
 
@@ -329,7 +329,7 @@ static int rcar_i2c_irq_recv(struct rcar
 	 * Do nothing
 	 */
 	if (!(msr & MDR))
-		return 0;
+		return;
 
 	if (msr & MAT) {
 		/*
@@ -356,8 +356,6 @@ static int rcar_i2c_irq_recv(struct rcar
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
 	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
-
-	return 0;
 }
 
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
@@ -395,7 +393,7 @@ static irqreturn_t rcar_i2c_irq(int irq,
 	}
 
 	if (rcar_i2c_is_recv(priv))
-		rcar_i2c_flags_set(priv, rcar_i2c_irq_recv(priv, msr));
+		rcar_i2c_irq_recv(priv, msr);
 	else
 		rcar_i2c_flags_set(priv, rcar_i2c_irq_send(priv, msr));
 

