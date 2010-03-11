From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 11/37] drivers/scsi: use .dev.of_node instead of .node in
	struct of_device
Date: Thu, 11 Mar 2010 11:04:48 -0700
Message-ID: <20100311180448.4824.67773.stgit__32409.3319628902$1268331567$gmane$org@angua>
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

 drivers/scsi/qlogicpti.c |   10 +++++-----
 drivers/scsi/sun_esp.c   |   16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index fa34b92..7374fbe 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -755,7 +755,7 @@ static void __devinit qpti_get_scsi_id(struct qlogicpti *qpti)
 	struct of_device *op = qpti->op;
 	struct device_node *dp;
 
-	dp = op->node;
+	dp = op->dev.of_node;
 
 	qpti->scsi_id = of_getintprop_default(dp, "initiator-id", -1);
 	if (qpti->scsi_id == -1)
@@ -776,8 +776,8 @@ static void qpti_get_bursts(struct qlogicpti *qpti)
 	struct of_device *op = qpti->op;
 	u8 bursts, bmask;
 
-	bursts = of_getintprop_default(op->node, "burst-sizes", 0xff);
-	bmask = of_getintprop_default(op->node->parent, "burst-sizes", 0xff);
+	bursts = of_getintprop_default(op->dev.of_node, "burst-sizes", 0xff);
+	bmask = of_getintprop_default(op->dev.of_node->parent, "burst-sizes", 0xff);
 	if (bmask != 0xff)
 		bursts &= bmask;
 	if (bursts == 0xff ||
@@ -1293,7 +1293,7 @@ static struct scsi_host_template qpti_template = {
 static int __devinit qpti_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct scsi_host_template *tpnt = match->data;
-	struct device_node *dp = op->node;
+	struct device_node *dp = op->dev.of_node;
 	struct Scsi_Host *host;
 	struct qlogicpti *qpti;
 	static int nqptis;
@@ -1315,7 +1315,7 @@ static int __devinit qpti_sbus_probe(struct of_device *op, const struct of_devic
 	qpti->qhost = host;
 	qpti->op = op;
 	qpti->qpti_id = nqptis;
-	strcpy(qpti->prom_name, op->node->name);
+	strcpy(qpti->prom_name, op->dev.of_node->name);
 	qpti->is_pti = strcmp(qpti->prom_name, "QLGC,isp");
 
 	if (qpti_map_regs(qpti) < 0)
diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index 3d73aad..4369b76 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -124,7 +124,7 @@ static void __devinit esp_get_scsi_id(struct esp *esp, struct of_device *espdma)
 	struct of_device *op = esp->dev;
 	struct device_node *dp;
 
-	dp = op->node;
+	dp = op->dev.of_node;
 	esp->scsi_id = of_getintprop_default(dp, "initiator-id", 0xff);
 	if (esp->scsi_id != 0xff)
 		goto done;
@@ -133,7 +133,7 @@ static void __devinit esp_get_scsi_id(struct esp *esp, struct of_device *espdma)
 	if (esp->scsi_id != 0xff)
 		goto done;
 
-	esp->scsi_id = of_getintprop_default(espdma->node,
+	esp->scsi_id = of_getintprop_default(espdma->dev.of_node,
 					     "scsi-initiator-id", 7);
 
 done:
@@ -146,7 +146,7 @@ static void __devinit esp_get_differential(struct esp *esp)
 	struct of_device *op = esp->dev;
 	struct device_node *dp;
 
-	dp = op->node;
+	dp = op->dev.of_node;
 	if (of_find_property(dp, "differential", NULL))
 		esp->flags |= ESP_FLAG_DIFFERENTIAL;
 	else
@@ -159,7 +159,7 @@ static void __devinit esp_get_clock_params(struct esp *esp)
 	struct device_node *bus_dp, *dp;
 	int fmhz;
 
-	dp = op->node;
+	dp = op->dev.of_node;
 	bus_dp = dp->parent;
 
 	fmhz = of_getintprop_default(dp, "clock-frequency", 0);
@@ -171,12 +171,12 @@ static void __devinit esp_get_clock_params(struct esp *esp)
 
 static void __devinit esp_get_bursts(struct esp *esp, struct of_device *dma_of)
 {
-	struct device_node *dma_dp = dma_of->node;
+	struct device_node *dma_dp = dma_of->dev.of_node;
 	struct of_device *op = esp->dev;
 	struct device_node *dp;
 	u8 bursts, val;
 
-	dp = op->node;
+	dp = op->dev.of_node;
 	bursts = of_getintprop_default(dp, "burst-sizes", 0xff);
 	val = of_getintprop_default(dma_dp, "burst-sizes", 0xff);
 	if (val != 0xff)
@@ -564,7 +564,7 @@ fail:
 static int __devinit esp_sbus_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dma_node = NULL;
-	struct device_node *dp = op->node;
+	struct device_node *dp = op->dev.of_node;
 	struct of_device *dma_of = NULL;
 	int hme = 0;
 
@@ -573,7 +573,7 @@ static int __devinit esp_sbus_probe(struct of_device *op, const struct of_device
 	     !strcmp(dp->parent->name, "dma")))
 		dma_node = dp->parent;
 	else if (!strcmp(dp->name, "SUNW,fas")) {
-		dma_node = op->node;
+		dma_node = op->dev.of_node;
 		hme = 1;
 	}
 	if (dma_node)
