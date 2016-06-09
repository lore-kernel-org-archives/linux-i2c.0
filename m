From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [v2,08/10] i2c-i801: Handle a protocol error in byte-by-byte isr
Date: Thu, 9 Jun 2016 16:07:57 +0200
Message-ID: <20160609140748.GJ24234@mail.corp.redhat.com>
References: <1464570544-975-9-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54657 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbcFIOIC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 10:08:02 -0400
Content-Disposition: inline
In-Reply-To: <1464570544-975-9-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On May 29 2016 or thereabouts, Corey Minyard wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> If a bad number of bytes is read on a transaction, have it
> report an error and return -EPROTO for the transaction.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index b415948..70da60a 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -230,7 +230,7 @@ struct i801_priv {
>  
>  	/* isr processing */
>  	wait_queue_head_t waitq;
> -	u8 status;
> +	int status;
>  
>  	/* Command state used by isr for byte-by-byte block transactions */
>  	u8 subcmd;
> @@ -472,16 +472,18 @@ static void i801_isr_byte_done(struct i801_priv *priv)
>  		    (priv->count == 0)) {
>  			priv->len = inb_p(SMBHSTDAT0(priv));
>  			if (priv->len < 1 || priv->len > I2C_SMBUS_BLOCK_MAX) {
> -				dev_err(&priv->pci_dev->dev,
> -					"Illegal SMBus block read size %d\n",
> -					priv->len);
> -				/* FIXME: Recover */
> -				priv->len = I2C_SMBUS_BLOCK_MAX;
> -			} else {
> -				dev_dbg(&priv->pci_dev->dev,
> -					"SMBus block read size is %d\n",
> -					priv->len);
> +				/*
> +				 * Terminate the transaction here, to avoid
> +				 * getting any more interrupts that might
> +				 * hold us in an interrupt loop forever.
> +				 */
> +				outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL,
> +				       SMBHSTCNT(priv));
> +				priv->status = -EPROTO;
> +				return;
>  			}
> +			dev_dbg(&priv->pci_dev->dev,
> +				"SMBus block read size is %d\n", priv->len);
>  			priv->data[-1] = priv->len;
>  		}
>  
> @@ -541,7 +543,10 @@ static irqreturn_t i801_isr(int irq, void *dev_id)
>  	status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
>  	if (status) {
>  		outb_p(status, SMBHSTSTS(priv));
> -		priv->status |= status;
> +		if (status < 0)
> +			priv->status = status;
> +		else
> +			priv->status |= status;

This hunk conflicts with http://patchwork.ozlabs.org/patch/626051/ and
could be removed if this mentioned patch is applied first.

The rest of the patch looks OK to me.

Cheers,
Benjamin

>  		wake_up(&priv->waitq);
>  	}
>  
