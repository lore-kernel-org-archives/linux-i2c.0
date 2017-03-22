From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
Date: Wed, 22 Mar 2017 12:06:46 +0100
Message-ID: <1536448.abPucmTQ1N@diego>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <14610453.rKm3MBREMz@diego> <58D250BC.4040609@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <58D250BC.4040609-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Elaine Zhang <zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, yhx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Mittwoch, 22. M=E4rz 2017, 18:23:56 CET schrieb Elaine Zhang:
> On 03/21/2017 04:55 PM, Heiko St=FCbner wrote:
> > Am Donnerstag, 16. M=E4rz 2017, 21:17:22 CET schrieb cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org:
> >> +	cru: clock-controller@ff440000 {
> >> +		compatible =3D "rockchip,rk3328-cru", "rockchip,cru", "syscon";
> >> +		reg =3D <0x0 0xff440000 0x0 0x1000>;
> >> +		rockchip,grf =3D <&grf>;
> >> +		#clock-cells =3D <1>;
> >> +		#reset-cells =3D <1>;
> >> +		assigned-clocks =3D
> >> +			<&cru DCLK_LCDC>, <&cru SCLK_PDM>,
> >> +			<&cru SCLK_RTC32K>, <&cru SCLK_UART0>,
> >> +			<&cru SCLK_UART1>, <&cru SCLK_UART2>,
> >> +			<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> >> +			<&cru ACLK_VIO_PRE>, <&cru ACLK_RGA_PRE>,
> >> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
> >> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
> >> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
> >> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
> >> +			<&cru SCLK_SDIO>, <&cru SCLK_TSP>,
> >> +			<&cru SCLK_WIFI>, <&cru ARMCLK>,
> >> +			<&cru PLL_GPLL>, <&cru PLL_CPLL>,
> >> +			<&cru ACLK_BUS_PRE>, <&cru HCLK_BUS_PRE>,
> >> +			<&cru PCLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> >> +			<&cru HCLK_PERI>, <&cru PCLK_PERI>,
> >> +			<&cru ACLK_VIO_PRE>, <&cru HCLK_VIO_PRE>,
> >> +			<&cru ACLK_RGA_PRE>, <&cru SCLK_RGA>,
> >> +			<&cru ACLK_VOP_PRE>, <&cru ACLK_RKVDEC_PRE>,
> >> +			<&cru ACLK_RKVENC>, <&cru ACLK_VPU_PRE>,
> >> +			<&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>,
> >> +			<&cru SCLK_VENC_CORE>, <&cru SCLK_VENC_DSP>,
> >> +			<&cru SCLK_EFUSE>, <&cru PCLK_DDR>,
> >> +			<&cru ACLK_GMAC>, <&cru PCLK_GMAC>,
> >> +			<&cru SCLK_RTC32K>, <&cru SCLK_USB3OTG_SUSPEND>;
> > =

> > that list is way to long.
> > Device-specific clocks should be inited in their respective device node=
s.
> =

> Cpll init freq is 1200M, is too high. we need set cpll child clk div
> first,and then set cpll freq.
> After pll init, others clk init freq can inited in their device node.

thanks, that is a nice explanation. Please put it into a comment above the =

assigned-clocks property, so that we can keep that knowledge around for lat=
er =

times :-) .


Thanks
Heiko
