From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
Date: Wed, 11 Mar 2015 20:35:03 +0200
Message-ID: <55008AD7.4070905@linaro.org>
References: <55003E6B.40008@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55003E6B.40008-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Alexander,

On 03/11/2015 03:08 PM, Alexander Sverdlin wrote:
> There are several problems in the function:
> - "to_cnt" variable does nothing
> - schedule_timeout() call without setting current state does nothing
> - "allow_sleep" parameter is not really used
>
> Refactor the function so that it really tries to wait. In case of timeout try
> to recover the bus and finally initialize the controller. We cannot really
> do more than that, so it makes no sense to check BB bit after init.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-davinci.c |   53 +++++++++++++++++++++----------------
>   1 files changed, 30 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 98759ae..ca22479 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -152,6 +152,26 @@ static void davinci_i2c_clock_pulse(unsigned int scl_pin)
>   	}
>   }
>
> +/*
> + * Wait until specific bit in status register has particular value
> + * Function returns 0 if condition was met,
> + * -ETIMEDOUT in case of timeout.
> + */
> +static int i2c_davinci_wait_status_change(struct davinci_i2c_dev *dev, u16 mask,
> +                                          u16 val)

do we really need it as separate function? (even if it looks good:)

> +{
> +	unsigned long timeout = jiffies + dev->adapter.timeout;
> +
> +	while ((davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG) & mask) != val) {
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(1);

schedule_timeout_uninterruptible()

> +	}
> +
> +	return 0;
> +}
> +
>   /* This routine does i2c bus recovery as specified in the
>    * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
>    */
> @@ -269,29 +289,16 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>   /*
>    * Waiting for bus not busy
>    */
> -static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
> -					 char allow_sleep)
> +static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev)
>   {
> -	unsigned long timeout;
> -	static u16 to_cnt;
> -
> -	timeout = jiffies + dev->adapter.timeout;
> -	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
> -	       & DAVINCI_I2C_STR_BB) {
> -		if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
> -			if (time_after(jiffies, timeout)) {
> -				dev_warn(dev->dev,
> -				"timeout waiting for bus ready\n");
> -				to_cnt++;
> -				return -ETIMEDOUT;
> -			} else {
> -				to_cnt = 0;
> -				davinci_i2c_recover_bus(dev);
> -				i2c_davinci_init(dev);
> -			}
> -		}
> -		if (allow_sleep)
> -			schedule_timeout(1);
> +	if (i2c_davinci_wait_status_change(dev, DAVINCI_I2C_STR_BB, 0)) {
> +		dev_warn(dev->dev, "timeout waiting for bus ready\n");
> +		davinci_i2c_recover_bus(dev);
> +		i2c_davinci_init(dev);
> +		/*
> +		 * the bus should not be busy after init, otherwise something
> +		 * is badly broken
> +		 */

I think you should recheck BB and return error if it's still detected.

>   	}
>
>   	return 0;
> @@ -449,7 +456,7 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>
>   	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
>
> -	ret = i2c_davinci_wait_bus_not_busy(dev, 1);
> +	ret = i2c_davinci_wait_bus_not_busy(dev);
>   	if (ret < 0) {
>   		dev_warn(dev->dev, "timeout waiting for bus ready\n");
>   		return ret;
>


regards,
-grygorii

-- 
regards,
-grygorii
