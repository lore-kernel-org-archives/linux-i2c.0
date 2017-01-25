From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v6 0/3]  i2c: mux: pca954x: Add interrupt controller support
Date: Wed, 25 Jan 2017 09:31:05 +0800
Message-ID: <1485307868-5408-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:52204 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751148AbdAYBbY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Jan 2017 20:31:24 -0500
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

Changes from v5:
- p3 Added Peter's Ack.
- Drop p4/5

Changes from v4:
- p4: Change definition of irq_mask_enable to an array.
- p4: Removed acks due to change requested by Peter
- p5: Parse array of enables. Currently only supports 1 chip
      But dt specification will allow expansion to handle
      multple irq consume chips to be registered on a bus segment
- p5: Fix up logic related to enabling and disable irq's.
      Use a flag to indicate when irq has been enabled.

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
Phil Reid (3):
  i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
  dt: bindings: i2c-mux-pca954x: Add documentation for interrupt
    controller
  i2c: mux: pca954x: Add interrupt controller support

 .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  14 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 150 ++++++++++++++++++++-
 2 files changed, 159 insertions(+), 5 deletions(-)

-- 
1.8.3.1
