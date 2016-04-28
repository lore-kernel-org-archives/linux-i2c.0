From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6] i2c: rk3x: add i2c support for rk3399 soc
Date: Thu, 28 Apr 2016 14:28:34 -0700
Message-ID: <CAD=FV=WxoZArMyhAPEmhG4FVHqhd-snMt59_Hk=BVsP2hZBxpw@mail.gmail.com>
References: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
	<1461074137-23899-1-git-send-email-david.wu@rock-chips.com>
	<CAD=FV=U7Vsnh8RZjZ=an0Sfb+soS=+v1icoH=kL1huCR_9TTgA@mail.gmail.com>
	<572212AE.5060904@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35170 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbcD1V2f (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Apr 2016 17:28:35 -0400
Received: by mail-yw0-f176.google.com with SMTP id g133so129297645ywb.2
        for <linux-i2c@vger.kernel.org>; Thu, 28 Apr 2016 14:28:34 -0700 (PDT)
In-Reply-To: <572212AE.5060904@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "David.Wu" <david.wu@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Tao Huang <huangtao@rock-chips.com>, Lin Huang <hl@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Chris <zyw@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Wu <wdc@rock-chips.com>, Brian Norris <briannorris@google.com>, David Riley <davidriley@google.com>

Hi,

On Thu, Apr 28, 2016 at 6:39 AM, David.Wu <david.wu@rock-chips.com> wrote:
> +enum rk3x_i2c_bus_speed {
> +       I2C_FS_SPD,
> +       I2C_HS_SPD
> +};
> +
> +struct rk3x_i2c;
>
> Why do you need this forward definition?  Seems like it's not
> necessary.  Remove?
>
>
> I think we need a Master_Code state to seperate from other state.

I meant remove the line above the contains just:

  struct rk3x_i2c;

...I don't believe it's needed.  You only need a forward declaration
like that if you refer to the structure before it's defined.


-Doug
