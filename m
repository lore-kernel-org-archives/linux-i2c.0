From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-pnx: Adds support for repeated start i2c transactions
Date: Fri, 14 Aug 2015 20:26:04 +0200
Message-ID: <20150814182552.GE1822@katana>
References: <1435450133-7711-1-git-send-email-DJKessler@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435450133-7711-1-git-send-email-DJKessler-BUHhN+a2lJ4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Kessler <djkessler-BUHhN+a2lJ4@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Horton <seanhorton87-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 27, 2015 at 08:08:53PM -0400, David Kessler wrote:
> The i2c-pnx driver implements the i2c specification incorrectly. The
> specification allows for 'repeated start' transactions in which the i2c
> master generates two start conditions without generating a stop condition in
> between them. However, the i2c-pnx driver always generates a stop condition
> after every start condition. This patch correctly implements repeated start
> transactions.

Uh yes, this needs to be fixed. We'd need a few issues of this patch
fixed, first, though. From how I understand the patch, you only use
repeated start for write-then-read messages. You should do it for every
message in a transfer, that is for all messages passed to i2c_pnx_xfer().
This needs rework.

Also, there is not Signed-off line as described in
Documentation/SubmittingPatches, Chapter 11. I need it to apply the
patch.

Some other generic issues:

> @@ -467,6 +480,11 @@ static inline void bus_reset_if_active(struct i2c_pnx_algo_data *alg_data)
>  			alg_data->adapter.name);
>  		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
>  			  I2C_REG_CTL(alg_data));
> +
> +		dev_dbg(&alg_data->adapter.dev,
> +			  "%s: Resetting bus\n", __func__);
> +		iowrite32(0xff | start_bit, I2C_REG_TX(alg_data));
> +

This changes seems unrelated? If so, it should go into a separate patch.

> +setup_repeated_start(struct i2c_adapter *adap, struct i2c_msg *msgs, int num) {
> +	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
> +
> +	if (1 < num && !(msgs[0].flags) && ((msgs[1].flags) & I2C_M_RD)) {

Please use 'var > constant'. This notation is too easy to get wrong.

> +		alg_data->repeated_start = 1;
> +		dev_dbg(&adap->dev,
> +			"%s(): repeated start\n", __func__);
> +	} else if (1 < num) {
> +		alg_data->repeated_start = 0;
> +		dev_dbg(&adap->dev,
> +			"%s(): non-repeated start\n", __func__);
> +	} else if (1 < msgs[0].len) {
> +		alg_data->repeated_start = 0;
> +		if (!msgs[0].flags) {
> +			dev_dbg(&adap->dev,
> +				"%s(): multi-byte write\n", __func__);
> +		} else {
> +			dev_dbg(&adap->dev,
> +				"%s(): multi-byte read\n", __func__);

Too much debug output, I'd think. Once the mechanism works, it won't be
of much use to other developers.

Thanks,

   Wolfram
