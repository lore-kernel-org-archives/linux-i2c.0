From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] iio: imu: inv_mpu6050: client enumeration
Date: Fri,  9 Jan 2015 15:16:17 -0800
Message-ID: <1420845378-17025-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

v1
This is an option if auto detect is not desired. 
Here using ACPI magic, by parsing both standard and vendor ACPI
data.

v0
Using autodetect feature.
Using HWMON class as other places in the system for mux and
client sensor drivers.

Srinivas Pandruvada (1):
  iio: imu: inv_mpu6050: Create mux clients for ACPI

 drivers/iio/imu/inv_mpu6050/Makefile       |   2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 195 +++++++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |   7 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   3 +
 4 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c

-- 
1.9.3
