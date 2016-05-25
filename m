From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 4/5] i2c-i801: clean up block transaction
Date: Wed, 25 May 2016 14:31:52 +0200
Message-ID: <20160525143152.4842305c@endymion>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
	<1453223377-20608-5-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42583 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbcEYMb4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 25 May 2016 08:31:56 -0400
In-Reply-To: <1453223377-20608-5-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On Tue, 19 Jan 2016 11:09:36 -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The block transaction code looked a little messy, pull out the
> code to copy to/from the buffer into separate functions to make
> it a little neater.

A matter of taste I suppose. I don't see anything messy in the code as
it exists. A 32-line function doing a single thing is just fine with me.

> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 54 +++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 7567a96..840656c 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -425,37 +425,51 @@ static int i801_transaction(struct i801_priv *priv, int xact)
>  	return i801_check_post(priv, status);
>  }
>  
> +static void i801_write_block(struct i801_priv *priv, union i2c_smbus_data *data)
> +{
> +	int i, len;
> +
> +	len = data->block[0];
> +	outb_p(len, SMBHSTDAT0(priv));
> +	for (i = 0; i < len; i++)
> +		outb_p(data->block[i+1], SMBBLKDAT(priv));
> +}
> +
> +static int i801_read_block(struct i801_priv *priv, union i2c_smbus_data *data)
> +{
> +	int i, len;
> +
> +	len = inb_p(SMBHSTDAT0(priv));
> +	if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
> +		return -EPROTO;
> +
> +	data->block[0] = len;
> +	for (i = 0; i < len; i++)
> +		data->block[i + 1] = inb_p(SMBBLKDAT(priv));
> +
> +	return 0;
> +}
> +
>  static int i801_block_transaction_by_block(struct i801_priv *priv,
>  					   union i2c_smbus_data *data,
>  					   char read_write)
>  {
> -	int i, len;
> -	int status;
> +	int result;
>  
>  	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
>  
>  	/* Use 32-byte buffer to process this transaction */
> -	if (read_write == I2C_SMBUS_WRITE) {
> -		len = data->block[0];
> -		outb_p(len, SMBHSTDAT0(priv));
> -		for (i = 0; i < len; i++)
> -			outb_p(data->block[i+1], SMBBLKDAT(priv));
> -	}
> +	if (read_write == I2C_SMBUS_WRITE)
> +		i801_write_block(priv, data);
>  
> -	status = i801_transaction(priv, I801_BLOCK_DATA);
> -	if (status)
> -		return status;
> +	result = i801_transaction(priv, I801_BLOCK_DATA);
> +	if (result)
> +		return result;
>  
> -	if (read_write == I2C_SMBUS_READ) {
> -		len = inb_p(SMBHSTDAT0(priv));
> -		if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
> -			return -EPROTO;
> +	if (read_write == I2C_SMBUS_READ)
> +		result = i801_read_block(priv, data);
>  
> -		data->block[0] = len;
> -		for (i = 0; i < len; i++)
> -			data->block[i + 1] = inb_p(SMBBLKDAT(priv));
> -	}
> -	return 0;
> +	return result;
>  }
>  
>  static void i801_isr_byte_done(struct i801_priv *priv)


-- 
Jean Delvare
SUSE L3 Support
