From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask for
 no smbus quick mode support.
Date: Thu, 16 Oct 2008 13:35:15 +0200
Message-ID: <20081016133515.6263c7fb@hyperion.delvare>
References: <20080821.024327.144744678.davem@davemloft.net>
	<20081015143321.7df02b35@hyperion.delvare>
	<20081015.143452.114860633.davem@davemloft.net>
	<20081016121315.2adb5de1@hyperion.delvare>
	<20081016104623.GB3432@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081016104623.GB3432-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, 16 Oct 2008 12:46:23 +0200, Wolfram Sang wrote:
> Hi Jean,
> 
> On Thu, Oct 16, 2008 at 12:13:15PM +0200, Jean Delvare wrote:
> 
> > > The pcf driver sets the class bit used by FAN and temperature sensors,
> > > so the I2C layer goes poking around all of the standard address
> > > locations each of those drivers list.
> > 
> > By setting this class flag in your driver, you ask for these probes.
> 
> What about making this more obvious? Something like this?
> 
> All the best,
> 
>    Wolfram
> 
> ===
> 
> i2c: Make clear what the class field of i2c_adapter is good for
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  include/linux/i2c.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/include/linux/i2c.h
> ===================================================================
> --- linux-2.6.orig/include/linux/i2c.h
> +++ linux-2.6/include/linux/i2c.h
> @@ -345,7 +345,7 @@ struct i2c_algorithm {
>  struct i2c_adapter {
>  	struct module *owner;
>  	unsigned int id;
> -	unsigned int class;
> +	unsigned int class;		  /* classes to allow probing for */
>  	const struct i2c_algorithm *algo; /* the algorithm to access the bus */
>  	void *algo_data;
> 

Sure, why not. Thanks for the patch, applied.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
