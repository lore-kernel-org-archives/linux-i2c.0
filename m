From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH Resend] i2c/designware: dw_i2c_init_driver as subsys initcall
Date: Wed, 29 Feb 2012 12:27:46 +0530
Message-ID: <0a4676cdd7e81363eab4eb1520b0e74f50e6c5c4.1330498492.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, armando.visconti-qxv4g6HH51o@public.gmane.org, shiraz.hashim-qxv4g6HH51o@public.gmane.org, vipin.kumar-qxv4g6HH51o@public.gmane.org, rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org, deepak.sikri-qxv4g6HH51o@public.gmane.org, vipulkumar.samar-qxv4g6HH51o@public.gmane.org, amit.virdi-qxv4g6HH51o@public.gmane.org, viresh.kumar-qxv4g6HH51o@public.gmane.org, pratyush.anand-qxv4g6HH51o@public.gmane.org, bhupesh.sharma-qxv4g6HH51o@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhavna.yadav-qxv4g6HH51o@public.gmane.org, vincenzo.frascino-qxv4g6HH51o@public.gmane.org, mirko.gardi-qxv4g6HH51o@public.gmane.org, salvatore.dedominicis-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>

There are few drivers which are available on i2c bus but have been initialized
with subsys_initcall. Also as I2C is also a bus driver, it should be available
as early as possible.

Therefore i2c driver must s initialized with subsys initcall in this patch.

Signed-off-by: Pratyush Anand <pratyush.anand-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
---
This patch was sent a long time back and was never pushed. Resending it again.

 drivers/i2c/busses/i2c-designware-platdrv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 2237398..ac953c8 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -249,7 +249,7 @@ static int __init dw_i2c_init_driver(void)
 {
 	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
 }
-module_init(dw_i2c_init_driver);
+subsys_initcall(dw_i2c_init_driver);
 
 static void __exit dw_i2c_exit_driver(void)
 {
-- 
1.7.8.110.g4cb5d
