From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [v2,04/10] i2c-i801: Consolidate calls to i801_check_pre()
Date: Thu, 9 Jun 2016 11:44:02 +0200
Message-ID: <20160609094402.GF24234@mail.corp.redhat.com>
References: <1464570544-975-5-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36193 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbcFIJoG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 05:44:06 -0400
Content-Disposition: inline
In-Reply-To: <1464570544-975-5-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On May 29 2016 or thereabouts, Corey Minyard wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> It was always done before starting the transaction, so do it
> in common code before the transaction start.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 222be9c..8794e70 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -402,10 +402,6 @@ static int i801_transaction(struct i801_priv *priv, int xact)
>  	int result;
>  	const struct i2c_adapter *adap = &priv->adapter;
>  
> -	result = i801_check_pre(priv);
> -	if (result < 0)
> -		return result;
> -
>  	if (priv->features & FEATURE_IRQ) {
>  		outb_p(xact | SMBHSTCNT_INTREN | SMBHSTCNT_START,
>  		       SMBHSTCNT(priv));
> @@ -562,10 +558,6 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>  	int result;
>  	const struct i2c_adapter *adap = &priv->adapter;
>  
> -	result = i801_check_pre(priv);
> -	if (result < 0)
> -		return result;
> -
>  	len = data->block[0];
>  
>  	if (read_write == I2C_SMBUS_WRITE) {
> @@ -789,6 +781,10 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>  		goto out;
>  	}
>  
> +	ret = i801_check_pre(priv);
> +	if (ret < 0)
> +		goto out;
> +

The calls looks identical (it gets called before each transaction), but
given that this is a status register, I wonder if this should not be
checked once the setup has been done, and not at the very early
beginning.

Cheers,
Benjamin

>  	if (block)
>  		ret = i801_block_transaction(priv, flags, data, read_write,
>  					     size);
