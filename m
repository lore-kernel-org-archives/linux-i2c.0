From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v1 3/7] dt-bindings: i2c: rk3x: add support for rk3328
Date: Thu, 16 Mar 2017 09:29:17 +0100
Message-ID: <1968844.OUeqAadBkl@phil>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com> <1489572237-6649-4-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489572237-6649-4-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cl@rock-chips.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com, andy.yan@rock-chips.com, jay.xu@rock-chips.com, matthias.bgg@gmail.com, paweljarosz3691@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wxt@rock-chips.com, david.wu@rock-chips.com, linux-iio@vger.kernel.org, shawn.lin@rock-chips.com, akpm@linux-foundation.org, dianders@chromium.org, yamada.masahiro@socionext.com, catalin.marinas@arm.com, will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org, khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com
List-Id: linux-i2c@vger.kernel.org

Am Mittwoch, 15. März 2017, 18:03:53 CET schrieb cl@rock-chips.com:
> From: Chen Liang <cl@rock-chips.com>
> 
> The rk3328 i2c is the same as rk3399
> 
> Signed-off-by: Chen Liang <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt index bbc5a1e..abfdefd
> 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> @@ -12,6 +12,7 @@ Required properties :
>     - "rockchip,rk3228-i2c": for rk3228
>     - "rockchip,rk3288-i2c": for rk3288
>     - "rockchip,rk3399-i2c": for rk3399
> +   - "rockchip,rk3328-i2c", "rockchip,rk3399-i2c": for rk3328
>   - interrupts : interrupt number
>   - clocks: See ../clock/clock-bindings.txt
>     - For older hardware (rk3066, rk3188, rk3228, rk3288):

same as before, not sure how people see that, but maybe place rk3328 before 
rk3399.
