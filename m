From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] I2C driver for IMX
Date: Fri, 14 Mar 2008 09:26:28 +0200
Message-ID: <frd9ei$rqj$1@ger.gmane.org>
References: <frbjjv$ndk$1@ger.gmane.org> <20080313210546.GA4483@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080313210546.GA4483-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> On Thu, Mar 13, 2008 at 06:07:45PM +0200, Darius wrote:
> 
> Hello,
> 
> (I know I am myself quite new here. I don't want to boast, just trying
> to be a little bit helpful.)
> 
> I found some things concerning the formal side:
> 
>> + * History: 2002/2/07 use msgs[]
> I have been told here that histories are not wanted as they are achieved
> through git.

ok, I'll remove history.

> 
>> +static struct platform_driver i2c_imx_driver = {
>> +	.probe		= i2c_imx_probe,
>> +	.remove		= i2c_imx_remove,
>> +	.driver		= {
>> +		.name	= DRIVER_NAME,
>> +        .owner	= THIS_MODULE,
> Indentation seems wrong here and in some other places...

stupid thing. It seems it's caused by Code::Blocks editor. I will 
correct text with simple text editor.

> 
>> +struct imx_i2c_struct {
>> +    struct i2c_adapter  adapter;
>> +	struct resource		*res;
>> +	void   __iomem		*base;
> ...like here and so on.
> 
>> +    #ifdef CONFIG_I2C_DEBUG_BUS
>> +        printk("I2C: <i2c_imx_bus_busy>\n");
>> +    #endif
> Maybe you can define a debug-printing-macro that only prints when
> DEBUG_BUS is set and is simply empty when it is unset? This should make
> the code more readable, I think (or use pr_debug).
> 
>> +	// chech or i2c bus is not busy
> CodingStyle suggests not using //.

this is from old driver code... I'll change it to /* */

> 
> All the best,
> 
>    Wolfram
> 

thanks for comments. What I should do with corrected patch? Place there 
again?


BR,
Darius


> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> i2c mailing list
> i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
