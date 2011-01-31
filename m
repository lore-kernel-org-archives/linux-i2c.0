From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: [PATCH 2/3] of: of_gpiochip_add is needed only for gpiolib
Date: Mon, 31 Jan 2011 23:25:50 +0800
Message-ID: <1296487551-30938-2-git-send-email-thomas@wytron.com.tw>
References: <AANLkTimS70uHqmv3jhr+7mPz4QFKXRXuFnWj8s3EpKsO@mail.gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimS70uHqmv3jhr+7mPz4QFKXRXuFnWj8s3EpKsO-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some gpio drivers may not use gpiolib. In this case, struct gpio_chip
is not defined and of_gpiochip_add/remove are not needed.

Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
---
 include/linux/of_gpio.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 6598c04..fc96af0 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -71,9 +71,13 @@ static inline unsigned int of_gpio_count(struct device_node *np)
 	return 0;
 }
 
+#ifdef CONFIG_GPIOLIB
+
 static inline void of_gpiochip_add(struct gpio_chip *gc) { }
 static inline void of_gpiochip_remove(struct gpio_chip *gc) { }
 
+#endif /* CONFIG_GPIOLIB */
+
 #endif /* CONFIG_OF_GPIO */
 
 /**
-- 
1.7.3.5
