From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 7/9] dt-bindings: i2c: rk3x: add support for rk3399
Date: Thu, 5 May 2016 15:59:58 -0700
Message-ID: <CAD=FV=XXojzZiVFuXuChZdDeTxE6tFSJZ=8FqLpVTG2L6xWpBg@mail.gmail.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
	<1462372523-6444-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36620 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758009AbcEEW77 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 18:59:59 -0400
Received: by mail-yw0-f177.google.com with SMTP id o66so169757023ywc.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 May 2016 15:59:59 -0700 (PDT)
In-Reply-To: <1462372523-6444-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Wed, May 4, 2016 at 7:35 AM, David Wu <david.wu@rock-chips.com> wrote:
> The bus clock and function clock are separated at rk3399,
> and others use one clock as the bus clock and function clock.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> index 0b4a85f..82b6f6b 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> @@ -6,10 +6,20 @@ RK3xxx SoCs.
>  Required properties :
>
>   - reg : Offset and length of the register set for the device
> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
> -               "rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
> + - compatible: should be one of the followings
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
> +       for the device and as the bus clock.  REQUIRED.
> +   - For newer hardware (rk3399): specify by name
> +     - "i2c": REQUIRED. This is used to derive the functional clock.
> +     - "pclk": REQUIRED. This is the bus clock.equired on RK3066, RK3188 :

Looks great except that you need to delete the "equired on RK3066,
RK3188 :" part, which looks like it was leftover from some sort of
copy/paste.

Once that is done, feel free to add my Reviewed-by tag.


-Doug
