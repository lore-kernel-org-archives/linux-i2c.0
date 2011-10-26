From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] rtc-isl1208: Use SMBus functions if I2C isn't available
Date: Wed, 26 Oct 2011 09:40:34 +0100
Message-ID: <4EA7C782.205@cam.ac.uk>
References: <1319596228-23318-1-git-send-email-gardner.ben@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319596228-23318-1-git-send-email-gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Gardner <public-gardner.ben-Re5JQEeQqe8AvxtiuMwx3w-wOFGN7rlS/M9smdsby/KFg@public.gmane.org>
Cc: public-linux-i2c-u79uwXL29TY76Z2rM5mHXA-wOFGN7rlS/M9smdsby/KFg@public.gmane.org, public-linux-kernel-u79uwXL29TY76Z2rM5mHXA-wOFGN7rlS/M9smdsby/KFg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 10/26/11 03:30, Ben Gardner wrote:
> The rtc-isl1208 driver currently depends on raw I2C functionality.
> This patch adds a fall-back to SMBus functions so that the driver can be 
> used on a SMBus-only platforms, such as i2c-isch.
> 
Perhaps a summary of how bad things would be if smbus were all that is used?
Afterall it is emulated on i2c buses if they don't support it directly.

> Signed-off-by: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> ---
>  drivers/rtc/rtc-isl1208.c |   68 +++++++++++++++++++++++++++++++-------------
>  1 files changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index ea10736..c553c7b 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -66,20 +66,35 @@ static int
>  isl1208_i2c_read_regs(struct i2c_client *client, u8 reg, u8 buf[],
>  		      unsigned len)
>  {
> -	u8 reg_addr[1] = { reg };
> -	struct i2c_msg msgs[2] = {
> -		{client->addr, 0, sizeof(reg_addr), reg_addr}
> -		,
> -		{client->addr, I2C_M_RD, len, buf}
> -	};
>  	int ret;
>  
>  	BUG_ON(reg > ISL1208_REG_USR2);
>  	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
>  
> -	ret = i2c_transfer(client->adapter, msgs, 2);
> -	if (ret > 0)
> -		ret = 0;
It's a bit early in the morning, but at least at first glance I think
this is an i2c_smbus_i2c_read_block_data reimplementation?

> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		u8 reg_addr[1] = { reg };
> +		struct i2c_msg msgs[2] = {
> +			{client->addr, 0, sizeof(reg_addr), reg_addr}
> +			,
Odd spacing.
> +			{client->addr, I2C_M_RD, len, buf}
> +		};
> +
> +		ret = i2c_transfer(client->adapter, msgs, 2);
> +		if (ret > 0)
> +			ret = 0;
> +	} else {
> +		int idx;
> +		ret = i2c_smbus_read_byte_data(client, reg);
> +		if (ret < 0)
> +			return ret;
> +		buf[0] = ret;
> +		for (idx = 1; idx < len; idx++) {
> +			ret = i2c_smbus_read_byte(client);
> +			if (ret < 0)
> +				return ret;
> +			buf[idx] = ret;
> +		}
> +	}
>  	return ret;
>  }
>  
> @@ -88,21 +103,32 @@ static int
>  isl1208_i2c_set_regs(struct i2c_client *client, u8 reg, u8 const buf[],
>  		     unsigned len)
>  {
> -	u8 i2c_buf[ISL1208_REG_USR2 + 2];
> -	struct i2c_msg msgs[1] = {
> -		{client->addr, 0, len + 1, i2c_buf}
> -	};
> -	int ret;
> +	int ret = 0;
>  
>  	BUG_ON(reg > ISL1208_REG_USR2);
>  	BUG_ON(reg + len > ISL1208_REG_USR2 + 1);
>  
> -	i2c_buf[0] = reg;
> -	memcpy(&i2c_buf[1], &buf[0], len);
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		u8 i2c_buf[ISL1208_REG_USR2 + 2];
> +		struct i2c_msg msgs[1] = {
> +			{client->addr, 0, len + 1, i2c_buf}
> +		};
> +
> +		i2c_buf[0] = reg;
> +		memcpy(&i2c_buf[1], &buf[0], len);
>  
> -	ret = i2c_transfer(client->adapter, msgs, 1);
> -	if (ret > 0)
> -		ret = 0;
> +		ret = i2c_transfer(client->adapter, msgs, 1);
> +		if (ret > 0)
> +			ret = 0;
> +	} else {
> +		int idx;
> +		for (idx = 0; idx < len; idx++) {
> +			ret = i2c_smbus_write_byte_data(client, reg + idx,
> +							buf[idx]);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
>  	return ret;
>  }
>  
> @@ -622,7 +648,9 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	int rc = 0;
>  	struct rtc_device *rtc;
>  
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
> +	    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE |
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
>  	if (isl1208_i2c_validate_client(client) < 0)
