From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 27/49] i2c: mlxcpld: Fix wrong initialization order in probe
Date: Sat,  8 Jun 2019 07:42:08 -0400
Message-ID: <20190608114232.8731-27-sashal@kernel.org>
References: <20190608114232.8731-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608114232.8731-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vadim Pasternak <vadimp@mellanox.com>, Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

[ Upstream commit 13067ef73f337336e3149f5bb9f3fd05fe7f87a0 ]

Fix wrong order in probing routine initialization - field `base_addr'
is used before it's initialized. Move assignment of 'priv->base_addr`
to the beginning, prior the call to mlxcpld_i2c_read_comm().
Wrong order caused the first read of capability register to be executed
at wrong offset 0x0 instead of 0x2000. By chance it was a "good
garbage" at 0x0 offset.

Fixes: 313ce648b5a4 ("i2c: mlxcpld: Add support for extended transaction length for i2c-mlxcpld")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-mlxcpld.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mlxcpld.c b/drivers/i2c/busses/i2c-mlxcpld.c
index 745ed43a22d6..2fd717d8dd30 100644
--- a/drivers/i2c/busses/i2c-mlxcpld.c
+++ b/drivers/i2c/busses/i2c-mlxcpld.c
@@ -503,6 +503,7 @@ static int mlxcpld_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	priv->dev = &pdev->dev;
+	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
 
 	/* Register with i2c layer */
 	mlxcpld_i2c_adapter.timeout = usecs_to_jiffies(MLXCPLD_I2C_XFER_TO);
@@ -518,7 +519,6 @@ static int mlxcpld_i2c_probe(struct platform_device *pdev)
 		mlxcpld_i2c_adapter.nr = pdev->id;
 	priv->adap = mlxcpld_i2c_adapter;
 	priv->adap.dev.parent = &pdev->dev;
-	priv->base_addr = MLXPLAT_CPLD_LPC_I2C_BASE_ADDR;
 	i2c_set_adapdata(&priv->adap, priv);
 
 	err = i2c_add_numbered_adapter(&priv->adap);
-- 
2.20.1
