From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH 1/4] i2c: i2c-cros-ec-tunnel: Pass ACPI node to i2c adapter
Date: Thu, 21 Nov 2019 14:10:50 -0700
Message-ID: <20191121140830.1.Iae79baaa31014e8b1d8177bcfbcd41514af724f9@changeid>
References: <20191121211053.48861-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191121211053.48861-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc: Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <groeck@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, Benson Leung <bleung@chromium.org>
List-Id: linux-i2c@vger.kernel.org

The I2C bus needs to share the same ACPI node as the tunnel device so
that the I2C bus can be referenced from ACPI.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I would have added a Fixes annotation, but I wasn't able to find the
hash for https://lore.kernel.org/patchwork/patch/1151436/.

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 958161c71985..ac2412755f0a 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -272,6 +272,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
 	bus->adap.algo_data = bus;
 	bus->adap.dev.parent = &pdev->dev;
 	bus->adap.dev.of_node = pdev->dev.of_node;
+	ACPI_COMPANION_SET(&bus->adap.dev, ACPI_COMPANION(&pdev->dev));
 	bus->adap.retries = I2C_MAX_RETRIES;
 
 	err = i2c_add_adapter(&bus->adap);
-- 
2.24.0.432.g9d3f5f5b63-goog
