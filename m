From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 5/5] i2c: pca-platform: use dev_warn/dev_info instead of printk
Date: Mon, 26 Jun 2017 12:44:34 +1200
Message-ID: <20170626004434.2757-6-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34764 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdFZAop (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 25 Jun 2017 20:44:45 -0400
In-Reply-To: <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 7db481cbf402..395eca0cbb1f 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -107,8 +107,8 @@ static int i2c_pca_pf_waitforcompletion(void *pd)
 static void i2c_pca_pf_dummyreset(void *pd)
 {
 	struct i2c_pca_pf_data *i2c = pd;
-	printk(KERN_WARNING "%s: No reset-pin found. Chip may get stuck!\n",
-		i2c->adap.name);
+
+	dev_warn(&i2c->adap.dev, "No reset-pin found. Chip may get stuck!\n");
 }
 
 static void i2c_pca_pf_resetchip(void *pd)
@@ -236,7 +236,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, i2c);
 
-	printk(KERN_INFO "%s registered.\n", i2c->adap.name);
+	dev_info(&pdev->dev, "registered.\n");
 
 	return 0;
 }
-- 
2.13.0
