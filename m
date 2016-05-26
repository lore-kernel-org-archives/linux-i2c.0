From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH 5/5] i2c-i801: Remove redundant code and event-drive
Date: Thu, 26 May 2016 07:15:28 -0500
Message-ID: <5746E8E0.7060301@acm.org>
References: <1453223377-20608-1-git-send-email-minyard@acm.org>
 <1453223377-20608-6-git-send-email-minyard@acm.org>
 <20160525145230.24f1c881@endymion> <5745D9B5.5000704@acm.org>
 <20160526091733.53821092@endymion>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34047 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbcEZMPc (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 26 May 2016 08:15:32 -0400
Received: by mail-pa0-f68.google.com with SMTP id yl2so8837521pac.1
        for <linux-i2c@vger.kernel.org>; Thu, 26 May 2016 05:15:31 -0700 (PDT)
In-Reply-To: <20160526091733.53821092@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On 05/26/2016 02:17 AM, Jean Delvare wrote:
> Hi Corey,
>
snip
>
>>> This is unfortunate because some of the changes would still be good to
>>> have. In particular having a single call to i801_check_post() would be
>>> a nice clean-up.
>> Yes, looking over this some more, several of the issues have been
>> addressed that these patches originally targeted.
>>
>> This was originally part of a set of patches that allowed access to
>> I2C devices when the system couldn't schedule, primarily for
>> storing panic information and handling watchdogs at panic and
>> in kgdb.  For that you have to event-drive it so you can poll.
>> I've abandoned those changes, but this small set looked
>> like it has some useful stuff.
>>
>> Thanks for the review, I'll look at pulling out some of the good things
> Thank you, I'll be happy to review and test the new series, hopefully
> faster than I did for this one. Now that the i2c-i801 driver works on
> my system again, it should be much easier.

Ok, thanks.

BTW, I have a working i801 device on qemu, if that helps you.  I'm
working to get it into mainline there.  What's in qemu now is only
marginally functional.

>> (and getting rid of hwpec from i801_block_transaction_byte_by_byte
>> since it's not used there any more).
> Did it ever work? And more importantly, does the hardware support it?
> Before cleaning up the code, I'd like to make sure the driver supports
> PEC in all cases where the hardware itself supports it. I'll do some
> tests.
>

The docs are kind of unclear.  I didn't find anything that said it
didn't work, but I got that impression from some place.  I never
tested it out.

-corey
