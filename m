From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] sfc: falcon: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:00 +0100
Message-ID: <20200326211001.13171-3-wsa+renesas@sang-engineering.com>
References: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Solarflare linux maintainers <linux-net-drivers@solarflare.com>, Edward Cree <ecree@solarflare.com>, Martin Habets <mhabets@solarflare.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/ethernet/sfc/falcon/falcon_boards.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/falcon_boards.c b/drivers/net/ethernet/sfc/falcon/falcon_boards.c
index 605f486fa675..729a05c1b0cf 100644
--- a/drivers/net/ethernet/sfc/falcon/falcon_boards.c
+++ b/drivers/net/ethernet/sfc/falcon/falcon_boards.c
@@ -88,11 +88,11 @@ static int ef4_init_lm87(struct ef4_nic *efx, const struct i2c_board_info *info,
 			 const u8 *reg_values)
 {
 	struct falcon_board *board = falcon_board(efx);
-	struct i2c_client *client = i2c_new_device(&board->i2c_adap, info);
+	struct i2c_client *client = i2c_new_client_device(&board->i2c_adap, info);
 	int rc;
 
-	if (!client)
-		return -EIO;
+	if (IS_ERR(client))
+		return PTR_ERR(client);
 
 	/* Read-to-clear alarm/interrupt status */
 	i2c_smbus_read_byte_data(client, LM87_REG_ALARMS1);
-- 
2.20.1
