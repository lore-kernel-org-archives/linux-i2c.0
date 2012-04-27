From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
Date: Fri, 27 Apr 2012 15:02:55 +0800
Message-ID: <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335510185-7906-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

device_prep_dma_cyclic may be call in audio trigger function which is
atomic context, so we make it atomic too.

 - change channel0 lock to spinlock.
 - Use polling to wait for channel0 finish running.

Signed-off-by: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/dma/imx-sdma.c |   57 +++++++++++++++++++++++++++-------------=
-------
 1 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index fddccae..fc49ffa 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -24,7 +24,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
-#include <linux/wait.h>
+#include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/semaphore.h>
 #include <linux/spinlock.h>
@@ -324,7 +324,7 @@ struct sdma_engine {
 	struct dma_device		dma_device;
 	struct clk			*clk_ipg;
 	struct clk			*clk_ahb;
-	struct mutex			channel_0_lock;
+	spinlock_t		channel_0_lock;
 	struct sdma_script_start_addrs	*script_addrs;
 };
=20
@@ -402,19 +402,31 @@ static void sdma_enable_channel(struct sdma_engin=
e *sdma, int channel)
 }
=20
 /*
- * sdma_run_channel - run a channel and wait till it's done
+ * sdma_run_channel0 - run a channel and wait till it's done
  */
-static int sdma_run_channel(struct sdma_channel *sdmac)
+static int sdma_run_channel0(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma =3D sdmac->sdma;
 	int channel =3D sdmac->channel;
 	int ret;
+	unsigned long timeout =3D 500;
=20
-	init_completion(&sdmac->done);
-
+	if (channel)
+		return -EINVAL;
 	sdma_enable_channel(sdma, channel);
=20
-	ret =3D wait_for_completion_timeout(&sdmac->done, HZ);
+	while (!(ret =3D readl_relaxed(sdma->regs + SDMA_H_INTR) & 1)) {
+		if (timeout-- <=3D 0)
+			break;
+		udelay(1);
+	}
+
+	if (ret) {
+		/* Clear the interrupt status */
+		writel_relaxed(ret, sdma->regs + SDMA_H_INTR);
+	} else {
+		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
+	}
=20
 	return ret ? 0 : -ETIMEDOUT;
 }
@@ -426,17 +438,17 @@ static int sdma_load_script(struct sdma_engine *s=
dma, void *buf, int size,
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
-
-	mutex_lock(&sdma->channel_0_lock);
+	unsigned long flags;
=20
 	buf_virt =3D dma_alloc_coherent(NULL,
 			size,
 			&buf_phys, GFP_KERNEL);
 	if (!buf_virt) {
-		ret =3D -ENOMEM;
-		goto err_out;
+		return -ENOMEM;
 	}
=20
+	spin_lock_irqsave(&sdma->channel_0_lock, flags);
+
 	bd0->mode.command =3D C0_SETPM;
 	bd0->mode.status =3D BD_DONE | BD_INTR | BD_WRAP | BD_EXTD;
 	bd0->mode.count =3D size / 2;
@@ -445,12 +457,11 @@ static int sdma_load_script(struct sdma_engine *s=
dma, void *buf, int size,
=20
 	memcpy(buf_virt, buf, size);
=20
-	ret =3D sdma_run_channel(&sdma->channel[0]);
+	ret =3D sdma_run_channel0(&sdma->channel[0]);
=20
-	dma_free_coherent(NULL, size, buf_virt, buf_phys);
+	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
=20
-err_out:
-	mutex_unlock(&sdma->channel_0_lock);
+	dma_free_coherent(NULL, size, buf_virt, buf_phys);
=20
 	return ret;
 }
@@ -539,10 +550,6 @@ static void mxc_sdma_handle_channel(struct sdma_ch=
annel *sdmac)
 {
 	complete(&sdmac->done);
=20
-	/* not interested in channel 0 interrupts */
-	if (sdmac->channel =3D=3D 0)
-		return;
-
 	if (sdmac->flags & IMX_DMA_SG_LOOP)
 		sdma_handle_channel_loop(sdmac);
 	else
@@ -555,6 +562,8 @@ static irqreturn_t sdma_int_handler(int irq, void *=
dev_id)
 	unsigned long stat;
=20
 	stat =3D readl_relaxed(sdma->regs + SDMA_H_INTR);
+	/* not interested in channel 0 interrupts */
+	stat &=3D ~1;
 	writel_relaxed(stat, sdma->regs + SDMA_H_INTR);
=20
 	while (stat) {
@@ -660,6 +669,7 @@ static int sdma_load_context(struct sdma_channel *s=
dmac)
 	struct sdma_context_data *context =3D sdma->context;
 	struct sdma_buffer_descriptor *bd0 =3D sdma->channel[0].bd;
 	int ret;
+	unsigned long flags;
=20
 	if (sdmac->direction =3D=3D DMA_DEV_TO_MEM) {
 		load_address =3D sdmac->pc_from_device;
@@ -677,7 +687,7 @@ static int sdma_load_context(struct sdma_channel *s=
dmac)
 	dev_dbg(sdma->dev, "event_mask0 =3D 0x%08x\n", (u32)sdmac->event_mask=
[0]);
 	dev_dbg(sdma->dev, "event_mask1 =3D 0x%08x\n", (u32)sdmac->event_mask=
[1]);
=20
-	mutex_lock(&sdma->channel_0_lock);
+	spin_lock_irqsave(&sdma->channel_0_lock, flags);
=20
 	memset(context, 0, sizeof(*context));
 	context->channel_state.pc =3D load_address;
@@ -696,10 +706,9 @@ static int sdma_load_context(struct sdma_channel *=
sdmac)
 	bd0->mode.count =3D sizeof(*context) / 4;
 	bd0->buffer_addr =3D sdma->context_phys;
 	bd0->ext_buffer_addr =3D 2048 + (sizeof(*context) / 4) * channel;
+	ret =3D sdma_run_channel0(&sdma->channel[0]);
=20
-	ret =3D sdma_run_channel(&sdma->channel[0]);
-
-	mutex_unlock(&sdma->channel_0_lock);
+	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
=20
 	return ret;
 }
@@ -1305,7 +1314,7 @@ static int __init sdma_probe(struct platform_devi=
ce *pdev)
 	if (!sdma)
 		return -ENOMEM;
=20
-	mutex_init(&sdma->channel_0_lock);
+	spin_lock_init(&sdma->channel_0_lock);
=20
 	sdma->dev =3D &pdev->dev;
=20
--=20
1.7.5.4
