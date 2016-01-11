From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH v2 2/4] doc: ABI: Added sysfs description for the menf21bmc
 MFD driver
Date: Mon, 11 Jan 2016 13:21:34 +0100
Message-ID: <ca9cc7d9ae77180522e8c1a964c7222219083bcf.1452514293.git.andreas.werner@men.de>
References: <cover.1452514293.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1452514293.git.andreas.werner@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, sameo@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This patch add the description of the "mode" sysfs interface
for the menf21bmc MFD driver.

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc b/Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc
new file mode 100644
index 0000000..28d1fa2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc
@@ -0,0 +1,14 @@
+What:		/sys/bus/i2c/devices/.../mode
+Date:		December 2015
+KernelVersion:	4.4
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:	Set and get the mode of the device.
+		The production mode cannot be set again if the device
+		is set to active once.
+
+		In production mode the BMC does not wait for BIOS life sign,
+		did not reset the CPU board on Watchdog timeout and allow the
+		programming of the HW Variant.
+
+		0 = production mode
+		1 = active mode
-- 
2.6.2
