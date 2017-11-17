From: jacopo mondi <jacopo@jmondi.org>
Subject: Re: [PATCH RFT] i2c: sh_mobile: make sure to not accidently trigger
 STOP
Date: Fri, 17 Nov 2017 11:05:10 +0100
Message-ID: <20171117100510.GF4668@w540>
References: <20171115143221.30618-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171115143221.30618-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, Nov 15, 2017 at 03:32:21PM +0100, Wolfram Sang wrote:
> The datasheet was a bit vague, but after consultation with HW designers,
> we came to the conclusion that we should set the SCP bit always when
> dealing only with the ICE bit. A set SCP bit is ignored, and thus fine,
> a cleared one may trigger STOP on the bus.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Jacopo: another to test, please. On top of all the other patches. Thank you!

and for this one as well, on Migo-R no visible regressions. I2c sensor
probes properly, and I can capture images.

Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

>
>  drivers/i2c/busses/i2c-sh_mobile.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 9012d5f8fb38b8..c2841a4f5807c0 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -604,10 +604,10 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
>
>  	if (do_init) {
>  		/* Initialize channel registers */
> -		iic_wr(pd, ICCR, 0);
> +		iic_wr(pd, ICCR, ICCR_SCP);
>
>  		/* Enable channel and configure rx ack */
> -		iic_wr(pd, ICCR, ICCR_ICE);
> +		iic_wr(pd, ICCR, ICCR_ICE | ICCR_SCP);
>
>  		/* Set the clock */
>  		iic_wr(pd, ICCL, pd->iccl & 0xff);
> @@ -723,7 +723,7 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
>  	}
>
>  	/* Disable channel */
> -	iic_wr(pd, ICCR, 0);
> +	iic_wr(pd, ICCR, ICCR_SCP);
>
>  	/* Disable clock and mark device as idle */
>  	pm_runtime_put_sync(pd->dev);
> --
> 2.11.0
>
