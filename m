From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [v2,03/10] i2c-i801: Move hwpec handling into block transaction
Date: Thu, 9 Jun 2016 11:42:27 +0200
Message-ID: <20160609094227.GE24234@mail.corp.redhat.com>
References: <1464570544-975-4-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57098 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbcFIJmb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 05:42:31 -0400
Content-Disposition: inline
In-Reply-To: <1464570544-975-4-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On May 29 2016 or thereabouts, Corey Minyard wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Since hwpec is only used for block transactions, move it out of
> i801_access() and into i801_block_transaction().
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 47 +++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 205f9d0..222be9c 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -656,11 +656,22 @@ static int i801_set_block_buffer_mode(struct i801_priv *priv)
>  }
>  
>  /* Block transaction function */
> -static int i801_block_transaction(struct i801_priv *priv,
> +static int i801_block_transaction(struct i801_priv *priv, unsigned short flags,
>  				  union i2c_smbus_data *data, char read_write,
> -				  int command, int hwpec)
> +				  int command)
>  {
>  	int result = 0;
> +	int hwpec = (priv->features & FEATURE_SMBUS_PEC)
> +		&& (flags & I2C_CLIENT_PEC)
> +		&& command != I2C_SMBUS_QUICK
> +		&& command != I2C_SMBUS_I2C_BLOCK_DATA;
> +
> +	if (hwpec)	/* enable/disable hardware PEC */
> +		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC,
> +		       SMBAUXCTL(priv));
> +	else
> +		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
> +		       SMBAUXCTL(priv));
>  
>  	if (read_write == I2C_SMBUS_WRITE
>  	 || command == I2C_SMBUS_I2C_BLOCK_DATA) {
> @@ -685,6 +696,16 @@ static int i801_block_transaction(struct i801_priv *priv,
>  							     read_write,
>  							     command);
>  
> +	/*
> +	 * Some BIOSes don't like it when PEC is enabled at reboot or
> +	 * resume time, so we forcibly disable it after every
> +	 * transaction. Turn off E32B for the same reason.
> +	 */
> +	if (hwpec)

If I read correctly, there should not be a need for the if, but do the
outb_p() call unconditionally. In i801_access, this is guarded by
(hwpec || block), and we are in the block case anyway.

So now, with this testm you won't disable SMBAUXCTL_E32B after every
transaction, which causes problems according to the comment above.

Cheers,
Benjamin

> +		outb_p(inb_p(SMBAUXCTL(priv)) &
> +		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
> +		       SMBAUXCTL(priv));
> +
>  	return result;
>  }
>  
> @@ -693,7 +714,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>  		       unsigned short flags, char read_write, u8 command,
>  		       int size, union i2c_smbus_data *data)
>  {
> -	int hwpec;
>  	int block = 0;
>  	int ret = 0, xact = 0;
>  	int hostc = -1;
> @@ -701,10 +721,6 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>  
>  	pm_runtime_get_sync(&priv->pci_dev->dev);
>  
> -	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
> -		&& size != I2C_SMBUS_QUICK
> -		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
> -
>  	switch (size) {
>  	case I2C_SMBUS_QUICK:
>  		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
> @@ -773,25 +789,12 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>  		goto out;
>  	}
>  
> -	if (hwpec)	/* enable/disable hardware PEC */
> -		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
> -	else
> -		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC),
> -		       SMBAUXCTL(priv));
> -
>  	if (block)
> -		ret = i801_block_transaction(priv, data, read_write, size,
> -					     hwpec);
> +		ret = i801_block_transaction(priv, flags, data, read_write,
> +					     size);
>  	else
>  		ret = i801_transaction(priv, xact);
>  
> -	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
> -	   time, so we forcibly disable it after every transaction. Turn off
> -	   E32B for the same reason. */
> -	if (hwpec || block)
> -		outb_p(inb_p(SMBAUXCTL(priv)) &
> -		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
> -
>  	if (hostc >= 0)
>  		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
>  
