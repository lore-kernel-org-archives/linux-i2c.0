From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/3] watchdog: iTCO_wdt: Export vendorsupport
Date: Tue, 25 Feb 2020 15:38:00 +0300
Message-ID: <20200225123802.88984-2-mika.westerberg@linux.intel.com>
References: <20200225123802.88984-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200225123802.88984-1-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

In preparation for making ->smi_res optional the iTCO_wdt driver needs
to know whether vendorsupport is being set to non-zero. For this reason
export the variable.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/watchdog/iTCO_vendor.h         |  2 ++
 drivers/watchdog/iTCO_vendor_support.c | 16 +++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/iTCO_vendor.h b/drivers/watchdog/iTCO_vendor.h
index 0f7373ba10d5..69e92e692ae0 100644
--- a/drivers/watchdog/iTCO_vendor.h
+++ b/drivers/watchdog/iTCO_vendor.h
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* iTCO Vendor Specific Support hooks */
 #ifdef CONFIG_ITCO_VENDOR_SUPPORT
+extern int iTCO_vendorsupport;
 extern void iTCO_vendor_pre_start(struct resource *, unsigned int);
 extern void iTCO_vendor_pre_stop(struct resource *);
 extern int iTCO_vendor_check_noreboot_on(void);
 #else
+#define iTCO_vendorsupport				0
 #define iTCO_vendor_pre_start(acpibase, heartbeat)	{}
 #define iTCO_vendor_pre_stop(acpibase)			{}
 #define iTCO_vendor_check_noreboot_on()			1
diff --git a/drivers/watchdog/iTCO_vendor_support.c b/drivers/watchdog/iTCO_vendor_support.c
index 4f1b96f59349..cf0eaa04b064 100644
--- a/drivers/watchdog/iTCO_vendor_support.c
+++ b/drivers/watchdog/iTCO_vendor_support.c
@@ -39,8 +39,10 @@
 /* Broken BIOS */
 #define BROKEN_BIOS		911
 
-static int vendorsupport;
-module_param(vendorsupport, int, 0);
+int iTCO_vendorsupport;
+EXPORT_SYMBOL(iTCO_vendorsupport);
+
+module_param_named(vendorsupport, iTCO_vendorsupport, int, 0);
 MODULE_PARM_DESC(vendorsupport, "iTCO vendor specific support mode, default="
 			"0 (none), 1=SuperMicro Pent3, 911=Broken SMI BIOS");
 
@@ -152,7 +154,7 @@ static void broken_bios_stop(struct resource *smires)
 void iTCO_vendor_pre_start(struct resource *smires,
 			   unsigned int heartbeat)
 {
-	switch (vendorsupport) {
+	switch (iTCO_vendorsupport) {
 	case SUPERMICRO_OLD_BOARD:
 		supermicro_old_pre_start(smires);
 		break;
@@ -165,7 +167,7 @@ EXPORT_SYMBOL(iTCO_vendor_pre_start);
 
 void iTCO_vendor_pre_stop(struct resource *smires)
 {
-	switch (vendorsupport) {
+	switch (iTCO_vendorsupport) {
 	case SUPERMICRO_OLD_BOARD:
 		supermicro_old_pre_stop(smires);
 		break;
@@ -178,7 +180,7 @@ EXPORT_SYMBOL(iTCO_vendor_pre_stop);
 
 int iTCO_vendor_check_noreboot_on(void)
 {
-	switch (vendorsupport) {
+	switch (iTCO_vendorsupport) {
 	case SUPERMICRO_OLD_BOARD:
 		return 0;
 	default:
@@ -189,13 +191,13 @@ EXPORT_SYMBOL(iTCO_vendor_check_noreboot_on);
 
 static int __init iTCO_vendor_init_module(void)
 {
-	if (vendorsupport == SUPERMICRO_NEW_BOARD) {
+	if (iTCO_vendorsupport == SUPERMICRO_NEW_BOARD) {
 		pr_warn("Option vendorsupport=%d is no longer supported, "
 			"please use the w83627hf_wdt driver instead\n",
 			SUPERMICRO_NEW_BOARD);
 		return -EINVAL;
 	}
-	pr_info("vendor-support=%d\n", vendorsupport);
+	pr_info("vendor-support=%d\n", iTCO_vendorsupport);
 	return 0;
 }
 
-- 
2.25.0
