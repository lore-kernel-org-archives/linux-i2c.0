From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 3/4] i2c: xlp9xx: report SMBus block read functionality
Date: Thu, 18 Jan 2018 05:39:23 +0000
Message-ID: <1516253964-4615-3-git-send-email-george.cherian@cavium.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
List-Id: linux-i2c@vger.kernel.org

From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>

Report SMBus block read functionality which is actually supported.

Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index b5b224e..1f6d780 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -374,8 +374,8 @@ static int xlp9xx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 static u32 xlp9xx_i2c_functionality(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C |
-		I2C_FUNC_10BIT_ADDR;
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_READ_BLOCK_DATA |
+			I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
 }
 
 static const struct i2c_algorithm xlp9xx_i2c_algo = {
-- 
2.1.4
