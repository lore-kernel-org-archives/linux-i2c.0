From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Fri, 10 Jun 2016 11:03:46 +0100
Message-ID: <575A9082.9060804@bingham.xyz>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <20160609191513.GB23522@katana>
 <adcdbb75-41ae-774e-21cb-c039e2f0686f@osg.samsung.com>
 <20160609200405.GE23522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34139 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbcFJKDu (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Jun 2016 06:03:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id n184so16704080wmn.1
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jun 2016 03:03:49 -0700 (PDT)
In-Reply-To: <20160609200405.GE23522@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

Hi Wolfram,

On 09/06/16 21:04, Wolfram Sang wrote:
> On Thu, Jun 09, 2016 at 03:45:52PM -0400, Javier Martinez Canillas wrote:
>> Hello Wolfram,
>>
>> On 06/09/2016 03:15 PM, Wolfram Sang wrote:
>>> Hi Kieran,
>>>
>>>> * Device Tree
>>>>   I tested that the device would still register by adding a node in the device
>>>>   tree for the board, and testing with a built-in module. 
>>>>
>>>>  - This worked fine.
>>>>
>>>> * Module Autoloading
>>>>   With the device tree node in the board dts file, it wouldn't automatically
>>>>   load from the external module. This was due to the rtc-ds1307 module not
>>>>   exporting an of_match table, and not yet having Javier's "report OF style
>>>>   modalias when probing using DT" [0]  patch applied
> 
> Let's call this a)
> 
>>>
>>> What I didn't get here: did your version of the RTC driver use probe()
>>> or probe_new() without i2c_device_id table or did you try both? I assume
>>> module autoloading only fails with probe_new(), otherwise we would be in
>>> serious trouble. But I'd wonder then that userspace instantiation works.
>>>
>>
>> I can't answer for Kieran but you trimmed this last sentence from him:
>>
>>>  - With the module updated, and Javiers patch applied, the module autoloads

> Let's call this b)
> 
>>>
>>
>> So my understanding is that by updated he meant a patched rtc-ds1307 driver
>> using a .probe_new, whose i2c_device_id table was removed and of_device_id
>> table added (that's not present in the mainline driver).
>>
>> And that's why he needed my RFC patch to report a MODALIAS=of:N*T*Cfoo,bar
>> and match what's exported to the module using the of_device_id table.
>>
>> Because drivers that only use .probe and have an i2c_device_id table will
>> continue to match and report MODALIAS=i2c:foo as before after this series.

Yes, Javier's interpretation is correct here.

> Yes, this is my understanding and expectation, too. However, he wrote
> that module loading fails on a) where he never wrote anything about an
> updated module before. That comes only later with b). So what I would
> have expected:
> 
> 1) update the module (which is "b)" above)
> 2) autoloading fails (which is "a)" above)
> 3) applying your patch
> 4) everything works
> 
> which implies
> 
> 0) nothing done, everything works
> 
> But I don't see this in the text, so I better ask. This also raises the
> question open how userspace instantiation was tested. With or without
> updating (ideally both).

Well it's a month later, and I can't remember - so I've retested.

Kernel built with this patchset - and *without* Javiers patch for 0)
position test.

RTC_DS1307 driver *unmodified*

root@arm:~# uname -a
Linux arm 4.7.0-rc2-00027-g72baec98c9f0 #27 SMP Fri Jun 10 10:42:09 BST
2016 armv7l GNU/Linux

root@arm:~# lsmod
Module                  Size  Used by    Not tainted
omap_rng                3927  0
rng_core                6410  1 omap_rng
rtc_ds1307             12121  0

root@arm:~# cat /sys/class/rtc/rtc0/device/modalias
i2c:ds1307

root@arm:~# cat /sys/class/rtc/rtc0/date
2016-06-10


* Module autoload successful,
* i2c read successful.


Code tested at
repository https://github.com/kbingham/linux.git
tag i2c-dt/v4.7-rc2-relax-conversion-zero-test

Is this what you were looking for?


> Thanks,
> 
>    Wolfram
> 

-- 
Regards

Kieran Bingham
