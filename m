From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Mon, 25 Apr 2016 16:33:32 +0200
Message-ID: <1461594824-7215-4-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

SMBUS QUICK never worked for the read case, because EINVAL was returned
for a zero length message. The hardware does not support SMBUS QUICK
messages so disable the support and remove the zero length check.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 0f536a1..ad563cf 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -459,9 +459,6 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 	int i, result, length = *rlength;
 	bool final_read = false;
 
-	if (length < 1)
-		return -EINVAL;
-
 	octeon_i2c_data_write(i2c, (target << 1) | 1);
 	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
@@ -597,7 +594,7 @@ static struct i2c_bus_recovery_info octeon_i2c_recovery_info = {
 
 static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
 	       I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_SMBUS_BLOCK_PROC_CALL;
 }
 
-- 
1.9.1
