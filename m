From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] i3c: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:10:02 +0100
Message-ID: <20200326211002.13241-2-wsa+renesas@sang-engineering.com>
References: <20200326211002.13241-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211002.13241-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Boris Brezillon <bbrezillon@kernel.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 925e1ed18a2a..d79cd6d54b3a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2160,7 +2160,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	 * correctly even if one or more i2c devices are not registered.
 	 */
 	i3c_bus_for_each_i2cdev(&master->bus, i2cdev)
-		i2cdev->dev = i2c_new_device(adap, &i2cdev->boardinfo->base);
+		i2cdev->dev = i2c_new_client_device(adap, &i2cdev->boardinfo->base);
 
 	return 0;
 }
-- 
2.20.1
