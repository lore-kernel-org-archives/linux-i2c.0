From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 15/16] i2c-sis96x: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:52 -0500
Message-ID: <1354049993-12718-16-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, "Mark M. Hoffman" <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis96x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 7b72614..b9faf9b 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -252,7 +252,7 @@ static DEFINE_PCI_DEVICE_TABLE(sis96x_ids) = {
 
 MODULE_DEVICE_TABLE (pci, sis96x_ids);
 
-static int __devinit sis96x_probe(struct pci_dev *dev,
+static int sis96x_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
 	u16 ww = 0;
@@ -308,7 +308,7 @@ static int __devinit sis96x_probe(struct pci_dev *dev,
 	return retval;
 }
 
-static void __devexit sis96x_remove(struct pci_dev *dev)
+static void sis96x_remove(struct pci_dev *dev)
 {
 	if (sis96x_smbus_base) {
 		i2c_del_adapter(&sis96x_adapter);
@@ -321,7 +321,7 @@ static struct pci_driver sis96x_driver = {
 	.name		= "sis96x_smbus",
 	.id_table	= sis96x_ids,
 	.probe		= sis96x_probe,
-	.remove		= __devexit_p(sis96x_remove),
+	.remove		= sis96x_remove,
 };
 
 module_pci_driver(sis96x_driver);
-- 
1.8.0.1
