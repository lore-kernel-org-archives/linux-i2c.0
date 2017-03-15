From: <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v1 0/7] initialize dtsi file and dts file for RK3328 SoCs
Date: Wed, 15 Mar 2017 18:03:50 +0800
Message-ID: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

These patchs depend on pinctrl patchs as below:

https://patchwork.kernel.org/patch/9566427/
https://patchwork.kernel.org/patch/9566425/
https://patchwork.kernel.org/patch/9566431/

Chen Liang (7):
  include: dt-bindings: Add pin function index definition for rockchip
    pinctrl
  dt-bindings: iio: rockchip-saradc: add support for rk3328
  dt-bindings: i2c: rk3x: add support for rk3328
  dt-bindings: soc: rockchip: grf: add support for rk3328
  arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
  arm64: dts: rockchip: add dts file for RK3328 evaluation board
  dt-bindings: document rockchip rk3328-evb board

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |    1 +
 .../bindings/iio/adc/rockchip-saradc.txt           |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |   57 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 1362 ++++++++++++++++++++
 include/dt-bindings/pinctrl/rockchip.h             |    3 +
 8 files changed, 1430 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
