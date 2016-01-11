From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH v2 4/4] doc: ABI: Add documentation for the additional sysfs
 status information
Date: Mon, 11 Jan 2016 13:22:06 +0100
Message-ID: <4b1d3e1a153f88aed0f0cb80730d210dfeb7dce8.1452514293.git.andreas.werner@men.de>
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

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 .../ABI/testing/sysfs-bus-i2c-devices-menf21bmc    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc b/Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc
index 28d1fa2..6defdd3 100644
--- a/Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc
@@ -12,3 +12,29 @@ Description:	Set and get the mode of the device.
 
 		0 = production mode
 		1 = active mode
+
+What:		/sys/bus/i2c/devices/.../hw_variant
+Date:		December 2015
+KernelVersion:	4.4
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:	Set and get the hardware variant ID.
+
+What:		/sys/bus/i2c/devices/.../pwrcycl_cnt
+Date:		December 2015
+KernelVersion:	4.4
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:	Read the BMC powercycle counter.
+
+What:		/sys/bus/i2c/devices/.../op_hrs_cnt
+Date:		December 2015
+KernelVersion:	4.4
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:	Read the operation hours counter
+
+What:		/sys/bus/i2c/devices/.../slot_address
+Date:		December 2015
+KernelVersion:	4.4
+Contact:	Andreas Werner <andreas.werner@men.de>
+Description:	Read the slot address of the board.
+		Slot address is the geographical address
+		in a CPCI rack/backplane.
-- 
2.6.2
