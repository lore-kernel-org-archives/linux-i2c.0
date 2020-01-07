From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 06/12] i2c: taos-evm: convert to use i2c_new_client_device()
Date: Tue,  7 Jan 2020 18:47:40 +0100
Message-ID: <20200107174748.9616-7-wsa+renesas@sang-engineering.com>
References: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107174748.9616-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/i2c/busses/i2c-taos-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
index 0bff3f3a8779..b4050f5b6746 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -49,10 +49,10 @@ static struct i2c_client *taos_instantiate_device(struct i2c_adapter *adapter)
 	if (!strncmp(adapter->name, "TAOS TSL2550 EVM", 16)) {
 		dev_info(&adapter->dev, "Instantiating device %s at 0x%02x\n",
 			tsl2550_info.type, tsl2550_info.addr);
-		return i2c_new_device(adapter, &tsl2550_info);
+		return i2c_new_client_device(adapter, &tsl2550_info);
 	}
 
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
-- 
2.20.1
