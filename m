From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c-designware: increase timeout of semaphore transfer
Date: Fri, 17 Mar 2017 08:35:45 +0100
Message-ID: <df37d77a-c0a2-9c13-f70f-140fcfbb72e7@redhat.com>
References: <20170316162455.22876-1-oneukum@suse.com>
 <1489682129.19767.25.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdCQHft (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 17 Mar 2017 03:35:49 -0400
In-Reply-To: <1489682129.19767.25.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Oliver Neukum <oneukum@suse.com>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi,

On 16-03-17 17:35, Andy Shevchenko wrote:
> On Thu, 2017-03-16 at 17:24 +0100, Oliver Neukum wrote:
>> Our testing shows the semaphore failing to be transferred on
>> CherryTrail
>> in about 0.5% of all cases. The existing timeout needs to be
>> lengthened
>> to accomodate the worst cases.
>
> I think it's just a semi-hiding of real issue.

I would not know what real issue, I've seen the timeout being
hit sometimes too, it seems that sometimes the punit just is
busy with other stuff for a while before acking the semaphore
request, so I think this patch is fine:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Oliver, can you rebase this on top of:


https://cgit.freedesktop.org/drm-intel/commit/?h=topic/designware-baytrail

Which is in -next now, please ? I'm sorta surprised you didn't
use this is a base since your commit msg mentions cherrytrail
and with that series the semaphore code is broken on
cherrytrail.

Regards,

Hans



>
> Hans?
>
>>
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
>> ---
>>  drivers/i2c/busses/i2c-designware-baytrail.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
>> b/drivers/i2c/busses/i2c-designware-baytrail.c
>> index 1590ad0..2d238e3 100644
>> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
>> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
>> @@ -21,7 +21,7 @@
>>
>>  #include "i2c-designware-core.h"
>>
>> -#define SEMAPHORE_TIMEOUT	100
>> +#define SEMAPHORE_TIMEOUT	500
>>  #define PUNIT_SEMAPHORE		0x7
>>  #define PUNIT_SEMAPHORE_BIT	BIT(0)
>>  #define PUNIT_SEMAPHORE_ACQUIRE	BIT(1)
>
