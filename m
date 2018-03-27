From: michaelsh@mellanox.com
Subject: [PATCH v1 - resent 4/5] i2c: busses: Allow configurable adapter id for mlxcpld
Date: Tue, 27 Mar 2018 14:01:25 +0000
Message-ID: <1522159286-41779-5-git-send-email-michaelsh@mellanox.com>
References: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522159286-41779-1-git-send-email-michaelsh@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org

From: Michael Shych <michaelsh@mellanox.com>

It allows mlxcpld driver to be connected to pre-defined adapter number
equal or greater than one, in order to avoid current limitation, assuming
usage of id number one only.

Signed-off-by: Michael Shych <michaelsh@mellanox.com>
---
 drivers/i2c/busses/i2c-mlxcpld.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 7341cee9..745ed43 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -514,6 +514,8 @@ static int mlxcpld_i2c_probe(struct platform_device *pdev)
 	/* Check support for smbus block transaction */
 	if (val & MLXCPLD_I2C_SMBUS_BLK_BIT)
 		priv->smbus_block = true;
+	if (pdev->id >= -1)
+		mlxcpld_i2c_adapter.nr = pdev->id;
 	priv->adap = mlxcpld_i2c_adapter;
 	priv->adap.dev.parent = &pdev->dev;
 	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
-- 
2.1.4
