From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
Date: Thu, 24 Aug 2017 11:21:11 +0200
Message-ID: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

	Hi all,

The current i2c-gpio DT bindings use a single unnamed "gpios" property
to refer to the SDA and SCL signal lines by index.  This is error-prone
for the casual DT writer and reviewer, as one has to look up the order
in the DT bindings, and leads to the addition of comments in DTS files,
like

	gpios = <&pfc 208 GPIO_ACTIVE_HIGH /* sda */
		 &pfc 91 GPIO_ACTIVE_HIGH /* scl */
		>;

This patch series:
  - Amends the DT bindings to use named gpios,
  - Adds support for the new bindings to the driver,
  - Converts the armadillo800eva to use the new bindings, as an example.

Thanks for your comments!

Geert Uytterhoeven (3):
  dt-bindings: i2c: i2c-gpio: Add support for named gpios
  i2c: gpio: Add support for named gpios in DT
  ARM: dts: armadillo800eva: Convert to named i2c-gpio bindings

 Documentation/devicetree/bindings/i2c/i2c-gpio.txt | 5 +++--
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      | 5 ++---
 drivers/i2c/busses/i2c-gpio.c                      | 9 +++++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
