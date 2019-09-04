From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 73/94] i2c: iproc: Stop advertising support of SMBUS quick cmd
Date: Wed,  4 Sep 2019 11:57:18 -0400
Message-ID: <20190904155739.2816-73-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Lori Hikichi <lori.hikichi@broadcom.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Lori Hikichi <lori.hikichi@broadcom.com>

[ Upstream commit b3d604d405166edfd4e1e6053409b85008f4f56d ]

The driver does not support the SMBUS Quick command so remove the
flag that indicates that level of support.
By default the i2c_detect tool uses the quick command to try and
detect devices at some bus addresses.  If the quick command is used
then we will not detect the device, even though it is present.

Fixes: e6e5dd3566e0 (i2c: iproc: Add Broadcom iProc I2C Driver)
Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index ad1681872e39d..b99322d83f483 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -801,7 +801,10 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	u32 val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	u32 val;
+
+	/* We do not support the SMBUS Quick command */
+	val = I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 
 	if (adap->algo->reg_slave)
 		val |= I2C_FUNC_SLAVE;
-- 
2.20.1
