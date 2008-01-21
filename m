From: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
Date: Mon, 21 Jan 2008 15:07:40 -0500
Message-ID: <20080121200740.13800.20524.stgit@terra.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Alter the mpc i2c driver to use the NO_IRQ symbol instead of the constant zero when checking for valid interrupts. NO_IRQ=-1 on ppc and NO_IRQ=0 on powerpc so the checks against zero are not correct.

Signed-off-by: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

 drivers/i2c/busses/i2c-mpc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index bbe787b..d20959d 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -99,7 +99,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
 	u32 x;
 	int result = 0;
 
-	if (i2c->irq == 0)
+	if (i2c->irq == NO_IRQ)
 	{
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
@@ -329,7 +329,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
+	if (i2c->irq < NO_IRQ) {
 		result = -ENXIO;
 		goto fail_get_irq;
 	}
@@ -344,7 +344,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 		goto fail_map;
 	}
 
-	if (i2c->irq != 0)
+	if (i2c->irq != NO_IRQ)
 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
 					  IRQF_SHARED, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
@@ -367,7 +367,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 	return result;
 
       fail_add:
-	if (i2c->irq != 0)
+	if (i2c->irq != NO_IRQ)
 		free_irq(i2c->irq, i2c);
       fail_irq:
 	iounmap(i2c->base);
@@ -384,7 +384,7 @@ static int fsl_i2c_remove(struct platform_device *pdev)
 	i2c_del_adapter(&i2c->adap);
 	platform_set_drvdata(pdev, NULL);
 
-	if (i2c->irq != 0)
+	if (i2c->irq != NO_IRQ)
 		free_irq(i2c->irq, i2c);
 
 	iounmap(i2c->base);


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
