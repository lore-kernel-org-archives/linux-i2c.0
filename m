From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] i2c: designware: Call i2c_dw_clk_rate() only when calculating timings
Date: Mon,  1 Oct 2018 14:49:05 +0300
Message-ID: <20181001114905.13766-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

There are platforms which don't provide input clock rate but provide
I2C timing parameters. Commit 3bd4f277274b ("i2c: designware: Call
i2c_dw_clk_rate() only once in i2c_dw_init_master()") causes needless
warning during probe on those platforms since i2c_dw_clk_rate(), which
causes the warning when input clock is unknown, is called even when
there is no need to calculate timing parameters.

Fixes: 3bd4f277274b ("i2c: designware: Call i2c_dw_clk_rate() only once in i2c_dw_init_master()")
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # 4.19
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
for current 4.19-rc6. I Cc'ed stable just in case this doesn't hit the
v4.19.
---
 drivers/i2c/busses/i2c-designware-master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 94d94b4a9a0d..18cc324f3ca9 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -34,11 +34,11 @@ static void i2c_dw_configure_fifo_master(struct dw_i2c_dev *dev)
 
 static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 {
-	u32 ic_clk = i2c_dw_clk_rate(dev);
 	const char *mode_str, *fp_str = "";
 	u32 comp_param1;
 	u32 sda_falling_time, scl_falling_time;
 	struct i2c_timings *t = &dev->timings;
+	u32 ic_clk;
 	int ret;
 
 	ret = i2c_dw_acquire_lock(dev);
@@ -53,6 +53,7 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 
 	/* Calculate SCL timing parameters for standard mode if not set */
 	if (!dev->ss_hcnt || !dev->ss_lcnt) {
+		ic_clk = i2c_dw_clk_rate(dev);
 		dev->ss_hcnt =
 			i2c_dw_scl_hcnt(ic_clk,
 					4000,	/* tHD;STA = tHIGH = 4.0 us */
@@ -89,6 +90,7 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	 * needed also in high speed mode.
 	 */
 	if (!dev->fs_hcnt || !dev->fs_lcnt) {
+		ic_clk = i2c_dw_clk_rate(dev);
 		dev->fs_hcnt =
 			i2c_dw_scl_hcnt(ic_clk,
 					600,	/* tHD;STA = tHIGH = 0.6 us */
-- 
2.19.0
