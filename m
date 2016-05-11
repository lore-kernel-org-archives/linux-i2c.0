From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v8 6/8] dt-bindings: i2c: rk3x: add support for rk3399
Date: Wed, 11 May 2016 09:35:29 -0700
Message-ID: <CAD=FV=VzL8AfzUnPYgsf_NqPgbp2_o_qJC7-DWHmekWVQ-Es=A@mail.gmail.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
	<1462908647-27236-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462908647-27236-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Tue, May 10, 2016 at 12:30 PM, David Wu <david.wu@rock-chips.com> wrote:
> The bus clock and function clock are separated at rk3399,
> and others use one clock as the bus clock and function clock.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Change in v8:
> - remove error description.
>
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> index 0b4a85f..5429301 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> @@ -6,10 +6,20 @@ RK3xxx SoCs.
>  Required properties :
>
>   - reg : Offset and length of the register set for the device
> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
> -               "rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
> + - compatible: should be one of the following:
> +   - "rockchip,rk3066-i2c": for rk3066
> +   - "rockchip,rk3188-i2c": for rk3188
> +   - "rockchip,rk3228-i2c": for rk3228
> +   - "rockchip,rk3288-i2c": for rk3288
> +   - "rockchip,rk3399-i2c": for rk3399
>   - interrupts : interrupt number
> - - clocks : parent clock
> + - clocks: See ../clock/clock-bindings.txt
> +   - For older hardware (rk3066, rk3188, rk3228, rk3288):
> +     - There is one clock that's used both to derive the functional clock
> +       for the device and as the bus clock.
> +   - For newer hardware (rk3399): specified by name
> +     - "i2c": REQUIRED. This is used to derive the functional clock.
> +     - "pclk": REQUIRED. This is the bus clock.

Depending on what Rob thinks, it might make sense to remove the above
two "REQUIRED" bits.  That would match his earlier feedback since
we're still in the "Required" section and thus it is redundant.

-Doug
