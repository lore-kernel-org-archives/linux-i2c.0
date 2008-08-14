From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] PXA3xx: Add support for power i2c bus
Date: Thu, 14 Aug 2008 11:39:56 +0100
Message-ID: <20080814103956.GB4610@flint.arm.linux.org.uk>
References: <48A3F2EB.8030809@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <48A3F2EB.8030809@compulab.co.il>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Mike Rapoport <mike@compulab.co.il>
Cc: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 14, 2008 at 11:55:07AM +0300, Mike Rapoport wrote:
> diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
> index 041c048..13a786d 100644
> --- a/arch/arm/mach-pxa/generic.h
> +++ b/arch/arm/mach-pxa/generic.h
> @@ -9,9 +9,10 @@
>   * published by the Free Software Foundation.
>   */
> 
> -typedef int (*set_wake_t)(unsigned int, unsigned int);
> +typedef int (*set_wake_t) (unsigned int, unsigned int);

Undoes perfectly good formatting.

> @@ -982,10 +992,13 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "pxa_i2c-i2c.%u",
>  		 i2c->adap.nr);
> 
> -	i2c->clk = clk_get(&dev->dev, "I2CCLK");
> -	if (IS_ERR(i2c->clk)) {
> -		ret = PTR_ERR(i2c->clk);
> -		goto eclk;
> +	/* PXA3xx has power I2C clock always on */
> +	if (!(cpu_is_pxa3xx() && i2c->adap.nr == 1)) {
> +		i2c->clk = clk_get(&dev->dev, "I2CCLK");
> +		if (IS_ERR(i2c->clk)) {
> +			ret = PTR_ERR(i2c->clk);
> +			goto eclk;
> +		}

Umm, no.  It would be far better to provide a dummy clock rather than
mess drivers up with this and lots of other conditional stuff.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
