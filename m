From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] i2c-amd8111: Mark expected switch fall-through
Date: Tue, 3 Jul 2018 14:07:51 -0500
Message-ID: <20180703190751.GA29770@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-i2c@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/i2c/busses/i2c-amd8111.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
index 95a80a8..134567f 100644
--- a/drivers/i2c/busses/i2c-amd8111.c
+++ b/drivers/i2c/busses/i2c-amd8111.c
@@ -384,6 +384,7 @@ static s32 amd8111_access(struct i2c_adapter * adap, u16 addr,
 			if (status)
 				return status;
 			len = min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
+			/* fall through */
 		case I2C_SMBUS_I2C_BLOCK_DATA:
 			for (i = 0; i < len; i++) {
 				status = amd_ec_read(smbus, AMD_SMB_DATA + i,
-- 
2.7.4
