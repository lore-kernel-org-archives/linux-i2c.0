From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH 2/4] i2c: i2c-cros-ec-tunnel: Fix ACPI identifier
Date: Thu, 21 Nov 2019 14:10:51 -0700
Message-ID: <20191121140830.2.I68b9a92ed4def031c3f247d3b49996a2512d762d@changeid>
References: <20191121211053.48861-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191121211053.48861-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: enric.balletbo@collabora.com, Wolfram Sang <wsa@the-dreams.de>
Cc: Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, Neil Armstrong <narmstrong@baylibre.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, dlaurie@chromium.org
List-Id: linux-i2c@vger.kernel.org

The initial patch was using the incorrect identifier.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
There are currently no boards using the identifier so it's fine to
change it.

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index ac2412755f0a..5d91e33eb600 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -299,7 +299,7 @@ static const struct of_device_id cros_ec_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
 
 static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] = {
-	{ "GOOG001A", 0 },
+	{ "GOOG0012", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_tunnel_acpi_id);
-- 
2.24.0.432.g9d3f5f5b63-goog
