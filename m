From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 2/3] i2c: gpio: Add support for named gpios in DT
Date: Thu, 24 Aug 2017 11:21:13 +0200
Message-ID: <1503566474-5335-3-git-send-email-geert+renesas@glider.be>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1503566474-5335-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add support for the new DT bindings using named gpios, which are less
error-prone than unnamed gpios.  The latter are still supported as a
fallback.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 0ef8fcc6ac3aca1e..45b7ec99dc210bbe 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -88,6 +88,15 @@ static int i2c_gpio_getscl(void *data)
 static int of_i2c_gpio_get_pins(struct device_node *np,
 				unsigned int *sda_pin, unsigned int *scl_pin)
 {
+	*sda_pin = of_get_named_gpio(np, "sda-gpios", 0);
+	*scl_pin = of_get_named_gpio(np, "scl-gpios", 0);
+	if (*sda_pin == -EPROBE_DEFER || *scl_pin == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (gpio_is_valid(*sda_pin) && gpio_is_valid(*scl_pin))
+		return 0;
+
+	/* Try deprecated unnamed gpios */
 	if (of_gpio_count(np) < 2)
 		return -ENODEV;
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
