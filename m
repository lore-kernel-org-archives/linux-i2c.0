From: fetzerch <fetzer.ch@gmail.com>
Subject: Re: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Sun, 1 Nov 2015 17:38:03 +0100
Message-ID: <56363FEB.3080209@googlemail.com>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
 <20151020151935.GH5379@katana> <20151022082755.GK1526@lahna.fi.intel.com>
 <20151022110325.GA1572@katana> <20151022114335.GL1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37380 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbKAQiH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:38:07 -0500
Received: by wmff134 with SMTP id f134so43297221wmf.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:38:05 -0800 (PST)
In-Reply-To: <20151022114335.GL1526@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, tbrandonau@gmail.com, eddi@depieri.net, galandilias@gmail.com

Hi Mika,

On 22.10.2015 13:43, Mika Westerberg wrote:
> On Thu, Oct 22, 2015 at 01:03:25PM +0200, Wolfram Sang wrote:
>>>>> Please review and let me know required changes in order to get this upstream
>>>>> finally.
>>>>>
>>>>> Eddi, Thomas, it would be great if you could verify the changes on your
>>>>> machines.
>>>> Yes, additional tests are always good for a patch series
>>>>
>>>> Asking the Intel guys for help, I have not much expierence with x86
>>>> platforms... Mika, Jarkko, Andy any chance to help?
>>> Unfortunately I don't have hardware this old to test on :-/
>> And visual review? (That's what I need to do mostly, too)
> Sure.
>
> I don't have a copy of these patches but I went ahead and looked them up
> from archives. Christian can you Cc me on next iteration?
>
> Mostly they look good to me. Few comments though.
>
> Patch 2/4: should we remove adapter in reverse order?
>
> Patch 3/4: some stylistic issues, like:
> 	- ERROR label should not be in capital letters actually it is
> 	  not needed at all if you do unlock and return -EBUSY if
> 	  request_region() fails.
> 	- Block comment style
>
> In addition I'm not sure if requesting io region for each transfer is
> good idea. Can't we just request it once for this driver and handle the
> necessary serialization using the mutex?
Thanks for the review. I've just sent patchset v2 where I tried to 
incorporate the requested changes.
I'm not sure though what you mean with 'block comment style'.
I've tried to apply the same style that is used throughout the file.

Thanks,
Christian
