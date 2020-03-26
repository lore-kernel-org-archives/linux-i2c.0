From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] igb: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:59 +0100
Message-ID: <20200326211001.13171-2-wsa+renesas@sang-engineering.com>
References: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, "David S. Miller" <davem@davemloft.net>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/ethernet/intel/igb/igb_hwmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/intel/igb/igb_hwmon.c
index 3b83747b2700..21a29a0ca7f4 100644
--- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
+++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
@@ -198,11 +198,11 @@ int igb_sysfs_init(struct igb_adapter *adapter)
 	}
 
 	/* init i2c_client */
-	client = i2c_new_device(&adapter->i2c_adap, &i350_sensor_info);
-	if (client == NULL) {
+	client = i2c_new_client_device(&adapter->i2c_adap, &i350_sensor_info);
+	if (IS_ERR(client)) {
 		dev_info(&adapter->pdev->dev,
 			 "Failed to create new i2c device.\n");
-		rc = -ENODEV;
+		rc = PTR_ERR(client);
 		goto exit;
 	}
 	adapter->i2c_client = client;
-- 
2.20.1
