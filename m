From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c driver
Date: Thu, 25 Sep 2014 09:58:59 +0000
Message-ID: <0f491b0c56264ee09a09f94b718536f4@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
 <1411632689-31531-2-git-send-email-yao.yuan@freescale.com>
 <6a2c63ad3a60461a830a00281c9d0b3c@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6a2c63ad3a60461a830a00281c9d0b3c-GeMU99GfrrsHjcGqcGfFzOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>
Cc: "LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org" <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Duan Fugang-B38611
> Sent: Thursday, September 25, 2014 5:25 PM
> To: Yuan Yao-B46683; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; marex-ynQEQJNshbs@public.gmane.org
> Cc: LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: RE: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c
> driver
> 
> From: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org> Sent: Thursday, September 25,
> 2014 4:11 PM
> >To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; marex-ynQEQJNshbs@public.gmane.org
> >Cc: LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; Duan Fugang-B38611;
> >shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-
> >kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >Subject: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c
> >driver
> >
> >Add dma support for i2c. This function depend on DMA driver.
> >You can turn on it by write both the dmas and dma-name properties in
> >dts node.
> >DMA is optional, even DMA request unsuccessfully, i2c can also work well.
> >
> >Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >---
> > drivers/i2c/busses/i2c-imx.c | 352
> >+++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 342 insertions(+), 10 deletions(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-imx.c
> >b/drivers/i2c/busses/i2c-imx.c index 613069b..c643756 100644
> >--- a/drivers/i2c/busses/i2c-imx.c
> >+++ b/drivers/i2c/busses/i2c-imx.c
> >@@ -37,22 +37,27 @@
> >+	 */
> >+	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> >+	reinit_completion(&i2c_imx->dma->cmd_complete);
> >+	result = wait_for_completion_interruptible_timeout(
> >+				&i2c_imx->dma->cmd_complete,
> >+				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> >+	if (result <= 0) {
> >+		dmaengine_terminate_all(dma->chan_using);
> >+		if (result)
> >+			return result;
> >+		else
> >+			return -ETIMEDOUT;
> >+	}
> >+
> >+	/* Waiting for Transfer complete. */
> >+	while (1) {
> >+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> >+		if (temp & I2SR_ICF)
> Why not wait for IIF ?

[Yuan Yao] 
IIF is often used. But IIF cannot indicate transfer completely in DMA mode. 
So TCF(I2SR_ICF) is the only choice.

> >+			break;
> >+		if (time_after(jiffies, orig_jiffies +
> >+				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT))) {
> >+			dev_dbg(dev, "<%s> Timeout\n", __func__);
> >+			return -ETIMEDOUT;
> >+		}
> >+		schedule();
> >+	}

Thanks & Best regards,
Yuan Yao
