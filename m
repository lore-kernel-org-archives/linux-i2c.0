From: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 0/3] i2c: add DMA support for freescale i2c driver
Date: Thu, 27 Feb 2014 14:05:13 +0800
Message-ID: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Added in v1:
- Enable dma if it's support dma and transfer size bigger than the threshold.
- Add device tree bindings for i2c eDMA support.
- Add eDMA support for i2c driver.
