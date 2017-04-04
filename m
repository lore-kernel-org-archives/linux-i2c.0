From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4 4/6] arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
Date: Tue, 04 Apr 2017 18:04:03 +0200
Message-ID: <6636047.jL6XHNkknt@phil>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com> <1490607650-18650-4-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490607650-18650-4-git-send-email-cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am Montag, 27. März 2017, 17:40:48 CEST schrieb cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org:
> From: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> This patch adds core dtsi file for Rockchip RK3328 SoCs.
> 
> Signed-off-by: Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

applied for 4.12, with the following list of changes:

- reorder some properties to bring them in alphabetical order
- dropped the status-disabled from the power-controller
  power-domain control is a quite essential part of the system, so if
  boards really want to disable them, they should do it in their board file
  Having power-domains on all the time, is also our default in all other
  devicetrees.
- removed #dma-cells from spi0 -> this is not a dma controller
- reword the cru assigned-clocks comment a bit
- fixed sdmmc1_bus4 pins, as indicated by Shawn and after looking up the
  correct pins in the manual


And a final question, are you sure about SCLK_PDM becoming a child of the
APLL in your cru assigned-clocks, as the APLL will vary later on with cpufreq
active?


Heiko
