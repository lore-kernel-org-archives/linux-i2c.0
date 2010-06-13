From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: Multiplexed I2C bus multiplexer driver
 pca954x
Date: Sun, 13 Jun 2010 14:11:22 +0200
Message-ID: <20100613141122.1d5b1423@hyperion.delvare>
References: <4BE01741.1010909@gmx.de>
	<4BE01795.1090605@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BE01795.1090605-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael,

I just hit a bug...

On Tue, 04 May 2010 14:48:21 +0200, Michael Lawnick wrote:
> +static int pca954x_select_chan(struct i2c_adapter *adap,
> +			       void *client, u32 chan)
> +{
> +	struct pca954x *data = i2c_get_clientdata(client);
> +	const struct chip_desc *chip = &chips[data->type];
> +	u8 regval;
> +	int ret = 0;
> +
> +	/* we make switches look like muxes, not sure how to be smarter */
> +	if (chip->muxtype == pca954x_ismux)
> +		regval = chan | chip->enable;
> +	else
> +		regval = 1 << chan;
> +
> +	/* Only select the channel if its different from the last channel */
> +	if (data->last_chan != chan) {

That's not right. data->last_chan is 0 after initialization or
deselection, but selecting channel 0 is valid and must be possible.

So you either want to use a different initialization value (e.g. 0xff)
or store the register value in data->last_chan instead of the channel
number. I went for the latter.

> +		ret = pca954x_reg_write(adap, client, regval);
> +		data->last_chan = chan;
> +	}
> +
> +	return ret;
> +}

-- 
Jean Delvare
