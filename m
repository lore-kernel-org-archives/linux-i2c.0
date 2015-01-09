From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 02/11] i2c: add quirk checks to core
Date: Fri, 09 Jan 2015 22:35:27 +0300
Message-ID: <54B02D7F.7040501@cogentembedded.com>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de> <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420824103-24169-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 01/09/2015 08:21 PM, Wolfram Sang wrote:

> Let the core do the checks if HW quirks prevent a transfer. Saves code
> from drivers and adds consistency.

> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>   drivers/i2c/i2c-core.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 39d25a8cb1ad..7b10a19abf5b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -2063,6 +2063,56 @@ module_exit(i2c_exit);
>    * ----------------------------------------------------
>    */
>
> +/* Check if val is exceeding the quirk IFF quirk is non 0 */
> +#define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
> +
> +static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
> +{
> +	dev_err(&adap->dev, "quirk: %s (addr 0x%04x, size %u)\n", err_msg, msg->addr, msg->len);
> +	return -EOPNOTSUPP;
> +}

    Always returning the same value doesn't make much sense. Are you trying to 
save space on the call sites?

[...]
> @@ -2080,6 +2130,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>   	unsigned long orig_jiffies;
>   	int ret, try;
>
> +	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))

    So, you only check for non-zero result of this function? Perhaps it makes 
sense to return true/false instead?

> +		return -EOPNOTSUPP;
> +

WBR, Sergei
