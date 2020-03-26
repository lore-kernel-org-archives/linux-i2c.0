From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] iio: imu: inv_mpu6050: convert to use i2c_new_client_device()
Date: Thu, 26 Mar 2020 22:09:55 +0100
Message-ID: <20200326210955.12991-2-wsa+renesas@sang-engineering.com>
References: <20200326210955.12991-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326210955.12991-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 2f8560ba4572..c27d06035c8b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -135,6 +135,7 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 	st->mux_client = NULL;
 	if (ACPI_HANDLE(&client->dev)) {
 		struct i2c_board_info info;
+		struct i2c_client *mux_client;
 		struct acpi_device *adev;
 		int ret = -1;
 
@@ -172,9 +173,10 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *client)
 			} else
 				return 0; /* no secondary addr, which is OK */
 		}
-		st->mux_client = i2c_new_device(st->muxc->adapter[0], &info);
-		if (!st->mux_client)
-			return -ENODEV;
+		mux_client = i2c_new_client_device(st->muxc->adapter[0], &info);
+		if (IS_ERR(mux_client))
+			return PTR_ERR(mux_client);
+		st->mux_client = mux_client;
 	}
 
 	return 0;
-- 
2.20.1
