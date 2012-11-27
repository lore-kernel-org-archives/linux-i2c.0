From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 12/16] i2c: i2c-pasemi: remove __dev* attributes
Date: Tue, 27 Nov 2012 15:59:49 -0500
Message-ID: <1354049993-12718-13-git-send-email-wfp5p@virginia.edu>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pasemi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pasemi.c b/drivers/i2c/busses/i2c-pasemi.c
index 12edefd..615f632 100644
--- a/drivers/i2c/busses/i2c-pasemi.c
+++ b/drivers/i2c/busses/i2c-pasemi.c
@@ -340,7 +340,7 @@ static const struct i2c_algorithm smbus_algorithm = {
 	.functionality	= pasemi_smb_func,
 };
 
-static int __devinit pasemi_smb_probe(struct pci_dev *dev,
+static int pasemi_smb_probe(struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
 	struct pasemi_smbus *smbus;
@@ -392,7 +392,7 @@ static int __devinit pasemi_smb_probe(struct pci_dev *dev,
 	return error;
 }
 
-static void __devexit pasemi_smb_remove(struct pci_dev *dev)
+static void pasemi_smb_remove(struct pci_dev *dev)
 {
 	struct pasemi_smbus *smbus = pci_get_drvdata(dev);
 
@@ -412,7 +412,7 @@ static struct pci_driver pasemi_smb_driver = {
 	.name		= "i2c-pasemi",
 	.id_table	= pasemi_smb_ids,
 	.probe		= pasemi_smb_probe,
-	.remove		= __devexit_p(pasemi_smb_remove),
+	.remove		= pasemi_smb_remove,
 };
 
 module_pci_driver(pasemi_smb_driver);
-- 
1.8.0.1
