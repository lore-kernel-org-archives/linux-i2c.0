Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990B4C6FA8B
	for <linux-i2c@archiver.kernel.org>; Thu,  8 Sep 2022 17:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiIHRgE (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 8 Sep 2022 13:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiIHRgC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Sep 2022 13:36:02 -0400
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67C21BB01D
        for <linux-i2c@vger.kernel.org>; Thu,  8 Sep 2022 10:35:56 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 8 Sep 2022 20:35:54 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 288HZoTR026063;
        Thu, 8 Sep 2022 13:35:50 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 288HZokb032705;
        Thu, 8 Sep 2022 13:35:50 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Khalil Blaiech <kblaiech@nvidia.com>
Subject: [PATCH v3 2/9] i2c-mlxbf.c: remove IRQF_ONESHOT
Date:   Thu,  8 Sep 2022 13:35:37 -0400
Message-Id: <20220908173544.32615-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20220908173544.32615-1-asmaa@nvidia.com>
References: <20220908173544.32615-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

IRQF_ONESHOT is not needed so remove it.

Fixes: b5b5b32081cd206b (i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC)
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/i2c/busses/i2c-mlxbf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 2e2ac45d9ca0..087a70981283 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -2356,7 +2356,7 @@ static int mlxbf_i2c_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 	ret = devm_request_irq(dev, irq, mlxbf_smbus_irq,
-			       IRQF_ONESHOT | IRQF_SHARED | IRQF_PROBE_SHARED,
+			       IRQF_SHARED | IRQF_PROBE_SHARED,
 			       dev_name(dev), priv);
 	if (ret < 0) {
 		dev_err(dev, "Cannot get irq %d\n", irq);
-- 
2.30.1

