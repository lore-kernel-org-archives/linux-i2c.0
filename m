From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix divisor calculation for SCL frequency
Date: Sun, 7 Sep 2014 21:15:16 -0700
Message-ID: <CAD=FV=WY=wS6P5f4BVfoyy8EWvrn9Mzh=wkOXBiEiJyQ-HNM=Q@mail.gmail.com>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
	<1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, max.schwarz@online.de, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, Eddie Cai <cf@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, Chris <zyw@rock-chips.com>, =?UTF-8?B?5aea5pm65oOF?= <yzq@rock-chips.com>, han jiang <hj@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Lin Huang <hl@rock-chips.com>, =?UTF-8?B?5pmT6IW+546L?= <caesar.wang@rock-chips.com>, Shunqian Zheng <zhengsq@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

Addy,

On Sun, Sep 7, 2014 at 8:38 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> I2C_CLKDIV register descripted in the previous version of
> RK3x chip manual is incorrect. Plus 1 is required.
>
> The correct formula:
> - T(SCL_HIGH) = T(PCLK) * (CLKDIVH + 1) * 8
> - T(SCL_LOW) = T(PCLK) * (CLKDIVL + 1) * 8
> - (SCL Divsor) = 8 * ((CLKDIVL + 1) + (CLKDIVH + 1))
> - SCL = PCLK / (CLK Divsor)
>
> It will be updated to the latest version of chip manual.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> changes since v1:
> - make it more cleaner, suggested by Doug Anderson
>
>  drivers/i2c/busses/i2c-rk3x.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
