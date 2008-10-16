From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,
	remove} calls
Date: Thu, 16 Oct 2008 21:12:59 +0400
Message-ID: <20081016171259.GD5515@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081016171222.GA24812-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Steven A. Falco" <sfalco-7/gz0mrWfc7QT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Any GPIO controller that have a device associated with it is encouraged to
register/unregister the gpiochips with dev_gpiochip_*() calls.

Platform may redefine these calls to glue the gpiochips with the
architecture-specific code.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 include/asm-generic/gpio.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 0f99ad3..f31c7ae 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -89,6 +89,50 @@ extern int __must_check gpiochip_reserve(int start, int ngpio);
 extern int gpiochip_add(struct gpio_chip *chip);
 extern int __must_check gpiochip_remove(struct gpio_chip *chip);
 
+/*
+ * Platforms can define their own __dev_ versions to glue gpio_chips with the
+ * architecture-specific code.
+ */
+#ifndef __dev_gpiochip_add
+#define __dev_gpiochip_add __dev_gpiochip_add
+static inline int __dev_gpiochip_add(struct device *dev,
+				     struct gpio_chip *chip)
+{
+	chip->dev = dev;
+	return gpiochip_add(chip);
+}
+#endif /* __dev_gpiochip_add */
+
+#ifndef __dev_gpiochip_remove
+#define __dev_gpiochip_remove __dev_gpiochip_remove
+static inline int __dev_gpiochip_remove(struct device *dev,
+					struct gpio_chip *chip)
+{
+	return gpiochip_remove(chip);
+}
+#endif /* __dev_gpiochip_remove */
+
+/**
+ * dev_gpiochip_add - register a gpio_chip for a device
+ * @dev: device to register gpio_chip for
+ * @chip: the chip to register
+ * Context: potentially before irqs or kmalloc will work
+ *
+ * This function takes the extra @dev argument that is used to associate
+ * the chip with a device. Otherwise it behaves the same way as the
+ * gpiochip_add().
+ */
+#define dev_gpiochip_add(dev, chip) __dev_gpiochip_add((dev), (chip))
+
+/**
+ * dev_gpiochip_remove - unregister a gpio_chip
+ * @dev: device to remove the chip from
+ * @chip: the chip to unregister
+ *
+ * Use this function to unregister the chip that was registered using
+ * dev_gpiochip_add().
+ */
+#define dev_gpiochip_remove(dev, chip) __dev_gpiochip_remove((dev), (chip))
 
 /* Always use the library code for GPIO management calls,
  * or when sleeping may be involved.
-- 
1.5.6.3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
