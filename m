From: Tin Huynh <tnhuynh@apm.com>
Subject: [PATCH V1] i2c: xgene: Fix missing code of DTB support
Date: Wed, 14 Dec 2016 14:17:26 +0700
Message-ID: <1481699846-10620-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36568 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbcLNHSy (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 14 Dec 2016 02:18:54 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so2604977pfz.3
        for <linux-i2c@vger.kernel.org>; Tue, 13 Dec 2016 23:18:30 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, Duc Dang <dhdang@apm.com>, Dien Tien Hoang Nguyen <dinguyen@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>

In DTB case, i2c-core doesn't create slave device which is installed
on i2c-xgene bus because of missing code in this driver.
This patch fixes this issue.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index 263685c..00d1632 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -415,6 +415,7 @@ static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
 	adapter->algo = &xgene_slimpro_i2c_algorithm;
 	adapter->class = I2C_CLASS_HWMON;
 	adapter->dev.parent = &pdev->dev;
+	adapter->dev.of_node = pdev->dev.of_node;
 	i2c_set_adapdata(adapter, ctx);
 	rc = i2c_add_adapter(adapter);
 	if (rc) {
-- 
1.7.1
