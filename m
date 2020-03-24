From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] i2c: nvidia-gpu: Handle timeout correctly in gpu_i2c_check_status()
Date: Tue, 24 Mar 2020 21:07:12 +0800
Message-ID: <20200324130712.12289-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ajayg@nvidia.com
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C CONTROLLER DRIVER FOR NVIDIA
        GPU" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Nvidia card may come with a "phantom" UCSI device, and its driver gets
stuck in probe routine, prevents any system PM operations like suspend.

When the target time equals to jiffies, it's not included by
time_is_before_jiffies(). So let's use a boolean to make sure the
operation is done or timeout.

Fixes: c71bcdcb42a7 ("i2c: add i2c bus driver for NVIDIA GPU")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Use a boolean to make sure the operation is timeout or not.

 drivers/i2c/busses/i2c-nvidia-gpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
index 62e18b4db0ed..bdb48600af0e 100644
--- a/drivers/i2c/busses/i2c-nvidia-gpu.c
+++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
@@ -77,18 +77,20 @@ static int gpu_i2c_check_status(struct gpu_i2c_dev *i2cd)
 {
 	unsigned long target = jiffies + msecs_to_jiffies(1000);
 	u32 val;
+	bool done = false;
 
 	do {
 		val = readl(i2cd->regs + I2C_MST_CNTL);
-		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER))
-			break;
-		if ((val & I2C_MST_CNTL_STATUS) !=
-				I2C_MST_CNTL_STATUS_BUS_BUSY)
+		if (!(val & I2C_MST_CNTL_CYCLE_TRIGGER)
+		    || (val & I2C_MST_CNTL_STATUS) !=
+				I2C_MST_CNTL_STATUS_BUS_BUSY) {
+			done = true;
 			break;
+		}
 		usleep_range(500, 600);
 	} while (time_is_after_jiffies(target));
 
-	if (time_is_before_jiffies(target)) {
+	if (!done) {
 		dev_err(i2cd->dev, "i2c timeout error %x\n", val);
 		return -ETIMEDOUT;
 	}
-- 
2.17.1
