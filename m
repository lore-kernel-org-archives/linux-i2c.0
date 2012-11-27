From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 04/16] i2c: scx200_acb: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:41 -0500
Message-ID: <1354049993-12718-5-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/scx200_acb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 08aab57..4486c11 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -389,7 +389,7 @@ static const struct i2c_algorithm scx200_acb_algorithm = {
 static struct scx200_acb_iface *scx200_acb_list;
 static DEFINE_MUTEX(scx200_acb_list_mutex);
 
-static __devinit int scx200_acb_probe(struct scx200_acb_iface *iface)
+static int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
 	u8 val;
 
@@ -424,7 +424,7 @@ static __devinit int scx200_acb_probe(struct scx200_acb_iface *iface)
 	return 0;
 }
 
-static __devinit struct scx200_acb_iface *scx200_create_iface(const char *text,
+static struct scx200_acb_iface *scx200_create_iface(const char *text,
 		struct device *dev, int index)
 {
 	struct scx200_acb_iface *iface;
@@ -449,7 +449,7 @@ static __devinit struct scx200_acb_iface *scx200_create_iface(const char *text,
 	return iface;
 }
 
-static int __devinit scx200_acb_create(struct scx200_acb_iface *iface)
+static int scx200_acb_create(struct scx200_acb_iface *iface)
 {
 	struct i2c_adapter *adapter;
 	int rc;
@@ -480,7 +480,7 @@ static int __devinit scx200_acb_create(struct scx200_acb_iface *iface)
 	return 0;
 }
 
-static struct scx200_acb_iface * __devinit scx200_create_dev(const char *text,
+static struct scx200_acb_iface * scx200_create_dev(const char *text,
 		unsigned long base, int index, struct device *dev)
 {
 	struct scx200_acb_iface *iface;
@@ -508,7 +508,7 @@ static struct scx200_acb_iface * __devinit scx200_create_dev(const char *text,
 	return NULL;
 }
 
-static int __devinit scx200_probe(struct platform_device *pdev)
+static int scx200_probe(struct platform_device *pdev)
 {
 	struct scx200_acb_iface *iface;
 	struct resource *res;
@@ -530,14 +530,14 @@ static int __devinit scx200_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void __devexit scx200_cleanup_iface(struct scx200_acb_iface *iface)
+static void scx200_cleanup_iface(struct scx200_acb_iface *iface)
 {
 	i2c_del_adapter(&iface->adapter);
 	release_region(iface->base, 8);
 	kfree(iface);
 }
 
-static int __devexit scx200_remove(struct platform_device *pdev)
+static int scx200_remove(struct platform_device *pdev)
 {
 	struct scx200_acb_iface *iface;
 
@@ -554,7 +554,7 @@ static struct platform_driver scx200_pci_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = scx200_probe,
-	.remove = __devexit_p(scx200_remove),
+	.remove = scx200_remove,
 };
 
 static DEFINE_PCI_DEVICE_TABLE(scx200_isa) = {
-- 
1.8.0.1
