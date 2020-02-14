From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 500/542] i2c: cros-ec-tunnel: Fix slave device enumeration
Date: Fri, 14 Feb 2020 10:48:12 -0500
Message-ID: <20200214154854.6746-500-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Raul E Rangel <rrangel@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Wolfram Sang <wsa@the-dreams.de>, Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

[ Upstream commit 8ff2d7ca4a55dfabf12e876369835bd024eb4621 ]

During adding of the adapter the slave device registration
use to fail as the acpi companion field was not populated.

Fixes: 9af1563a5486 ("i2c: cros-ec-tunnel: Make the device acpi compatible")
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Acked-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 958161c71985d..8a2db3ac3b3c7 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -273,6 +273,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
 	bus->adap.dev.parent = &pdev->dev;
 	bus->adap.dev.of_node = pdev->dev.of_node;
 	bus->adap.retries = I2C_MAX_RETRIES;
+	ACPI_COMPANION_SET(&bus->adap.dev, ACPI_COMPANION(&pdev->dev));
 
 	err = i2c_add_adapter(&bus->adap);
 	if (err)
-- 
2.20.1
