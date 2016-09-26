From: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Subject: [PATCH v2] i2c: xlp9xx: ACPI support for I2C clients
Date: Mon, 26 Sep 2016 16:13:03 +0530
Message-ID: <1474886583-10569-1-git-send-email-tanmay.jagdale@broadcom.com>
References: <20160921211725.GI1513@katana>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:62776 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034211AbcIZKnx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Sep 2016 06:43:53 -0400
In-Reply-To: <20160921211725.GI1513@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com, Tanmay Jagdale <tanmay.jagdale@broadcom.com>

The ACPI companion of the adapter has to be set for I2C controller
code to read and attach the slave devices described in the ACPI table
with the I2CSerialBus resource descriptor. Used ACPI_COMPANION_SET
macro to set this.

Signed-off-by: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
---
Changes in v2
	- Fixed parenthesis

 drivers/i2c/busses/i2c-xlp9xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 55a7bef..10e47dd 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -393,6 +393,7 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 	init_completion(&priv->msg_complete);
 	priv->adapter.dev.parent = &pdev->dev;
 	priv->adapter.algo = &xlp9xx_i2c_algo;
+	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&pdev->dev));
 	priv->adapter.dev.of_node = pdev->dev.of_node;
 	priv->dev = &pdev->dev;
 
-- 
2.1.0
