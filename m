From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix bug that cause transfer fails in maste
 receive mode
Date: Thu, 21 Aug 2014 18:14:29 -0700
Message-ID: <CAD=FV=V9uKSSbKFSeiVXAxgaTTc5JMLyr7qPkisRQi9AN6t2-A@mail.gmail.com>
References: <1408657107-8715-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408657107-8715-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, max.schwarz@online.de, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, sergei.shtylyov@cogentembedded.com, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, Eddie Cai <cf@rock-chips.com>, Jianqun Xu <xjq@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, Chris <zyw@rock-chips.com>, =?UTF-8?B?5aea5pm65oOF?= <yzq@rock-chips.com>, han jiang <hj@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Lin Huang <hl@rock-chips.com>, =?UTF-8?B?5pmT6IW+546L?= <caesar.wang@rock-chips.com>, Shunqian Zheng <zhengsq@rock-chips.com>
List-Id: linux-i2c@vger.kernel.org

Addy,

Title should probably have "master", not "maste"

On Thu, Aug 21, 2014 at 2:38 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
> must be less than or equal 32 bytes at a time.
>
> Tested on rk3288-pinky board, elan receive 158 bytes data.
>
> Acked-by: Max Schwarz <max.schwarz@online.de>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> Changes in v2:
> - Use cleaner syntax as suggested by Sergei.
> - Update commit message as suggested by Wolfram.
>
>  drivers/i2c/busses/i2c-rk3x.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 69e1185..806724a 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -323,6 +323,10 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c *i2c, unsigned int ipd)
>         /* ack interrupt */
>         i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
>
> +       /* Can only handle a maximum of 32 bytes at a time */
> +       if (unlikely(len > 32))
> +               len  = 32;

nit: one space before "=", not two.

Tested-by: Doug Anderson <dianders@chromium.org>
