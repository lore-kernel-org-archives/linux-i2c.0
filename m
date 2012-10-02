From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-mux-gpio: Update documentation
Date: Tue, 2 Oct 2012 23:09:56 +0200
Message-ID: <20121002230956.49c4fe46@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

* Document the possibility to pass relative GPIO pin numbers.
* Document what platform device IDs to use, so that they do not
  collide.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
---
 Documentation/i2c/muxes/i2c-mux-gpio |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- linux-3.7-rc0.orig/Documentation/i2c/muxes/i2c-mux-gpio	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/Documentation/i2c/muxes/i2c-mux-gpio	2012-10-02 23:06:15.131690033 +0200
@@ -63,3 +63,21 @@ static struct platform_device myboard_i2
 		.platform_data	= &myboard_i2cmux_data,
 	},
 };
+
+If you don't know the absolute GPIO pin numbers at registration time,
+you can instead provide a chip name (.chip_name) and relative GPIO pin
+numbers, and the i2c-gpio-mux driver will do the work for you,
+including deferred probing if the GPIO chip isn't immediately
+available.
+
+Device Registration
+-------------------
+
+When registering your i2c-gpio-mux device, you should pass the number
+of any GPIO pin it uses as the device ID. This guarantees that every
+instance has a different ID.
+
+Alternatively, if you don't need a stable device name, you can simply
+pass PLATFORM_DEVID_AUTO as the device ID, and the platform core will
+assign a dynamic ID to your device. If you do not know the absolute
+GPIO pin numbers at registration time, this is even the only option.

-- 
Jean Delvare
