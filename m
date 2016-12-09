From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Fri,  9 Dec 2016 10:31:58 +0100
Message-ID: <20161209093158.3161-5-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36385 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbcLIJcb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Dec 2016 04:32:31 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so1501520wjb.3
        for <linux-i2c@vger.kernel.org>; Fri, 09 Dec 2016 01:32:30 -0800 (PST)
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

It was reported that ipmi_ssif fails to create the
ipmi device on some systems if the adapter class is not containing
I2C_CLASS_HWMON. Fix it by setting the class.

Reported-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-platdrv.c  | 1 +
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
index 917524c..809b868 100644
--- a/drivers/i2c/busses/i2c-octeon-platdrv.c
+++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
@@ -239,6 +239,7 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	i2c->adap = octeon_i2c_ops;
 	i2c->adap.timeout = msecs_to_jiffies(2);
 	i2c->adap.retries = 5;
+	i2c->adap.class = I2C_CLASS_HWMON;
 	i2c->adap.bus_recovery_info = &octeon_i2c_recovery_info;
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = node;
diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index bba5b42..9e3365f 100644
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
