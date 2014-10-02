From: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: fix 0 length write transfers
Date: Thu, 02 Oct 2014 15:30:47 +0200
Message-ID: <2239755.0FknEeHYOT@typ>
References: <1412185241-24950-1-git-send-email-amstan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412185241-24950-1-git-send-email-amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, ZhengShunQian <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alexandru,

On Wednesday 01 October 2014 at 10:40:41, Alexandru M Stan wrote:
> i2cdetect -q was broken (everything was a false positive, and no transfers
> were actually being sent over i2c). The way it works is by sending a 0
> length write request and checking for NACK. This patch fixes the 0 length
> writes and actually sends them.
> 
> Reported-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Alexandru M Stan <amstan-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index b41d979..f486d0e 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -238,7 +238,7 @@ static void rk3x_i2c_fill_transmit_buf(struct rk3x_i2c
> *i2c) for (i = 0; i < 8; ++i) {
>  		val = 0;
>  		for (j = 0; j < 4; ++j) {
> -			if (i2c->processed == i2c->msg->len)
> +			if ((i2c->processed == i2c->msg->len) && (cnt != 0))
>  				break;
> 
>  			if (i2c->processed == 0 && cnt == 0)

Yes, looks correct and makes i2cdetect work for me on Radxa Rock.

Reviewed-By: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Tested-By: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Cheers,
  Max
