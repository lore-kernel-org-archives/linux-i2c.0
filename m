From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 3/9] i2c: designware: use to_pci_dev()
Date: Sun, 27 Dec 2015 18:45:59 +0800
Message-ID: <7e2bbe0841ba35dbcfb9f6cf08c9ac81ab540663.1451211133.git.geliangtang@163.com>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from m50-133.163.com ([123.125.50.133]:58401 "EHLO m50-133.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbbL0Kqf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 27 Dec 2015 05:46:35 -0500
In-Reply-To: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
In-Reply-To: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Geliang Tang <geliangtang@163.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Use to_pci_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 1543d35d..7368be0 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -162,7 +162,7 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 #ifdef CONFIG_PM
 static int i2c_dw_pci_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	i2c_dw_disable(pci_get_drvdata(pdev));
 	return 0;
@@ -170,7 +170,7 @@ static int i2c_dw_pci_suspend(struct device *dev)
 
 static int i2c_dw_pci_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	return i2c_dw_init(pci_get_drvdata(pdev));
 }
-- 
2.5.0
