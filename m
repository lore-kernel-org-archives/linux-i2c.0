From: Caesar Wang <sasukewxt@163.com>
Subject: Re: [PATCH] i2c: rk3x: Increase wait timeout to 1 second
Date: Fri, 01 May 2015 11:42:53 +0800
Message-ID: <5542F63D.3000402@163.com>
References: <1430430247-9632-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430430247-9632-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Addy Ke <addy.ke@rock-chips.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Max Schwarz <max.schwarz@online.de>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



=E5=9C=A8 2015=E5=B9=B405=E6=9C=8801=E6=97=A5 05:44, Doug Anderson =E5=86=
=99=E9=81=93:
> While it's not sensible for an i2c command to _actually_ need more
> than 200ms to complete, let's increase the timeout anyway.  Why?  It
> turns out that if you've got a large number of printks going out to a
> serial console, interrupts on a CPU can be disabled for hundreds of
> milliseconds. That's not a great situation to be in to start with
> (maybe we should put a cap in vprintk_emit()) but it's pretty annoyin=
g
> to start seeing unexplained i2c timeouts.
>
> A normal system shouldn't see i2c timeouts anyway, so increasing the
> timeout should help people debugging without hurting other people
> excessively.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>   drivers/i2c/busses/i2c-rk3x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-r=
k3x.c
> index 019d542..72e97e30 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -72,7 +72,7 @@ enum {
>   #define REG_INT_ALL       0x7f
>  =20
>   /* Constants */
> -#define WAIT_TIMEOUT      200 /* ms */
> +#define WAIT_TIMEOUT      1000 /* ms */
Yeah,verified on veyron device.

Tested-by: Caesar Wang <wxt@rock-chips.com>

Thanks.
Caesar

>   #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
>  =20
>   enum rk3x_i2c_state {
