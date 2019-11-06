From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 06/12] input: mouse: convert to i2c_new_scanned_device
Date: Wed,  6 Nov 2019 10:50:24 +0100
Message-ID: <20191106095033.25182-7-wsa+renesas@sang-engineering.com>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. RFC, please comment and/or ack, but don't apply yet.

 drivers/input/mouse/psmouse-smbus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 027efdd2b2ad..35bf50a871d2 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -198,10 +198,12 @@ static int psmouse_smbus_create_companion(struct device *dev, void *data)
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HOST_NOTIFY))
 		return 0;
 
-	smbdev->client = i2c_new_probed_device(adapter, &smbdev->board,
-					       addr_list, NULL);
-	if (!smbdev->client)
+	smbdev->client = i2c_new_scanned_device(adapter, &smbdev->board,
+					        addr_list, NULL);
+	if (IS_ERR(smbdev->client)) {
+		smbdev->client = NULL;
 		return 0;
+	}
 
 	/* We have our(?) device, stop iterating i2c bus. */
 	return 1;
-- 
2.20.1
