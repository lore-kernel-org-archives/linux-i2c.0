From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/6] i2c: designware: Disable interrupts before requesting PCI device interrupt
Date: Mon, 31 Aug 2015 17:31:29 +0300
Message-ID: <1441031493-18938-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441031493-18938-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Device must not generate interrupts before registering the interrupt
handler so move i2c_dw_disable_int() before requesting it.

There are no known issues with this. The code has been here since commit
fe20ff5c7e9c ("i2c-designware: Add support for Designware core behind PCI
devices.").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index e477dddcdae5..d9e8937f062f 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -260,6 +260,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci");
 
+	i2c_dw_disable_int(dev);
 	r = devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr,
 			IRQF_SHARED | IRQF_COND_SUSPEND, adap->name, dev);
 	if (r) {
@@ -267,7 +268,6 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 		return r;
 	}
 
-	i2c_dw_disable_int(dev);
 	r = i2c_add_numbered_adapter(adap);
 	if (r) {
 		dev_err(&pdev->dev, "failure adding adapter\n");
-- 
2.5.0
