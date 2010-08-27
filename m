From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 3/3] Documentation: Documentation for ak8974 magnetometer chip driver
Date: Fri, 27 Aug 2010 14:54:43 +0300
Message-ID: <1282910083-8629-4-git-send-email-samu.p.onkalo@nokia.com>
References: <1282910083-8629-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282910083-8629-1-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 Documentation/misc-devices/ak8974 |   66 +++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/misc-devices/ak8974

diff --git a/Documentation/misc-devices/ak8974 b/Documentation/misc-devices/ak8974
new file mode 100644
index 0000000..c771f1e
--- /dev/null
+++ b/Documentation/misc-devices/ak8974
@@ -0,0 +1,66 @@
+Kernel driver ak8974
+====================
+
+Supported chips:
+Asahi Kasei ak8974
+Aichi Steel ami305
+
+
+Author: Samu P. Onkalo <samu.p.onkalo@nokia.com>
+
+
+Description
+-----------
+
+Chip is a 3 axis magnetometer sensor. It measures and reports
+magnetic field density in x, y, z axis.
+
+Driver provides interface as a misc-character device. Data is returned one
+measurement result at time as a structure of data. Measurement is triggered
+by reading the device handle. Thus measurement rate is controlled by
+the reading application. Read can be blocking or non-blocking.
+Blocking read trigs an measurement and wait until the result is ready.
+Non-blocking read trigs measurement and returns immediatelly. As soon as the
+data is available non-blocking read returns it.
+
+Driver supports regulator framework and power management.
+
+sysfs interface:
+selftest - RO - performs internal selftest procedure - output: FAIL / OK
+range    - RO - data range
+chip_id  - RO - information of the detected chip type
+
+misc-character device:
+----------------------
+device handle name: /dev/ak8974x
+x in the name starts counting from 0 and it is increased by one for each of the
+detected chip.
+
+Data format:
+struct ak8974_data {
+        __s16 x;
+        __s16 y;
+        __s16 z;
+        __u16 valid;
+} __attribute__((packed));
+Each read from the device returns one measurement result "struct ak8974_data"
+format. Data for each axis is in the same format as it is in the chip register.
+
+Platform data:
+
+define AK8974_NO_MAP             0
+#define AK8974_DEV_X              1
+#define AK8974_DEV_Y              2
+#define AK8974_DEV_Z              3
+#define AK8974_INV_DEV_X         -1
+#define AK8974_INV_DEV_Y         -2
+#define AK8974_INV_DEV_Z         -3
+
+struct ak8974_platform_data {
+        s8 axis_x;
+        s8 axis_y;
+        s8 axis_z;
+};
+
+This is used to remap device orientation to so that the returned
+data is in line with the device mechanics.
-- 
1.6.3.3
