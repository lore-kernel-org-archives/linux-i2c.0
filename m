From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Thu, 5 Nov 2015 18:24:51 +0100
Message-ID: <20151105182451.6a6eea07@endymion.delvare>
References: <1446715969-11727-1-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446715969-11727-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Corentin,

On Thu,  5 Nov 2015 10:32:48 +0100, LABBE Corentin wrote:
> The simple_strtoul function is marked as obsolete.
> This patch replace it by kstrtou8.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/i2c/busses/i2c-taos-evm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Thanks for the cleanup. I tested it on the hardware I have, no problem.
One comment below.

> 
> diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
> index 4c7fc2d..9dc6cff 100644
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
> @@ -130,7 +131,9 @@ static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  			return 0;
>  	} else {
>  		if (p[0] == 'x') {
> -			data->byte = simple_strtol(p + 1, NULL, 16);
> +			err = kstrtou8(p + 1, 16, &data->byte);
> +			if (err)
> +				return err;

While in general I am in favor of passing error values down the stack,
here I'm not sure. kstrtou8 could return -ERANGE or -EINVAL which makes
no sense as an i2c adapter fault code. According to
Documentation/i2c/fault-codes, -EPROTO or -EIO would be more
appropriate.

>  			return 0;
>  		}
>  	}


-- 
Jean Delvare
SUSE L3 Support
