From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 1/1] i2c: taos-evm: replace simple_strtoul by
 kstrtou8
Date: Wed, 18 Nov 2015 10:29:54 +0100
Message-ID: <20151118102954.5c3b0121@endymion.delvare>
References: <1447833653-28387-1-git-send-email-clabbe.montjoie@gmail.com>
	<1447833653-28387-2-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447833653-28387-2-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Corentin,

On Wed, 18 Nov 2015 09:00:53 +0100, LABBE Corentin wrote:
> The simple_strtoul function is marked as obsolete.
> This patch replace it by kstrtou8.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/i2c/busses/i2c-taos-evm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
> index 4c7fc2d..552f127 100644
> --- a/drivers/i2c/busses/i2c-taos-evm.c
> +++ b/drivers/i2c/busses/i2c-taos-evm.c
> @@ -70,6 +70,7 @@ static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  	struct serio *serio = adapter->algo_data;
>  	struct taos_data *taos = serio_get_drvdata(serio);
>  	char *p;
> +	int err;
>  
>  	/* Encode our transaction. "@" is for the device address, "$" for the
>  	   SMBus command and "#" for the data. */
> @@ -130,7 +131,14 @@ static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  			return 0;
>  	} else {
>  		if (p[0] == 'x') {
> -			data->byte = simple_strtol(p + 1, NULL, 16);
> +			/*
> +			 * voluntary dropping error code of kstrtou8 since all

"Voluntarily" or "Willingly" would be more correct.

> +			 * error code that it could return are invalid according
> +			 * to Documentation/i2c/fault-codes
> +			 */
> +			err = kstrtou8(p + 1, 16, &data->byte);
> +			if (err)
> +				return -EPROTO;
>  			return 0;
>  		}
>  	}

Thanks for the patch. Note that you don't strictly need the "err"
variable as you never use its value.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
