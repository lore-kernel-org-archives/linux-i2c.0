From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: don't autograb i2c-pca-isa
Date: Sat, 9 Aug 2008 15:28:45 +0200
Message-ID: <20080809152845.45a9722c@hyperion.delvare>
References: <489C8015.8070804@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <489C8015.8070804-cENuUygGYd//D1n+0JDH9g@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Rene Herman <rene.herman-cENuUygGYd//D1n+0JDH9g@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Rene,

Please Cc the i2c list for i2c patches (added.)

On Fri, 08 Aug 2008 19:19:17 +0200, Rene Herman wrote:
> Grabbing ISA bus resources without anything or anyone telling us we
> should can break boot on randconfig/allyesconfig builds by keeping
> resources that are in fact owned by different hardware busy and does
> as reported by Ingo Molnar.

I don't think it makes much sense to boot randomconfig kernels. The
i2c-pca-isa driver is for rare hardware, most people will not use it
and certainly won't build it into the kernel. So I don't think there
really is a problem in practice here. That being said...

> Generally it's also dangerous to just poke at random I/O ports and
> especially those in the range where other old easily confused ISA
> hardware might live.
> 
> For this specialized I2C bus driver, insist that the user specifies
> the resources before grabbing them.

I agree that such legacy drivers should not assume default I/O port and
IRQ, that's dangerous.

> 
> The^WA user of this driver is a one time
> 
> echo "options i2c-pca-isa base=0x330 irq=10" >> /etc/modprobe.conf
> 
> away from the old behaviour.

I am curious how many users of this driver are left. Maybe it's time to
get rid of it.

> Signed-off-by: Rene Herman <rene.herman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pca-isa.c |   20 +++++++++++++++++---
>  1 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
> index a119784..2579169 100644
> --- a/drivers/i2c/busses/i2c-pca-isa.c
> +++ b/drivers/i2c/busses/i2c-pca-isa.c
> @@ -36,8 +36,8 @@
>  #define DRIVER "i2c-pca-isa"
>  #define IO_SIZE 4
>  
> -static unsigned long base   = 0x330;
> -static int irq 	  = 10;
> +static unsigned long base;
> +static int irq = -1;
>  
>  /* Data sheet recommends 59kHz for 100kHz operation due to variation
>   * in the actual clock rate */
> @@ -107,6 +107,19 @@ static struct i2c_adapter pca_isa_ops = {
>  	.timeout	= 100,
>  };
>  
> +static int __devinit pca_isa_match(struct device *dev, unsigned int id)
> +{
> +	int match = base != 0;
> +
> +	if (match) {
> +		if (irq == -1)
> +			dev_warn(dev, "using poling mode (specify irq)\n");

Spelling: polling.

> +	} else
> +		dev_err(dev, "please specify base\n");
> +
> +	return match;
> +}
> +
>  static int __devinit pca_isa_probe(struct device *dev, unsigned int id)
>  {
>  	init_waitqueue_head(&pca_wait);
> @@ -153,7 +166,7 @@ static int __devexit pca_isa_remove(struct device *dev, unsigned int id)
>  {
>  	i2c_del_adapter(&pca_isa_ops);
>  
> -	if (irq > 0) {
> +	if (irq > -1) {
>  		disable_irq(irq);
>  		free_irq(irq, &pca_isa_ops);
>  	}
> @@ -163,6 +176,7 @@ static int __devexit pca_isa_remove(struct device *dev, unsigned int id)
>  }
>  
>  static struct isa_driver pca_isa_driver = {
> +	.match		= pca_isa_match,
>  	.probe		= pca_isa_probe,
>  	.remove		= __devexit_p(pca_isa_remove),
>  	.driver = {

Other than that, this looks OK. I'll queue this for 2.6.28.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
