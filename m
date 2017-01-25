From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: [PATCH v4 3/3] iio: distance: srf08: add driver ABI documentation
Date: Wed, 25 Jan 2017 20:07:47 +0100
Message-ID: <20170125190747.GA9285@andreas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ak-n176/SwNRljddJNmlsFzeA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add sysfs-bus-iio-distance-srf08 for individual attributes of the driver,
especially:
 - sensitivity which the device documentation calls gain for amplifying the
   signal
 - max_range for limiting the maximum distance for expected echos and
   therefore limiting the time waiting for telegrams

Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
---
 .../ABI/testing/sysfs-bus-iio-distance-srf08       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
new file mode 100644
index 000000000000..0a1ca1487fa9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
@@ -0,0 +1,22 @@
+What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
+Date:		January 2017
+KernelVersion:	4.11
+Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+Description:
+		Show or set the gain boost of the amp, from 0-31 range.
+		default 31
+
+What		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
+Date:		January 2017
+KernelVersion:	4.11
+Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+Description:
+                Show or set the maximum range between the sensor and the
+		first object echoed in meters. Default value is 6.020.
+		This setting limits the time the driver is waiting for a
+		echo.
+		Showing the range of available values is represented as the
+		minimum value, the step and the maximum value, all enclosed
+		in square brackets.
+		Example:
+		[0.043 0.043 11.008]
-- 
2.1.4
