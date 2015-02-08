From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] i2c: imx: match return type of wait_for_completion_timeout
Date: Sun,  8 Feb 2015 06:39:56 -0500
Message-ID: <1423395596-2591-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kaushal Butala <kaushalkernelmailinglist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. 
An appropriate variable of type unsigned long is introduced and the
assignments fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

Patch was only compile tested with imx_v6_v7_defconfig
(implies CONFIG_I2C_IMX=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-imx.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d7b26fc..2840ff4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -601,6 +601,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 					struct i2c_msg *msgs)
 {
 	int result;
+	unsigned long timeout;
 	unsigned int temp = 0;
 	unsigned long orig_jiffies = jiffies;
 	struct imx_i2c_dma *dma = i2c_imx->dma;
@@ -624,10 +625,10 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 */
 	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
 	reinit_completion(&i2c_imx->dma->cmd_complete);
-	result = wait_for_completion_timeout(
+	timeout = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
-	if (result == 0) {
+	if (timeout == 0) {
 		dmaengine_terminate_all(dma->chan_using);
 		return -ETIMEDOUT;
 	}
@@ -663,6 +664,7 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 			struct i2c_msg *msgs, bool is_lastmsg)
 {
 	int result;
+	unsigned long timeout;
 	unsigned int temp;
 	unsigned long orig_jiffies = jiffies;
 	struct imx_i2c_dma *dma = i2c_imx->dma;
@@ -682,10 +684,10 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		return result;
 
 	reinit_completion(&i2c_imx->dma->cmd_complete);
-	result = wait_for_completion_timeout(
+	timeout = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
-	if (result == 0) {
+	if (timeout == 0) {
 		dmaengine_terminate_all(dma->chan_using);
 		return -ETIMEDOUT;
 	}
-- 
1.7.10.4
