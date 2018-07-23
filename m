From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH 12/12] i2c: sh_mobile: use core to detect 'no zero length
 read' quirk
Date: Mon, 23 Jul 2018 22:54:10 +0200
Message-ID: <20180723205410.GI1432@bigcity.dyn.berto.se>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-13-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723202617.15230-13-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2018-07-23 22:26:16 +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
>  drivers/i2c/busses/i2c-sh_mobile.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 5fda4188a9e5..9c7f6f8ceb22 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -613,11 +613,6 @@ static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
>  static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
>  		    bool do_init)
>  {
> -	if (usr_msg->len == 0 && (usr_msg->flags & I2C_M_RD)) {
> -		dev_err(pd->dev, "Unsupported zero length i2c read\n");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	if (do_init) {
>  		/* Initialize channel registers */
>  		iic_wr(pd, ICCR, ICCR_SCP);
> @@ -758,6 +753,10 @@ static const struct i2c_algorithm sh_mobile_i2c_algorithm = {
>  	.master_xfer	= sh_mobile_i2c_xfer,
>  };
>  
> +static const struct i2c_adapter_quirks sh_mobile_i2c_quirks = {
> +	.flags = I2C_AQ_NO_ZERO_LEN_READ,
> +};
> +
>  /*
>   * r8a7740 chip has lasting errata on I2C I/O pad reset.
>   * this is work-around for it.
> @@ -925,6 +924,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
>  
>  	adap->owner = THIS_MODULE;
>  	adap->algo = &sh_mobile_i2c_algorithm;
> +	adap->quirks = &sh_mobile_i2c_quirks;
>  	adap->dev.parent = &dev->dev;
>  	adap->retries = 5;
>  	adap->nr = dev->id;
> -- 
> 2.11.0
> 

-- 
Regards,
Niklas Söderlund
