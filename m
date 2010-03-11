From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 20/37] drivers/input: use .dev.of_node instead of .node in
	struct of_device
Date: Thu, 11 Mar 2010 11:05:38 -0700
Message-ID: <20100311180538.4824.40399.stgit__21720.644113566$1268331302$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dwmw2@infrade
List-Id: linux-i2c@vger.kernel.org

.node is being removed

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

 drivers/input/serio/i8042-sparcio.h |    2 +-
 drivers/input/serio/xilinx_ps2.c    |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 5071af2..29e1769 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -51,7 +51,7 @@ static inline void i8042_write_command(int val)
 
 static int __devinit sparc_i8042_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct device_node *dp = op->node;
+	struct device_node *dp = op->dev.of_node;
 
 	dp = dp->child;
 	while (dp) {
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 8298e1f..f154153 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -243,17 +243,17 @@ static int __devinit xps2_of_probe(struct of_device *ofdev,
 	int error;
 
 	dev_info(dev, "Device Tree Probing \'%s\'\n",
-			ofdev->node->name);
+			ofdev->dev.of_node->name);
 
 	/* Get iospace for the device */
-	error = of_address_to_resource(ofdev->node, 0, &r_mem);
+	error = of_address_to_resource(ofdev->dev.of_node, 0, &r_mem);
 	if (error) {
 		dev_err(dev, "invalid address\n");
 		return error;
 	}
 
 	/* Get IRQ for the device */
-	if (of_irq_to_resource(ofdev->node, 0, &r_irq) == NO_IRQ) {
+	if (of_irq_to_resource(ofdev->dev.of_node, 0, &r_irq) == NO_IRQ) {
 		dev_err(dev, "no IRQ found\n");
 		return -ENODEV;
 	}
@@ -341,7 +341,7 @@ static int __devexit xps2_of_remove(struct of_device *of_dev)
 	iounmap(drvdata->base_address);
 
 	/* Get iospace of the device */
-	if (of_address_to_resource(of_dev->node, 0, &r_mem))
+	if (of_address_to_resource(of_dev->dev.of_node, 0, &r_mem))
 		dev_err(dev, "invalid address\n");
 	else
 		release_mem_region(r_mem.start, resource_size(&r_mem));
