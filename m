From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: entering the error case of i2c-designware with a timeout at probe
Date: Tue, 21 Mar 2017 16:40:43 +0100
Message-ID: <92af7d94-9dd2-8efe-48ca-359db973ff11@redhat.com>
References: <1490100731.8154.13.camel@suse.com>
 <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
 <657693b0-ea33-0927-752a-8e58f7c062f5@redhat.com>
 <1490103382.8154.18.camel@suse.com>
 <57e0b3a8-be5a-7b73-f47b-34d02847d3b7@redhat.com>
 <1490105111.8154.22.camel@suse.com>
 <a94f4a5c-dd31-5654-8ca6-c2cc2b22d79a@redhat.com>
 <1490110644.8154.26.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932511AbdCUPk5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 11:40:57 -0400
In-Reply-To: <1490110644.8154.26.camel@suse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, Max Staudt <mstaudt@suse.de>
Cc: linux-i2c@vger.kernel.org

Hi,

On 21-03-17 16:37, Oliver Neukum wrote:
> Am Dienstag, den 21.03.2017, 15:48 +0100 schrieb Hans de Goede:
>> Hi,
>>
>> On 21-03-17 15:05, Oliver Neukum wrote:
>
> Hi,
>
>>> I am quite uncomfortable with code in the kernel that will crash
>>> the machine if it ever runs. Yet I am also uncomfortable with code
>>> that would run forever.
>>
>> That is exactly how I feel, I did not realize (yet) that taking
>> the error path would always cause a freeze later, I've been assuming
>> that the timeout was caused by the bus already being stuck, not
>> that the timeout would cause the bus to get stuck because a
>> semaphore request must be followed through on.
>
> Those options are not mutually exclusive.
>
>> If your theory is right we may well want to bump up the timeout
>> to say 2 or 3 seconds.
>
> We never saw a failure with 500ms. That is pretty solid.
> Yet a true error would likely have catastrophic results.
> It seems to me that the problem is not when to proceed
> to error handling, but how the error is handled.
> Do you have any documentation on that?

Nope I have no documentation at all, just some experience
from poking at the hw.

[hans@shalem linux]$ scripts/get_maintainer.pl -f drivers/i2c/busses/i2c-designware-baytrail.c
Jarkko Nikula <jarkko.nikula@linux.intel.com> (maintainer:SYNOPSYS DESIGNWARE I2C DRIVER)
Andy Shevchenko <andriy.shevchenko@linux.intel.com> (reviewer:SYNOPSYS DESIGNWARE I2C DRIVER)
Mika Westerberg <mika.westerberg@linux.intel.com> (reviewer:SYNOPSYS DESIGNWARE I2C DRIVER)
Wolfram Sang <wsa@the-dreams.de> (maintainer:I2C SUBSYSTEM)
linux-i2c@vger.kernel.org (open list:SYNOPSYS DESIGNWARE I2C DRIVER)
linux-kernel@vger.kernel.org (open list)

There are 3 persons in there from Intel, you may want to
contact them about this.

> Should we forcibly set the semaphore to the state that signifies
> a successful take over?

Regards,

Hans
