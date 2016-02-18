From: Daniel Baluta <daniel.baluta@intel.com>
Subject: [RFC PATCH 5/9] iio: imu: inv_mpu6050: Delete space before comma
Date: Thu, 18 Feb 2016 17:53:10 +0200
Message-ID: <1455810794-3188-6-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, lucas.demarchi@intel.com, daniel.baluta@intel.com, srinivas.pandruvada@linux.intel.com, ggao@invensense.com, adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
List-Id: linux-i2c@vger.kernel.org

This fixes the following checkpatch.pl warning:

ERROR: space prohibited before that ',' (ctx:WxE)
		.shift = 0 ,

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 72cc478..48ab575 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -582,7 +582,7 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 				.sign = 's',                          \
 				.realbits = 16,                       \
 				.storagebits = 16,                    \
-				.shift = 0 ,                          \
+				.shift = 0,                           \
 				.endianness = IIO_BE,                 \
 			     },                                       \
 	}
-- 
2.5.0
