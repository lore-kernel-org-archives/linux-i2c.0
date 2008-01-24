From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 5/6] pca-isa driver uses the new pca-algorithm
Date: Thu, 24 Jan 2008 15:01:45 +0100
Message-ID: <fna5oa$fp0$1@ger.gmane.org>
References: <20080121142010.988419876@pengutronix.de>	<20080121143658.662633756@pengutronix.de>
	<20080124120044.4052c351@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080124120044.4052c351-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Wolfram,
> 
> On Mon, 21 Jan 2008 15:20:15 +0100, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
>> This is untested, due to no hardware!
> Did you at least try to build it? I guess not, because it fails here:
> 
>   CC [M]  drivers/i2c/busses/i2c-pca-isa.o
> drivers/i2c/busses/i2c-pca-isa.c: In function `pca_isa_waitforcompletion':
> drivers/i2c/busses/i2c-pca-isa.c:84: error: `adap' undeclared (first use in this function)
> drivers/i2c/busses/i2c-pca-isa.c:84: error: (Each undeclared identifier is reported only once
> drivers/i2c/busses/i2c-pca-isa.c:84: error: for each function it appears in.)
> drivers/i2c/busses/i2c-pca-isa.c: In function `pca_isa_resetchip':
> drivers/i2c/busses/i2c-pca-isa.c:96: error: syntax error before "DRIVER"
> drivers/i2c/busses/i2c-pca-isa.c: At top level:
> drivers/i2c/busses/i2c-pca-isa.c:108: error: unknown field `wait_for_competion' specified in initializer
> drivers/i2c/busses/i2c-pca-isa.c:110: error: initializer element is not constant
> drivers/i2c/busses/i2c-pca-isa.c:110: error: (near initialization for `pca_isa_data.my_slave_addr')
> drivers/i2c/busses/i2c-pca-isa.c:111: error: initializer element is not constant
> drivers/i2c/busses/i2c-pca-isa.c:111: error: (near initialization for `pca_isa_data.i2c_clock')
> drivers/i2c/busses/i2c-pca-isa.c: In function `pca_isa_probe':
> drivers/i2c/busses/i2c-pca-isa.c:140: error: implicit declaration of function `i2c_pca_add_bus'
> make[3]: *** [drivers/i2c/busses/i2c-pca-isa.o] Error 1
> make[2]: *** [drivers/i2c/busses] Error 2
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
> 
> Please fix.
Err? Seems like a bug in my workflow. Will fix!

> No history in drivers.
Will be deleted.

>> -#include <asm/io.h>
>> -#include <asm/irq.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
> Why? Many drivers include <asm/io.h> and <asm/irq.h>, it looks OK to me.
checkpatch.pl told me so.

>>  #undef DEBUG_IO
>> -//#define DEBUG_IO
> While you're here, the line before could be discarded as well.
OK.

  >>  static struct i2c_algo_pca_data pca_isa_data = {
>> -	.get_own		= pca_isa_getown,
>> -	.get_clock		= pca_isa_getclock,
>> +	.data			= NULL,
> No need to initialize to NULL, the compiler does it for you. On a side
> note though, I fail to see how this could work, given that you changed
> the callbacks so that you pass this private data pointer to them
> instead of a pointer to struct i2c_algo_pca_data. This probably needs
> some more thinking.
The pointer is passed along, but never used with the ISA-driver. 
Everything needed is in static variables (base address, wait_queue). I 
set the pointer explicitly to NULL, so the assignment is "marked" to be 
fully intentional. Then again, a comment would also do.

Note: I was thinking about removing the static variables and creating an 
apropriate struct dynamically; but I fear this change is too big for not 
having the hardware.

>> -	if (irq > 0) {
>> +	if (irq > -1) {
> This deserves an explanation... In the light of previous discussions on
> the i2c list, I'd rather expect comparisons with NO_IRQ.
Everything inside the ISA-driver checked against -1, so I assumed this 
to be a bug. Should have explained this in detail, sorry, I forgot. 
After reading the recent thread about NO_IRQ, I also came to the 
conclusion, that I better should use this, too.

Thanks again for your review!

-- 
   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
