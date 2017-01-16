From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] i2c: i2c-cadence: Initialize configuration before probing devices
Date: Mon, 16 Jan 2017 15:49:38 +0100
Message-ID: <1484578178-3165-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from atl4mhob14.myregisteredsite.com ([209.17.115.52]:44724 "EHLO
        atl4mhob14.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750855AbdAPOtq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 16 Jan 2017 09:49:46 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.211])
        by atl4mhob14.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id v0GEniKN015261
        for <linux-i2c@vger.kernel.org>; Mon, 16 Jan 2017 09:49:44 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de, soren.brinkmann@xilinx.com, michal.simek@xilinx.com, Mike Looijmans <mike.looijmans@topic.nl>

The cadence I2C driver calls cdns_i2c_writereg(..) to setup a workaround
in the controller, but did so after calling i2c_add_adapter() which starts
probing devices on the bus. Change the order so that the configuration is
completely finished before using the adapter.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Only move the initialization to before i2c_add_adapter, don't change the
    logging output.
 drivers/i2c/busses/i2c-cadence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 6869712..45d6771 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -962,10 +962,6 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 		goto err_clk_dis;
 	}
 
-	ret = i2c_add_adapter(&id->adap);
-	if (ret < 0)
-		goto err_clk_dis;
-
 	/*
 	 * Cadence I2C controller has a bug wherein it generates
 	 * invalid read transaction after HW timeout in master receiver mode.
@@ -975,6 +971,10 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 	 */
 	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
 
+	ret = i2c_add_adapter(&id->adap);
+	if (ret < 0)
+		goto err_clk_dis;
+
 	dev_info(&pdev->dev, "%u kHz mmio %08lx irq %d\n",
 		 id->i2c_clk / 1000, (unsigned long)r_mem->start, id->irq);
 
-- 
1.9.1
