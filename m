From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v11 1/4] MAINTAINERS: add entry for Aspeed I2C driver
Date: Tue, 20 Jun 2017 14:15:13 -0700
Message-ID: <20170620211516.13095-2-brendanhiggins@google.com>
References: <20170620211516.13095-1-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170620211516.13095-1-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Added myself as maintainer of the Aspeed I2C driver and the associated
I2C interrupt controller and added Joel Stanley and Benjamin
Herrenschmidt as reviewers.

Signed-off-by: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
Added in v11:
  - Added MAINTAINERS entry for Aspeed I2C driver and friends
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 053c3bdd1fe5..2bb541549cc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1123,6 +1123,18 @@ F:	arch/arm/mach-aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 F:	drivers/*/*aspeed*
 
+ARM/ASPEED I2C DRIVER
+M:	Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
+R:	Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
+R:	Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
+L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+L:	openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
+S:	Maintained
+F:	drivers/irqchip/irq-aspeed-i2c-ic.c
+F:	drivers/i2c/busses/i2c-aspeed.c
+F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
 M:	Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
 M:	Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
-- 
2.13.1.611.g7e3b11ae1-goog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
