From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv2 4/5] i2c: i801: Remove pci_enable_device() call from i801_resume()
Date: Wed, 11 Feb 2015 14:32:07 +0200
Message-ID: <1423657928-25534-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423657928-25534-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since pci_disable_device() is not called from i801_suspend() and power
state is set already it means that subsequent pci_enable_device() calls do
practically nothing but monotonically increase struct pci_dev enable_cnt.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b1d725d758bb..5fb35464f693 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1324,7 +1324,7 @@ static int i801_resume(struct pci_dev *dev)
 {
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
-	return pci_enable_device(dev);
+	return 0;
 }
 #else
 #define i801_suspend NULL
-- 
2.1.4
