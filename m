From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 3/4] i2c: designware-pcidrv: enable RuntimePM before registering to the core
Date: Thu, 14 Apr 2016 20:53:33 +0800
Message-ID: <1460638414-5987-4-git-send-email-jszhang@marvell.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23438 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753900AbcDNM5x (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 08:57:53 -0400
In-Reply-To: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

As pointed out by commit 36d48fb5766a ("i2c: designware-platdrv: enable
RuntimePM before registering to the core"), "The core may register
clients attached to this master which may use funtionality from the
master", so enable RuntimePM before registering to the core.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 7368be0..41a01a7 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -248,14 +248,17 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
 	adap->nr = controller->bus_num;
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	r = i2c_dw_probe(dev);
-	if (r)
+	if (r) {
+		pm_runtime_forbid(&pdev->dev);
 		return r;
+	}
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
-	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
 
 	return 0;
 }
-- 
2.8.0.rc3
