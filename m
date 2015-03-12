From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c: davinci: Fix problems discovered on Keystone
 CPU
Date: Thu, 12 Mar 2015 08:52:39 +0100
Message-ID: <550145C7.20503@nokia.com>
References: <55003E60.3070306@nokia.com> <55008AF1.80405@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55008AF1.80405-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

On 11/03/15 19:35, ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
>> The series address the follwing problems:
>> > "i2c: davinci: Rework racy ISR" -- stop the parallel activities in the driver
>> > including concurrect registers access. Also simplifies the design and removes
>> > some bad aids.
>> > "i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()" -- the routine is
>> > over-designed and instead of "waiting" will trigger the bus recovering
>> > immediately.
>> > "i2c: davinci: Avoid sending to own address" -- works around one davinci
>> > controller issue when it unexpectedly switches to some sort of slave mode
>> > trying to send to its own address. The controller remains in this locked state
>> > until reset, so it's better to avoid this situation than to deal with transfer
>> > timeouts.
>> > 
> 
> Have you used git format-patch --cover-letter?
> Overall stats and list of patches are missing.

Will do in v2...

> Also I think It'll be better to send patches 2/3 first, as
> they have more chances to be merged. 

First patch is an important fix for blocking problem and therefore a candidate for
-stable backports. So, it should be less dependent of the less-important 2 and 3.

-- 
Best regards,
Alexander Sverdlin.
