From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v1 2/7] dt-bindings: iio: rockchip-saradc: add support for
 rk3328
Date: Thu, 16 Mar 2017 09:28:23 +0100
Message-ID: <8664375.8vdE6CQfX9@phil>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com>
 <1489572237-6649-3-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489572237-6649-3-git-send-email-cl@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: cl@rock-chips.com
Cc: mark.rutland@arm.com, wsa@the-dreams.de, linux-iio@vger.kernel.org, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, kever.yang@rock-chips.com, dianders@chromium.org, yamada.masahiro@socionext.com, tony.xie@rock-chips.com, linux-i2c@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de, zhengxing@rock-chips.com, khilman@baylibre.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, zhangqing@rock-chips.com, paweljarosz3691@gmail.com, arnd@arndb.de, yhx@rock-chips.com, knaack.h@gmx.de, robh+dt@kernel.org, matthias.bgg@gmail.com, rocky.hao@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david.wu@rock-chips.com, fabio.estevam@nxp.com, andy.yan@rock-chips.com, akpm@linux-foundation.org, shawnguo@kernel.org, afaerber@suse.de, jic23@kernel
List-Id: linux-i2c@vger.kernel.org

Am Mittwoch, 15. M=E4rz 2017, 18:03:52 CET schrieb cl@rock-chips.com:
> From: Chen Liang <cl@rock-chips.com>
> =

> The rk3328 saradc is the same as rk3399.
> =

> Signed-off-by: Chen Liang <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt index
> 205593f..f81bc20 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> @@ -5,6 +5,7 @@ Required properties:
>     - "rockchip,saradc": for rk3188, rk3288
>     - "rockchip,rk3066-tsadc": for rk3036
>     - "rockchip,rk3399-saradc": for rk3399
> +   - "rockchip,rk3328-saradc", "rockchip,rk3399-saradc": for rk3328

not sure how iio people see that, but I would suggest keeping the order, so =

put rk3328 above rk3399.

Heiko
