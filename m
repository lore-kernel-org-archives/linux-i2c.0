From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/5] i2c-i801: hwpec and check_pre cleanups
Date: Wed, 25 May 2016 13:04:45 +0200
Message-ID: <20160525130445.60dc8f26@endymion>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
	<1453223377-20608-2-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53695 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939AbcEYLEt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 25 May 2016 07:04:49 -0400
In-Reply-To: <1453223377-20608-2-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

Sorry, I accidentally sent the previous reply while I wasn't done with
the review yet.

On Tue, 19 Jan 2016 11:09:33 -0600, minyard@acm.org wrote:
> @@ -691,13 +682,15 @@ static int i801_block_transaction(struct i801_priv *priv,
>  	   doesn't mention this limitation. */
>  	if ((priv->features & FEATURE_BLOCK_BUFFER)
>  	 && command != I2C_SMBUS_I2C_BLOCK_DATA
> -	 && i801_set_block_buffer_mode(priv) == 0)
> +	 && i801_set_block_buffer_mode(priv) == 0) {
> +		if (hwpec)
> +			priv->xact_extra |= SMBHSTCNT_PEC_EN;
>  		result = i801_block_transaction_by_block(priv, data,
> -							 read_write, hwpec);
> -	else
> +							 read_write);
> +	} else
>  		result = i801_block_transaction_byte_by_byte(priv, data,
>  							     read_write,
> -							     command, hwpec);
> +							     command);
>  
> (...)
> @@ -776,11 +770,17 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (hwpec)	/* enable/disable hardware PEC */
> +	result = i801_check_pre(priv);
> +	if (result < 0)
> +		return result;
> +
> +	if (hwpec) {	/* enable/disable hardware PEC */
>  		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
> -	else
> +	} else {
>  		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
>  		       SMBAUXCTL(priv));
> +		priv->xact_extra &= ~SMBHSTCNT_PEC_EN;
> +	}

I'm confused by this asymmetry. You clear the PEC flag here, but you
set it in i801_block_transaction() above. Originally the flag was set
in i801_block_transaction_by_block() (and didn't have to be cleared, as
it was temporary.)

With your implementation, PEC may or may not be enabled if a driver
asks for a non-block transaction with PEC. If this is the first
transaction then it will not be enabled (bug already existed before
your patch.) But if the previous transaction was a block transaction
with PEC then the flag will still be present, so PEC will still be
enabled. The previous implementation was wrong but at least it was
consistently so.

This makes me believe we should rather fix the bugs first, and then
look into cleaning up this part of the code.

If you start storing transaction-dependent information in struct
i801_priv, you must make sure that nothing will leak from one
transaction to the next. I still have to review the rest of your patch
series, but I don't think it makes sense to carry the PEC flag that way
if the rest of the transaction information is still passed as function
parameters.

-- 
Jean Delvare
SUSE L3 Support
