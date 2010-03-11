From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 25/37] drivers/infiniband: use .dev.of_node instead of .node
	in struct of_device
Date: Thu, 11 Mar 2010 11:06:06 -0700
Message-ID: <20100311180605.4824.3613.stgit__39620.4050667167$1268331226$gmane$org@angua>
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

 drivers/infiniband/hw/ehca/ehca_main.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 129a6be..2639185 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -291,8 +291,9 @@ static int ehca_sense_attributes(struct ehca_shca *shca)
 	};
 
 	ehca_gen_dbg("Probing adapter %s...",
-		     shca->ofdev->node->full_name);
-	loc_code = of_get_property(shca->ofdev->node, "ibm,loc-code", NULL);
+		     shca->ofdev->dev.of_node->full_name);
+	loc_code = of_get_property(shca->ofdev->dev.of_node, "ibm,loc-code",
+				   NULL);
 	if (loc_code)
 		ehca_gen_dbg(" ... location lode=%s", loc_code);
 
@@ -720,16 +721,16 @@ static int __devinit ehca_probe(struct of_device *dev,
 	int ret, i, eq_size;
 	unsigned long flags;
 
-	handle = of_get_property(dev->node, "ibm,hca-handle", NULL);
+	handle = of_get_property(dev->dev.of_node, "ibm,hca-handle", NULL);
 	if (!handle) {
 		ehca_gen_err("Cannot get eHCA handle for adapter: %s.",
-			     dev->node->full_name);
+			     dev->dev.of_node->full_name);
 		return -ENODEV;
 	}
 
 	if (!(*handle)) {
 		ehca_gen_err("Wrong eHCA handle for adapter: %s.",
-			     dev->node->full_name);
+			     dev->dev.of_node->full_name);
 		return -ENODEV;
 	}
 
