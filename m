From: <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 3/6] dt-bindings: soc: rockchip: grf: add support for rk3328
Date: Fri, 24 Mar 2017 19:01:24 +0800
Message-ID: <1490353287-25122-4-git-send-email-cl@rock-chips.com>
References: <1490353287-25122-1-git-send-email-cl@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490353287-25122-1-git-send-email-cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Signed-off-by: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index a0685c2..de8b983 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -16,6 +16,7 @@ Required Properties:
    - "rockchip,rk3188-grf", "syscon": for rk3188
    - "rockchip,rk3228-grf", "syscon": for rk3228
    - "rockchip,rk3288-grf", "syscon": for rk3288
+   - "rockchip,rk3328-grf", "syscon": for rk3328
    - "rockchip,rk3368-grf", "syscon": for rk3368
    - "rockchip,rk3399-grf", "syscon": for rk3399
 - compatible: PMUGRF should be one of the following:
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
