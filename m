From: Maxime COQUELIN <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v2] drivers: i2c: i2c-st: Update i2c timings
Date: Wed, 23 Jul 2014 17:44:07 +0200
Message-ID: <1406130247-19197-1-git-send-email-maxime.coquelin@st.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The i2c timing values specified in the driver are the minimun values defined
in the I2C specifications.
The I2C specification does not specify any default or maximum values.

Some I2C devices are out of spec, such as the HDMI link of the Toshiba 19AV600
TV, and might not work properly with minimum values.

This patch adds a 10% margin on all the timings in both Normal and Fast modes.

Trial and error method have been used to find the minimum margin necessary to
have the out-of-spec device working, and a security margin has been added.

Signed-off-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
---
 drivers/i2c/busses/i2c-st.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
index 95b94767..4ab14ad 100644
--- a/drivers/i2c/busses/i2c-st.c
+++ b/drivers/i2c/busses/i2c-st.c
@@ -206,25 +206,31 @@ static inline void st_i2c_clr_bits(void __iomem *reg, u32 mask)
 	writel_relaxed(readl_relaxed(reg) & ~mask, reg);
 }
 
-/* From I2C Specifications v0.5 */
+/*
+ * From I2C Specifications v0.5.
+ *
+ * All the values below have +10% margin added to be
+ * compatible with some out-of-spec devices,
+ * like HDMI link of the Toshiba 19AV600 TV.
+ */
 static struct st_i2c_timings i2c_timings[] = {
 	[I2C_MODE_STANDARD] = {
 		.rate			= 100000,
-		.rep_start_hold		= 4000,
-		.rep_start_setup	= 4700,
-		.start_hold		= 4000,
-		.data_setup_time	= 250,
-		.stop_setup_time	= 4000,
-		.bus_free_time		= 4700,
+		.rep_start_hold		= 4400,
+		.rep_start_setup	= 5170,
+		.start_hold		= 4400,
+		.data_setup_time	= 275,
+		.stop_setup_time	= 4400,
+		.bus_free_time		= 5170,
 	},
 	[I2C_MODE_FAST] = {
 		.rate			= 400000,
-		.rep_start_hold		= 600,
-		.rep_start_setup	= 600,
-		.start_hold		= 600,
-		.data_setup_time	= 100,
-		.stop_setup_time	= 600,
-		.bus_free_time		= 1300,
+		.rep_start_hold		= 660,
+		.rep_start_setup	= 660,
+		.start_hold		= 660,
+		.data_setup_time	= 110,
+		.stop_setup_time	= 660,
+		.bus_free_time		= 1430,
 	},
 };
 
-- 
1.9.1
