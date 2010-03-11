From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 34/37] sound/sparc: use .dev.of_node instead of .node in
	struct of_device
Date: Thu, 11 Mar 2010 11:06:55 -0700
Message-ID: <20100311180655.4824.33693.stgit__42294.6788873107$1268331040$gmane$org@angua>
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

 sound/sparc/cs4231.c |    6 +++---
 sound/sparc/dbri.c   |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 8d13d93..14cb87c 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2076,12 +2076,12 @@ static int __devinit cs4231_ebus_probe(struct of_device *op, const struct of_dev
 static int __devinit cs4231_probe(struct of_device *op, const struct of_device_id *match)
 {
 #ifdef EBUS_SUPPORT
-	if (!strcmp(op->node->parent->name, "ebus"))
+	if (!strcmp(op->dev.of_node->parent->name, "ebus"))
 		return cs4231_ebus_probe(op, match);
 #endif
 #ifdef SBUS_SUPPORT
-	if (!strcmp(op->node->parent->name, "sbus") ||
-	    !strcmp(op->node->parent->name, "sbi"))
+	if (!strcmp(op->dev.of_node->parent->name, "sbus") ||
+	    !strcmp(op->dev.of_node->parent->name, "sbi"))
 		return cs4231_sbus_probe(op, match);
 #endif
 	return -ENODEV;
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 1d2e51b..2734c36 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2650,7 +2650,7 @@ static int __devinit dbri_probe(struct of_device *op, const struct of_device_id
 
 	printk(KERN_INFO "audio%d at %p (irq %d) is DBRI(%c)+CS4215(%d)\n",
 	       dev, dbri->regs,
-	       dbri->irq, op->node->name[9], dbri->mm.version);
+	       dbri->irq, op->dev.of_node->name[9], dbri->mm.version);
 	dev++;
 
 	return 0;
