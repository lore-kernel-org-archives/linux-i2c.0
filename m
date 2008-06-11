From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch/rfc 2.6.26-rc5] i2c: schedule legacy gpio driver
	removal
Date: Wed, 11 Jun 2008 13:17:20 -0700
Message-ID: <200806111317.21060.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Just sending this as an RFC ... clearly it shouldn't merge until
the GPIO_SYSFS code merges, which I'm assuming is 2.6.27.  And
presumably Jean will want to be the "who removes this"?

I think the only other blocking issue would be a way to configure
such new-style drivers from sysfs, primarily for one-off hardware
hacking usage (in at least this case).  Teaching the two new-style
drivers to use dynamic GPIO number allocation when there's no
platform_data is trivial, and not otherwise desirable.

- Dave


=========== CUT HERE
--- a/Documentation/feature-removal-schedule.txt	2008-06-11 12:00:20.000000000 -0700
+++ b/Documentation/feature-removal-schedule.txt	2008-06-11 13:10:44.000000000 -0700
@@ -312,3 +312,21 @@ When:	2.6.26
 Why:	Implementation became generic; users should now include
 	linux/semaphore.h instead.
 Who:	Matthew Wilcox <willy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+
+---------------------------
+
+What:	drivers/i2c/chips/{pca9539,pcf8574,pcf8575}.c
+When:	January 2010
+Why:	replaced by gpiolib and GPIO_SYSFS with
+	drivers/gpio/{pca953x,pcf857x}.c
+
+	The gpiolib I2C adapter drivers support more chips and moved
+	away from legacy driver binding.  From the embedded systems
+	perspective, they provide a critical capability missing in
+	those now-obsoleted drivers:  GPIOs are now accessible to
+	in-kernel code for common uses like LED control, switching
+	power domains, and chip configuration.
+
+	With GPIO_SYSFS the userspace interface is a bit different,
+	but is more generic and is available for use with all GPIO
+	controllers.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
