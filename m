From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: move OF i2c related functions into i2c core
Date: Fri, 05 Aug 2011 18:15:59 -0500
Message-ID: <4E3C79AF.80901@gmail.com>
References: <1312579468-19365-1-git-send-email-robherring2@gmail.com> <1312579468-19365-3-git-send-email-robherring2@gmail.com> <20110805225637.GB6404@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110805225637.GB6404-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Grant,

On 08/05/2011 05:56 PM, Grant Likely wrote:
> On Fri, Aug 05, 2011 at 04:24:27PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>>
>> This simplifies i2c drivers by removing calls to of_i2c_register_devices
>> and resolves a module circular dependency between i2c-core and of_i2c.
>>
>> Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> ---
>>  arch/powerpc/platforms/44x/warp.c |    1 -
>>  drivers/i2c/i2c-core.c            |   85 +++++++++++++++++++++++++++++++-
>>  drivers/of/Makefile               |    1 -
>>  drivers/of/of_i2c.c               |   97 -------------------------------------
>>  include/linux/i2c.h               |    4 ++
>>  include/linux/of_i2c.h            |   30 -----------
>>  6 files changed, 87 insertions(+), 131 deletions(-)
>>  delete mode 100644 drivers/of/of_i2c.c
>>  delete mode 100644 include/linux/of_i2c.h
>>
>> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
>> index 8f77139..9327ccf 100644
>> --- a/arch/powerpc/platforms/44x/warp.c
>> +++ b/arch/powerpc/platforms/44x/warp.c
>> @@ -16,7 +16,6 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/delay.h>
>>  #include <linux/of_gpio.h>
>> -#include <linux/of_i2c.h>
>>  #include <linux/slab.h>
>>  
>>  #include <asm/machdep.h>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 011e195..478c7f2 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -22,7 +22,10 @@
>>     SMBus 2.0 support by Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> and
>>     Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>>     Mux support by Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> and
>> -   Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org> */
>> +   Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>
>> +   OF support by Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org> and
>> +   Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> +   */
>>  
>>  #include <linux/module.h>
>>  #include <linux/kernel.h>
>> @@ -32,7 +35,6 @@
>>  #include <linux/init.h>
>>  #include <linux/idr.h>
>>  #include <linux/mutex.h>
>> -#include <linux/of_i2c.h>
>>  #include <linux/of_device.h>
>>  #include <linux/completion.h>
>>  #include <linux/hardirq.h>
>> @@ -790,6 +792,85 @@ static void i2c_scan_static_board_info(struct i2c_adapter *adapter)
>>  	up_read(&__i2c_board_lock);
>>  }
>>  
>> +#ifdef CONFIG_OF_I2C
> 
> I think this becomes simply "#ifdef CONFIG_OF" since CONFIG_I2C is implied at this point.

I was going to remove CONFIG_OF_I2C altogether, but it depends on !SPARC
so I thought it should be kept.

> 
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index a6c652e..830397b 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -468,6 +468,10 @@ static inline int i2c_adapter_id(struct i2c_adapter *adap)
>>  {
>>  	return adap->nr;
>>  }
>> +
>> +/* must call put_device() when done with returned i2c_client device */
>> +extern struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
>> +
> 
> This shouldn't be defined if !CONFIG_OF

There is no empty version today and externs don't need to be ifdef'ed in
that case.

Rob
