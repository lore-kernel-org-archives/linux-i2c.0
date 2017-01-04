From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 0/5] i2c: mux: pca954x: Add interrupt controller support
Date: Wed,  4 Jan 2017 17:29:52 +0800
Message-ID: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:47752 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965368AbdADNnx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2017 08:43:53 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: peda@axentia.se, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

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

Phil Reid (5):
  i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
  dt: bindings: i2c-mux-pca954x: Add documentation for interrupt
    controller
  i2c: mux: pca954x: Add interrupt controller support
  dt: bindings: i2c-mux-pca954x: Add documentation for
    i2c-mux-irq-mask-en
  i2c: mux: pca954x: Add irq_mask_en to delay enabling irqs

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  17 ++-
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 140 ++++++++++++++++++++-
 2 files changed, 155 insertions(+), 2 deletions(-)

-- 
1.8.3.1
