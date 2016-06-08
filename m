From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 3/3] i2c: octeon: Avoid printk after too long SMBUS message
Date: Wed,  8 Jun 2016 08:51:19 +0200
Message-ID: <83c02ffe81ffb98f384d0633523118464bc27537.1465304877.git.jglauber@cavium.com>
References: <cover.1465304877.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1465304877.git.jglauber@cavium.com>
In-Reply-To: <cover.1465304877.git.jglauber@cavium.com>
References: <cover.1465304877.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Remove the warning about a too long SMBUS message because
the ipmi_ssif driver triggers this warning too frequently so it
spams the message log.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 8ade7fb..83fd6d8 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -975,12 +975,8 @@ restart:
 
 		data[i] = octeon_i2c_data_read(i2c);
 		if (recv_len && i == 0) {
-			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(i2c->dev,
-					"%s: read len > I2C_SMBUS_BLOCK_MAX %d\n",
-					__func__, data[i]);
+			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1)
 				return -EPROTO;
-			}
 			length += data[i];
 		}
 
-- 
2.9.0.rc0.21.g7777322
