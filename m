From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 21/22] i2c-designware: Tx abort cleanups
Date: Thu, 12 Nov 2009 13:29:46 +0900
Message-ID: <4AFB8F3A.6060208@necel.com>
References: <4AF419B6.1000802@necel.com> <4AF41BED.1050406@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF41BED.1050406-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Baruch,

Shinya Kuribayashi wrote:
> * ABRT_MASTER_DIS: Fix a typo.
> 
> * i2c_dw_handle_tx_abort: Return an appropriate error number
>   depending on abort_source.
> 
> * i2c_dw_xfer: Add a missing abort_source initialization.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>

[ ... ]

> @@ -472,6 +490,24 @@ i2c_dw_read(struct dw_i2c_dev *dev)
>  	}
>  }
>  
> +static int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
> +{
> +	unsigned long abort_source = dev->abort_source;
> +	int i;
> +
> +	for_each_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
> +		dev_err(dev->dev, "%s: %s\n", __func__, abort_sources[i]);

Dev_err() might be annoying when we use sort of misc utilities
such as i2c-tools.  In case of no ACKs, we sometimes don't want
to see error messages in the console, because such tools are
sometimes capable of generating human-friendly console output
like,

 root@localhost:/root> i2cdetect -y -r 2
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
 10: -- -- -- -- -- -- -- -- ...

 root@localhost:/root> i2cdump -y 0 0x49 b
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
 10: XX XX XX XX XX XX  ....

Then how do I change dev_err() here?  I'm not sure dev_dbg() or
other variants are acceptable for no ACKs or arbitration cases.
Could someone give me a comment?  I'll prepare patches for it.

Thanks in advance,

> +	if (abort_source & DW_IC_TX_ARB_LOST)
> +		return -EAGAIN;
> +	else if (abort_source & DW_IC_TX_ABRT_NOACK)
> +		return -EREMOTEIO;
> +	else if (abort_source & DW_IC_TX_ABRT_GCALL_READ)
> +		return -EINVAL; /* wrong msgs[] data */
> +	else
> +		return -EIO;
> +}
> +
>  /*
>   * Prepare controller for a transaction and call i2c_dw_xfer_msg
>   */

-- 
Shinya Kuribayashi
NEC Electronics
