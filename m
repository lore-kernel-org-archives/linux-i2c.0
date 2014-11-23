From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] Add support for SCCB devices into PXA27x I2C controller
Date: Sun, 23 Nov 2014 19:23:02 +0300
Message-ID: <547209E6.9010905@cogentembedded.com>
References: <54711397.9060601@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54711397.9060601-qphu/3gb4gc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 11/23/2014 1:52 AM, Petr Cvek wrote:

> Add support for SCCB devices into PXA27x I2C controller.

> Fix generated START but no STOP for message without I2C_M_NOSTART flag. Add
> support for I2C_M_IGNORE_NAK flag.

> Signed-off-by: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-pxa.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)

> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..adad044 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -885,7 +885,14 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32
> isr)
>           return; /* ignore */
>       }
>
> -    if (isr & ISR_BED) {
> +    /*

    Your patch has tabs replaces by spaces; probably your email agent's work. :-)

> +     * Ignore NAK when flag I2C_M_IGNORE_NAK is present,
> +     * this enables use of SCCB devices
> +     */
> +    if ((isr & ISR_BED) &&
> +        (!((i2c->msg->flags & I2C_M_IGNORE_NAK) &&
> +            (isr & ISR_ACKNAK)))) {
> +

   This empty line is not needed.

[...]

WBR, Sergei
