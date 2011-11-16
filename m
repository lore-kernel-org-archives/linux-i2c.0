From: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH] i2c/designware: dw_i2c_init_driver as subsys initcall
Date: Wed, 16 Nov 2011 10:28:07 +0530
Message-ID: <1321419487-2353-1-git-send-email-pratyush.anand@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org
Cc: armando.visconti-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, bhavna.yadav-qxv4g6HH51o@public.gmane.org, vincenzo.frascino-qxv4g6HH51o@public.gmane.org, mirko.gardi-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

There are few drivers(for example stmpe-gpio) which are available on i2c
bus but has been initialized as subsys initcall. Therefore i2c driver
must also be initialized as subsys initcall.

Signed-off-by: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c  |    2 +-
 drivers/i2c/busses/i2c-designware-platdrv.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 9e89e73..7854565 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -379,7 +379,7 @@ static int __init dw_i2c_init_driver(void)
 {
 	return  pci_register_driver(&dw_i2c_driver);
 }
-module_init(dw_i2c_init_driver);
+subsys_initcall(dw_i2c_init_driver);
 
 static void __exit dw_i2c_exit_driver(void)
 {
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 2d3657a..4fbdcd5 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -202,7 +202,7 @@ static int __init dw_i2c_init_driver(void)
 {
 	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
 }
-module_init(dw_i2c_init_driver);
+subsys_initcall(dw_i2c_init_driver);
 
 static void __exit dw_i2c_exit_driver(void)
 {
-- 
1.7.2.2
