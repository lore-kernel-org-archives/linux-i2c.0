From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 3/5] i2c: at91: add support for new alternative
 command mode
Date: Mon, 1 Jun 2015 19:51:54 +0200
Message-ID: <20150601175154.GN4710@piout.net>
References: <cover.1433173031.git.cyrille.pitchen@atmel.com>
 <82c39f262f553a43ea9208b4f9804bbf26a62d90.1433173031.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <82c39f262f553a43ea9208b4f9804bbf26a62d90.1433173031.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 01/06/2015 at 17:49:13 +0200, Cyrille Pitchen wrote :
> @@ -504,8 +589,22 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
>  		at91_twi_write(dev, AT91_TWI_IADR, internal_address);
>  	}
>  
> -	at91_twi_write(dev, AT91_TWI_MMR, (m_start->addr << 16) | int_addr_flag
> -		       | ((m_start->flags & I2C_M_RD) ? AT91_TWI_MREAD : 0));
> +	is_read = (m_start->flags & I2C_M_RD);
> +	if (dev->pdata->has_alt_cmd) {
> +		if (m_start->len > 0) {
> +			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMEN);
> +			at91_twi_write(dev, AT91_TWI_ACR,
> +				       AT91_TWI_ACR_DATAL(m_start->len) |
> +				       ((is_read) ? AT91_TWI_ACR_DIR : 0));
> +			use_alt_cmd = true;
> +		} else
> +			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_ACMDIS);

braces {} should be used on all arms of this statement



-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
