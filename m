From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 0/4] ARM: dts: renesas: Convert to named i2c-gpio bindings
Date: Thu, 30 Nov 2017 13:57:22 +0100
Message-ID: <1512046646-15253-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

	Hi Simon, Magnus,

Commits 7d29f509d2cfd807 ("dt-bindings: i2c: i2c-gpio: Add support for
named gpios") and 05c74778858d7d99 ("i2c: gpio: Add support for named
gpios in DT") introduced named i2c-gpio DT bindings, and deprecated the
more error-prone unnamed variant.

This patch series switches all Renesas boards to the new bindings, and
adds the missing GPIO_OPEN_DRAIN I/O flags, which were implicitly
assumed before.  The latter gets rid of messages like:

    gpio-208 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file
    gpio-91 (?): enforced open drain please flag it properly in DT/ACPI DSDT/board file

Patch 1 was extracted from series "[PATCH/RFC 0/3] i2c: gpio: Add
support for named gpios in DT", hence the v2.  All other patches are
new.

Note that after this series is applied, the i2c-gpio buses are no longer
detected when booting new DTBs on old (v4.14 and older) kernels, which
should not be an issue.  Booting old DTBs on new kernels is not
affected.

Thanks for applying!

Geert Uytterhoeven (4):
  ARM: dts: armadillo800eva: Convert to named i2c-gpio bindings
  ARM: dts: lager: Convert to named i2c-gpio bindings
  ARM: dts: koelsch: Convert to named i2c-gpio bindings
  ARM: dts: alt: Convert to named i2c-gpio bindings

 arch/arm/boot/dts/r8a7740-armadillo800eva.dts    | 5 ++---
 arch/arm/boot/dts/r8a7790-lager.dts              | 5 ++---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 5 ++---
 arch/arm/boot/dts/r8a7794-alt.dts                | 5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

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
