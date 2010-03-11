From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 03/37] of/sparc: use dev->of_node instead of
	dev->archdata.prom_node
Date: Thu, 11 Mar 2010 11:04:04 -0700
Message-ID: <20100311180403.4824.90589.stgit__7822.33139402724$1268331718$gmane$org@angua>
References: <20100311174830.4824.19820.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dwmw2@infrade
List-Id: linux-i2c@vger.kernel.org

The prom_node pointer is being moved out of archdata to dev->of_node.
This patch changes users of prom_node to use the new location.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

 arch/sparc/include/asm/fb.h      |    2 +-
 arch/sparc/kernel/of_device_32.c |    3 ++-
 arch/sparc/kernel/of_device_64.c |    3 ++-
 arch/sparc/kernel/pci.c          |    4 ++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index b83e447..e834880 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -18,7 +18,7 @@ static inline int fb_is_primary_device(struct fb_info *info)
 	struct device *dev = info->device;
 	struct device_node *node;
 
-	node = dev->archdata.prom_node;
+	node = dev->of_node;
 	if (node &&
 	    node == of_console_device)
 		return 1;
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index da527b3..5a5509c 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -345,8 +345,9 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
 		return NULL;
 
 	sd = &op->dev.archdata;
-	sd->prom_node = dp;
+	sd->prom_node = dp; /* temporary */
 	sd->op = op;
+	op->dev.of_node = dp;
 
 	op->node = dp;
 
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index b3d4cb5..9d30b07 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -640,9 +640,10 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
 		return NULL;
 
 	sd = &op->dev.archdata;
-	sd->prom_node = dp;
+	sd->prom_node = dp; /* temporary */
 	sd->op = op;
 
+	op->dev.of_node = dp;
 	op->node = dp;
 
 	op->clock_freq = of_getintprop_default(dp, "clock-frequency",
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index cf73f43..40861ed 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -654,7 +654,7 @@ show_pciobppath_attr(struct device * dev, struct device_attribute * attr, char *
 	struct device_node *dp;
 
 	pdev = to_pci_dev(dev);
-	dp = pdev->dev.archdata.prom_node;
+	dp = pdev->dev.of_node;
 
 	return snprintf (buf, PAGE_SIZE, "%s\n", dp->full_name);
 }
@@ -1023,7 +1023,7 @@ void arch_teardown_msi_irq(unsigned int virt_irq)
 
 struct device_node *pci_device_to_OF_node(struct pci_dev *pdev)
 {
-	return pdev->dev.archdata.prom_node;
+	return pdev->dev.of_node;
 }
 EXPORT_SYMBOL(pci_device_to_OF_node);
 
