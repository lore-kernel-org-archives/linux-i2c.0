From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: entering the error case of i2c-designware with a timeout at probe
Date: Tue, 21 Mar 2017 14:55:25 +0100
Message-ID: <57e0b3a8-be5a-7b73-f47b-34d02847d3b7@redhat.com>
References: <1490100731.8154.13.camel@suse.com>
 <88af9925-fea6-83af-a8ee-67feb87d59e6@suse.de>
 <657693b0-ea33-0927-752a-8e58f7c062f5@redhat.com>
 <1490103382.8154.18.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756928AbdCUNz2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 21 Mar 2017 09:55:28 -0400
In-Reply-To: <1490103382.8154.18.camel@suse.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>, Max Staudt <mstaudt@suse.de>
Cc: linux-i2c@vger.kernel.org

Hi,

On 21-03-17 14:36, Oliver Neukum wrote:
> Am Dienstag, den 21.03.2017, 14:01 +0100 schrieb Hans de Goede:
>> Hi,
>>
>> On 21-03-17 13:57, Max Staudt wrote:
>>>
>>> On 03/21/2017 01:52 PM, Oliver Neukum wrote:
>>>>
>>>> Hi Hans,
>>>>
>>>> we found on our test systems with a bit of experimentation,
>>>> that actually running into the timeout is bound to hang the whole
>>>> system within only a few seconds.
>>>> I was wondering whether the error handling needs to be changed.
>>>
>>> In other words, whether we should rather wait for lock acquisition,
>>> unconditionally. No timeout, just wait. That's what our hardware
>>> seems to need.
>>>
>>> It feels like once the lock has been requested by the Linux driver,
>>> we can't cancel that request and have to actually follow through
>>> with accepting the lock and only giving it back after that.
>>> Resetting the "request" bit to 0 as it is done now doesn't work as
>>> it leads to the hung system sometime soon after that.
>>
>> Hmm, interesting theory. I would say give it a test and if it
>> helps then maybe increase the timeouts to say 10 seconds or
>> such, so that e.g. on poweroff we at least report an error
>> rather then just sitting there ?
>
> I did some testing. Unconditionally taking the error path without waiting
> for the semaphore crashes or freezes the machine in about 3/4 of all
> tests.
> As I said, with a timeout of 500ms, this issue is not seen.

Ah ok, so that patch is enough to fix this ? Then as I already
said I'm fine with that patch, needing long timeouts unfortunately
seems normal when dealing with embedded micro-controllers, I've
seen the same with e.g. ACPI embedded-controllers.

> Do you have reliable information that the error handling works
> on BayTrail?

No, Bay Trail actually is known to not always be stable with Linux.

Regards,

Hans
