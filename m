From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2 2/3] Extend the PCA9564-algorithm and adapt its
 only user (pca-isa).
Date: Tue, 12 Feb 2008 18:14:47 +0100
Message-ID: <20080212181447.1599af64@hyperion.delvare>
References: <20080206202056.364404622@pengutronix.de>
	<20080206203036.863518353@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080206203036.863518353-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, 06 Feb 2008 21:20:58 +0100, Wolfram Sang wrote:
> The separation between algorithm and adapter was unsharp at places. This was
> partly hidden by the fact, that the ISA-driver allowed just one instance and
> had all private data in static variables. This patch makes neccessary
> preparations to add a platform driver on top of the algorithm, while still
> supporting ISA. Note: Due to lack of hardware, the ISA-driver could not be
> tested except that it builds.
> 
> Concerning the core struct i2c_algo_pca_data:
> 
> - A private data field was added, all hardware dependant data may go here.
>   Similar to other algorithms, now a pointer to this data is passed to the
>   adapter's functions. In order to make as less changes as possible to the
>   ISA-driver, it leaves the private data empty and still only uses its static
>   variables.
> 
> - A "reset_chip" function pointer was added; such a functionality must come
>   from the adapter, not the algorithm.
> 
> - use a variable "i2c_clock" instead of a function pointer "get_clock",
>   allowing for write access to a default in case a wrong value was supplied.
> 
> In the algorithm-file:
> 
> - move "i2c-pca-algo.h" into "linux/i2c-algo-pca.h"
> - now using per_instance timeout values (i2c_adap->timeout)
> - error messages specify the device, not only the driver name
> - restructure initialization to easily support "i2c_add_numbered_adapter"
> - drop "retries" and "own" (i2c address) as they were unused
> 
> (The state-machine for I2C-communication was not touched.)
> 
> In the ISA-driver:
> 
> - adapt to new algorithm
> - updated tests to variable "irq" to the convention that 0 is NO_IRQ

I'm fine with everything except this. I'm not saying that the changes in
irq tests aren't correct (the original code looks weird) but this is a
functional change, unrelated with the rest of your patch. So if you
really want to change it, that must be a separate patch.

No need to resend, I've reverted these changes myself. Patch applied,
thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
