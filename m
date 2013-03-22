From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: ismt: remove duplicate const
Date: Fri, 22 Mar 2013 11:13:58 +0100
Message-ID: <1363947238-5109-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

(SMATCH) drivers/i2c/busses/i2c-ismt.c:186:14: warning: duplicate const

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 130f02c..cd82eb4 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -183,7 +183,7 @@ struct ismt_priv {
 /**
  * ismt_ids - PCI device IDs supported by this driver
  */
-static const DEFINE_PCI_DEVICE_TABLE(ismt_ids) = {
+static DEFINE_PCI_DEVICE_TABLE(ismt_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
-- 
1.7.10.4
