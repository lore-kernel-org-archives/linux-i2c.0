From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] input: mouse: convert to i2c_new_scanned_device
Date: Mon, 16 Dec 2019 13:29:49 +0100
Message-ID: <20191216122950.3613-2-wsa+renesas@sang-engineering.com>
References: <20191216122950.3613-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216122950.3613-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only.

 drivers/input/mouse/psmouse-smbus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 027efdd2b2ad..27358e543283 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -190,6 +190,7 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
 	struct psmouse_smbus_dev *smbdev = data;
 	unsigned short addr_list[] = { smbdev->board.addr, I2C_CLIENT_END };
 	struct i2c_adapter *adapter;
+	struct i2c_client *client;
 
 	adapter = i2c_verify_adapter(dev);
 	if (!adapter)
@@ -198,12 +199,12 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HOST_NOTIFY))
 		return 0;
 
-	smbdev->client = i2c_new_probed_device(adapter, &smbdev->board,
-					       addr_list, NULL);
-	if (!smbdev->client)
+	client = i2c_new_scanned_device(adapter, &smbdev->board, addr_list, NULL);
+	if (IS_ERR(client))
 		return 0;
 
 	/* We have our(?) device, stop iterating i2c bus. */
+	smbdev->client = client;
 	return 1;
 }
 
-- 
2.20.1
