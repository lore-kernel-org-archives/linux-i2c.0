From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: [PATCH 7/7] iio: srf08: change text in Kconfig
Date: Thu, 3 Aug 2017 01:26:34 +0200
Message-ID: <20170802232634.GA15420@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Changed text in menu entry and help text to reflect recent changes

Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
---
 drivers/iio/proximity/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 5b81a8c9d438..7a06ef4ced39 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -57,14 +57,14 @@ config SX9500
 	  module will be called sx9500.
 
 config SRF08
-	tristate "Devantech SRF08 ultrasonic ranger sensor"
+	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
 	depends on I2C
 	help
-	  Say Y here to build a driver for Devantech SRF08 ultrasonic
-	  ranger sensor. This driver can be used to measure the distance
-	  of objects.
+	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
+	  ultrasonic ranger sensor with I2C interfaces. This driver can be
+	  used to measure the distance of objects.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called srf08.
+	  To compile this driver as a module, choose M here: the module will
+	  be called srf08.
 
 endmenu
-- 
2.1.4


-- 
