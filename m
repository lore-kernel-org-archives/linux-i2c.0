From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] i2c: i2c-cros-ec-tunnel: Fix slave device enumeration
Date: Thu, 21 Nov 2019 14:36:17 +0530
Message-ID: <20191121090620.75569-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: akshu.agrawal@amd.com, rrangel@chromium.org, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Chanwoo Choi <cw00.choi@samsung.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

During adding of the adapter the slave device registration
use to fail as the acpi companion field was not populated.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index c551aa96a2e3..aca8070393bd 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -273,6 +273,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
 	bus->adap.dev.parent = &pdev->dev;
 	bus->adap.dev.of_node = np;
 	bus->adap.retries = I2C_MAX_RETRIES;
+	ACPI_COMPANION_SET(&bus->adap.dev, ACPI_COMPANION(&pdev->dev));
 
 	err = i2c_add_adapter(&bus->adap);
 	if (err)
-- 
2.17.1
