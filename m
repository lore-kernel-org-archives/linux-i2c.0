From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c: thunderx: Enable HWMON class probing
Date: Fri, 21 Apr 2017 16:43:55 +0200
Message-ID: <20170421144355.8172-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33173 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037873AbdDUSff (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 21 Apr 2017 14:35:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id w50so8574811wrc.0
        for <linux-i2c@vger.kernel.org>; Fri, 21 Apr 2017 11:35:34 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, David Daney <david.daney@cavium.com>, Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Set I2C_CLASS_HWMON to enable automatic probing of BMC devices
by the ipmi-ssif driver.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index 1d4c2be..e7deef4 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -205,6 +205,7 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 
 	i2c->adap = thunderx_i2c_ops;
 	i2c->adap.retries = 5;
+	i2c->adap.class = I2C_CLASS_HWMON;
 	i2c->adap.bus_recovery_info = &octeon_i2c_recovery_info;
 	i2c->adap.dev.parent = dev;
 	i2c->adap.dev.of_node = pdev->dev.of_node;
-- 
2.9.0.rc0.21.g7777322
