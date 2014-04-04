From: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v4 0/2] i2c: add DMA support for freescale i2c driver
Date: Fri, 4 Apr 2014 10:41:10 +0800
Message-ID: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Changed in v4:
- cancelled "i2c_imx->use_dma".
- changed "Dma" to "DMA".
- add timeout handling  for DMA transfer complete.

Changed in v3:
- fix a bug when request the DMA faild.
- some minor fixes for coding style.
- other minor fixes.

Changed in v2:
- remove has_dma_support property
- unify i2c_imx_dma_rx and i2c_imx_dma_tx
- unify i2c_imx_dma_read and i2c_imx_pio_read
- unify i2c_imx_dma_write and i2c_imx_pio_write

Added in v1:
- Enable DMA if it's support DMA and transfer size bigger than the threshold.
- Add device tree bindings for i2c eDMA support.
- Add eDMA support for i2c driver.
