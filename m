From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V2 06/11] ASoC: fsl_ssi: convert to use devm_clk_get
Date: Wed, 9 May 2012 19:33:05 +0800
Message-ID: <1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 sound/soc/fsl/fsl_ssi.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4ed2afd..b10a427 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -725,7 +725,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
 
-		ssi_private->clk = clk_get(&pdev->dev, NULL);
+		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(ssi_private->clk)) {
 			ret = PTR_ERR(ssi_private->clk);
 			dev_err(&pdev->dev, "could not get clock: %d\n", ret);
@@ -842,10 +842,8 @@ error_dev:
 	device_remove_file(&pdev->dev, dev_attr);
 
 error_clk:
-	if (ssi_private->ssi_on_imx) {
+	if (ssi_private->ssi_on_imx)
 		clk_disable_unprepare(ssi_private->clk);
-		clk_put(ssi_private->clk);
-	}
 
 error_irq:
 	free_irq(ssi_private->irq, ssi_private);
@@ -871,7 +869,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->ssi_on_imx) {
 		platform_device_unregister(ssi_private->imx_pcm_pdev);
 		clk_disable_unprepare(ssi_private->clk);
-		clk_put(ssi_private->clk);
 	}
 	snd_soc_unregister_dai(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
-- 
1.7.5.4
