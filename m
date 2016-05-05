From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 3/9] i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
Date: Thu, 5 May 2016 15:55:54 -0700
Message-ID: <CAD=FV=XpS4UYR5ORXUOGJXPXBr_Tpc6r87+Tm83KE654ZbkdzA@mail.gmail.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
	<1462371194-5809-4-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34405 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbcEEWzz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 May 2016 18:55:55 -0400
Received: by mail-yw0-f172.google.com with SMTP id j74so149303198ywg.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 May 2016 15:55:55 -0700 (PDT)
In-Reply-To: <1462371194-5809-4-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

David,

On Wed, May 4, 2016 at 7:13 AM, David Wu <david.wu@rock-chips.com> wrote:
> Call rk3x_i2c_setup() before rk3x_i2c_start()
> and the last thing in setup was to clean the IPD,
> so no reason to do it at the beginning of start.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> Change in v7:
> - none
>
>  drivers/i2c/busses/i2c-rk3x.c | 1 -
>  1 file changed, 1 deletion(-)

Looks great.  Thanks for splitting this out from other patches--makes
it much more obvious what's happening!  :)

IMHO this can be applied any time independent of any earlier patches.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
