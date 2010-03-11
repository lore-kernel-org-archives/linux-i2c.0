From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 12/37] drivers/usb: use .dev.of_node instead of .node in
	struct of_device
Date: Thu, 11 Mar 2010 11:04:54 -0700
Message-ID: <20100311180453.4824.61269.stgit__23333.3275690258$1268331522$gmane$org@angua>
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

 drivers/usb/host/ehci-ppc-of.c |    2 +-
 drivers/usb/host/isp1760-if.c  |    2 +-
 drivers/usb/host/ohci-ppc-of.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-ppc-of.c b/drivers/usb/host/ehci-ppc-of.c
index 8df33b8..ad06623 100644
--- a/drivers/usb/host/ehci-ppc-of.c
+++ b/drivers/usb/host/ehci-ppc-of.c
@@ -108,7 +108,7 @@ ppc44x_enable_bmt(struct device_node *dn)
 static int __devinit
 ehci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct device_node *dn = op->node;
+	struct device_node *dn = op->dev.of_node;
 	struct usb_hcd *hcd;
 	struct ehci_hcd	*ehci = NULL;
 	struct resource res;
diff --git a/drivers/usb/host/isp1760-if.c b/drivers/usb/host/isp1760-if.c
index 4293cfd..36360e2 100644
--- a/drivers/usb/host/isp1760-if.c
+++ b/drivers/usb/host/isp1760-if.c
@@ -31,7 +31,7 @@ static int of_isp1760_probe(struct of_device *dev,
 		const struct of_device_id *match)
 {
 	struct usb_hcd *hcd;
-	struct device_node *dp = dev->node;
+	struct device_node *dp = dev->dev.of_node;
 	struct resource *res;
 	struct resource memory;
 	struct of_irq oirq;
diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 103263c..003aea2 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -83,7 +83,7 @@ static const struct hc_driver ohci_ppc_of_hc_driver = {
 static int __devinit
 ohci_hcd_ppc_of_probe(struct of_device *op, const struct of_device_id *match)
 {
-	struct device_node *dn = op->node;
+	struct device_node *dn = op->dev.of_node;
 	struct usb_hcd *hcd;
 	struct ohci_hcd	*ohci;
 	struct resource res;
