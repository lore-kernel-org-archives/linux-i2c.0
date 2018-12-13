From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 03/73] i2c: rcar: check bus state before reinitializing
Date: Wed, 12 Dec 2018 23:27:28 -0500
Message-ID: <20181213042838.75160-3-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 0b57436f15bf40e432487086c4f2d01fd3529393 ]

We should check the bus state before reinitializing the IP core.
Otherwise, the internal bus busy state which also tracks multi-master
activity is lost.

Credits go to the Renesas BSP team for suggesting this change.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Fixes: ae481cc13965 ("i2c: rcar: fix resume by always initializing registers before transfer")
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-rcar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 4aa7dde876f3..254e6219e538 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -779,6 +779,11 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_get_sync(dev);
 
+	/* Check bus state before init otherwise bus busy info will be lost */
+	ret = rcar_i2c_bus_barrier(priv);
+	if (ret < 0)
+		goto out;
+
 	/* Gen3 needs a reset before allowing RXDMA once */
 	if (priv->devtype == I2C_RCAR_GEN3) {
 		priv->flags |= ID_P_NO_RXDMA;
@@ -791,10 +796,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	rcar_i2c_init(priv);
 
-	ret = rcar_i2c_bus_barrier(priv);
-	if (ret < 0)
-		goto out;
-
 	for (i = 0; i < num; i++)
 		rcar_i2c_request_dma(priv, msgs + i);
 
-- 
2.19.1
