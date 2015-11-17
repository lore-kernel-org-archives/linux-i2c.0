From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] i2c: Revert "i2c: xiic: Do not reset controller before
 every transfer"
Date: Tue, 17 Nov 2015 08:34:30 +0100
Message-ID: <564AD886.3060108@metafoo.de>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de> <CAKfKVtGqPPP=bnWH4dPLT1=gjrvZe=0zmix58SKBT79MsR+CXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp-out-035.synserver.de ([212.40.185.35]:1210 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751151AbbKQHeo (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 17 Nov 2015 02:34:44 -0500
In-Reply-To: <CAKfKVtGqPPP=bnWH4dPLT1=gjrvZe=0zmix58SKBT79MsR+CXg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org

On 11/17/2015 06:17 AM, Shubhrajyoti Datta wrote:
> On Mon, Nov 16, 2015 at 7:12 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> Commit d701667bb331 ("i2c: xiic: Do not reset controller before every
>> transfer") removed the reinitialization of the controller before the start
>> of each transfer. Apparently this change is not safe to make and the commit
>> results in random I2C bus failures.
> 
> Which is the platform and the ip version that you  saw the issue.
> Did you see the issue with read and write as  well?

The IP version is the axi-iic v2.0 Revision 8. I've tested this on a few
platforms, custom ones and standard ones and I could reproduce it on most.
One of them was on the ZED board. The one where I couldn't reproduce it was
the ZC706. But that doesn't necessarily mean it doesn't happen there, just
that it is not triggered by the testcase.

The problem is that it is random corruption, so some I2C devices might start
to behave strangely at some point. The only good more or less reliable way
to reproduce it that I found was to run i2cdetect a couple of times and at
least one of them will produce strange behavior.

>>
>> An easy way to trigger the issue is to run i2cdetect.
>>
>> Without the patch applied:
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>          00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>          10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          30: -- -- -- -- -- -- -- -- UU UU -- UU 3c -- -- UU
>>          40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          70: -- -- -- -- -- -- -- --
>>
>> With the patch applied every other or so invocation:
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>          00:          03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
>>          10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
>>          20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
>>          30: -- -- -- -- -- -- -- -- UU UU -- UU 3c -- -- UU
>>          40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>          70: -- -- -- -- -- -- -- --
>>
> I assume that you have these many peripherals.
> on the bus am I right?

Sorry, I should have been more clear. The first one is before the patch that
introduces the issue, the second one is with the patch that introduces the
issue.

- Lars
