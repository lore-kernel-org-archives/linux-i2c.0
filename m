From: "Jayachandran C" <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 1/2] i2c-ocore: register OF i2c devices
Date: Tue, 8 May 2012 18:55:28 +0530
Message-ID: <1336483529-19140-2-git-send-email-jayachandranc@netlogicmicro.com>
References: <1336483529-19140-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336483529-19140-1-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Call of_i2c_register_devices() in probe function to register i2c devices
specified in the device tree or OF.

Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 18068de..ebd2700 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -55,6 +55,7 @@
 #include <linux/i2c-ocores.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of_i2c.h>
 
 struct ocores_i2c {
 	void __iomem *base;
@@ -343,7 +344,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	if (pdata) {
 		for (i = 0; i < pdata->num_devices; i++)
 			i2c_new_device(&i2c->adap, pdata->devices + i);
-	}
+	} else
+		of_i2c_register_devices(&i2c->adap);
+
 
 	return 0;
 }
-- 
1.7.9.5
