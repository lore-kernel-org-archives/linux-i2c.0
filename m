From: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 1/2] i2c: pxa: add pxa910 platform for i2c bus
Date: Fri, 9 Aug 2013 10:43:16 +0800
Message-ID: <1376016196-31292-1-git-send-email-shangll@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Support pxa910 i2c bus.

Signed-off-by: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ea6d45d..6b84f16 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -53,6 +53,7 @@ enum pxa_i2c_types {
 	REGS_PXA2XX,
 	REGS_PXA3XX,
 	REGS_CE4100,
+	REGS_PXA910,
 };
 
 /*
@@ -80,12 +81,20 @@ static struct pxa_reg_layout pxa_reg_layout[] = {
 		.isr =	0x04,
 		/* no isar register */
 	},
+	[REGS_PXA910] = {
+		.ibmr =	0x00,
+		.idbr =	0x08,
+		.icr =	0x10,
+		.isr =	0x18,
+		.isar =	0x20,
+	},
 };
 
 static const struct platform_device_id i2c_pxa_id_table[] = {
 	{ "pxa2xx-i2c",		REGS_PXA2XX },
 	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
 	{ "ce4100-i2c",		REGS_CE4100 },
+	{ "pxa910-i2c",		REGS_PXA910 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
-- 
1.7.4.1
