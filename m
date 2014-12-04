From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2]  iio: imu: inv_mpu6050: Add i2c mux for by pass
Date: Thu,  4 Dec 2014 15:10:24 -0800
Message-ID: <1417734625-13739-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

v2
Addressed comments from Wolfram
- Added reference of discussion for adding this mode to commit message
 to explain the purpose
- Removed static mux variable
- Removed exported interface to add i2c client on the i2c mux
comments by Hartmut
- Unregister iio device if there is a failure

Removed ak8975 change from series still this patch is accepted.

v1
Some minor formatting fix mostly suggested by Hartmut
fail probe if mux create fails
function parameter type matching i2c struct

v0
base version

Srinivas Pandruvada (1):
  iio: imu: inv_mpu6050: Add i2c mux for by pass

 drivers/iio/imu/inv_mpu6050/Kconfig        |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 135 +++++++++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   6 ++
 3 files changed, 136 insertions(+), 6 deletions(-)

-- 
1.9.3
