From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] i2c: thunderx: Add missed pci_release_regions
Date: Fri,  6 Dec 2019 15:53:49 +0800
Message-ID: <20191206075349.18297-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-i2c@vger.kernel.org

The driver forgets to call pci_release_regions() in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index 19f8eec38717..31f7e254e99f 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -172,8 +172,10 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 		return ret;
 
 	i2c->twsi_base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
-	if (!i2c->twsi_base)
-		return -EINVAL;
+	if (!i2c->twsi_base) {
+		ret = -EINVAL;
+		goto error_release_regions;
+	}
 
 	thunder_i2c_clock_enable(dev, i2c);
 	ret = device_property_read_u32(dev, "clock-frequency", &i2c->twsi_freq);
@@ -189,16 +191,16 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 	if (ret < 0)
-		goto error;
+		goto error_disable_clock;
 
 	ret = devm_request_irq(dev, pci_irq_vector(pdev, 0), octeon_i2c_isr, 0,
 			       DRV_NAME, i2c);
 	if (ret)
-		goto error;
+		goto error_disable_clock;
 
 	ret = octeon_i2c_init_lowlevel(i2c);
 	if (ret)
-		goto error;
+		goto error_disable_clock;
 
 	octeon_i2c_set_clock(i2c);
 
@@ -214,7 +216,7 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret)
-		goto error;
+		goto error_disable_clock;
 
 	dev_info(i2c->dev, "Probed. Set system clock to %u\n", i2c->sys_freq);
 
@@ -224,8 +226,10 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 
 	return 0;
 
-error:
+error_disable_clock:
 	thunder_i2c_clock_disable(dev, i2c->clk);
+error_release_regions:
+	pci_release_regions(pdev);
 	return ret;
 }
 
@@ -236,6 +240,7 @@ static void thunder_i2c_remove_pci(struct pci_dev *pdev)
 	thunder_i2c_smbus_remove(i2c);
 	thunder_i2c_clock_disable(&pdev->dev, i2c->clk);
 	i2c_del_adapter(&i2c->adap);
+	pci_release_regions(pdev);
 }
 
 static const struct pci_device_id thunder_i2c_pci_id_table[] = {
-- 
2.24.0
