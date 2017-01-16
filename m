From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v4 0/5] i2c: mux: pca954x: Add interrupt controller support
Date: Mon, 16 Jan 2017 11:11:10 +0800
Message-ID: <1484536275-75995-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Various muxes can aggregate multiple interrupts from each i2c bus.
All of the muxes with interrupt support combine the active low irq lines
using an internal 'and' function and generate a combined active low
output. The muxes do provide the ability to read a control register to
determine which irq is active. By making the mux an irq controller isr
latenct can potentially be reduced by reading the status register and 
then only calling the registered isr on that bus segment.

In addition an additional enable mask is added to work around devices
that assert irq immediately before being setup buy disabling the irq
from the mux until all devices are registered.

Changes from v3:
- p3: Add spin lock to irq mask / unmask.
- p4: Add Rob's ack.

Changes from v2:
- p1: Added Acked-by
- p5: fixup 2 typos

Changes from v1:
- Update for new ACPI table
- Fix typo in documentation
- Fix typo in function names
- Fix typo in irq name
- Added spaces around '+' / '='
- Change goto label names
- Change property name from i2c-mux-irq-mask-en to nxp,irq-mask-enable
- Change variable name irq_mask_en to irq_mask_enable
- Add commentt about irq_mask_enable
- Added Acked-By's

Phil Reid (5):
  i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
  dt: bindings: i2c-mux-pca954x: Add documentation for interrupt
    controller
  i2c: mux: pca954x: Add interrupt controller support
  dt: bindings: i2c-mux-pca954x: Add documentation for
    i2c-mux-irq-mask-en
  i2c: mux: pca954x: Add irq_mask_en to delay enabling irqs

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  17 ++-
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 170 ++++++++++++++++++++-
 2 files changed, 182 insertions(+), 5 deletions(-)

-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
