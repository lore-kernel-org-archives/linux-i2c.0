From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v1 0/7] initialize dtsi file and dts file for RK3328 SoCs
Date: Wed, 15 Mar 2017 12:11:54 +0100
Message-ID: <2592337.TJConaiLTi@diego>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1489572237-6649-1-git-send-email-cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, yhx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Liang,

Am Mittwoch, 15. M=E4rz 2017, 18:03:50 CET schrieb cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org:
> From: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> =

> These patchs depend on pinctrl patchs as below:
> =

> https://patchwork.kernel.org/patch/9566427/
> https://patchwork.kernel.org/patch/9566425/
> https://patchwork.kernel.org/patch/9566431/
> =

> Chen Liang (7):
>   include: dt-bindings: Add pin function index definition for rockchip
>     pinctrl
>   dt-bindings: iio: rockchip-saradc: add support for rk3328
>   dt-bindings: i2c: rk3x: add support for rk3328
>   dt-bindings: soc: rockchip: grf: add support for rk3328

both my inbox as well as the linux-rockchip list did only get patches 1-4 i=
t =

seems?

>   arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
>   arm64: dts: rockchip: add dts file for RK3328 evaluation board
>   dt-bindings: document rockchip rk3328-evb board

So right now I'm missing these next 3. Did something go wrong when sending?


Heiko
