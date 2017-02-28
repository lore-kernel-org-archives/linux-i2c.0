From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Tue, 28 Feb 2017 13:42:42 +0100
Message-ID: <77c2af87-6f0e-4de0-18e9-0aa798f282d0@i2se.com>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
 <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
 <20170220182214.izi46a7lbzck7q4r@ninjato>
 <23773cd4-a9a4-5323-4cc2-71d1d617b232@i2se.com>
 <20170221201403.GA1481@katana> <20170222072058.GA9650@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbdB1MoT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Feb 2017 07:44:19 -0500
In-Reply-To: <20170222072058.GA9650@kroah.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Eric Anholt <eric@anholt.net>, Peter Robinson <pbrobinson@gmail.com>, Martin Sperl <kernel@martin.sperl.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org

Hi Greg,

Am 22.02.2017 um 08:20 schrieb Greg Kroah-Hartman:
> On Tue, Feb 21, 2017 at 09:14:03PM +0100, Wolfram Sang wrote:
>>>> On Thu, Feb 16, 2017 at 09:20:45PM +0000, Stefan Wahren wrote:
>>>>> Since commit e2474541032d ("bcm2835: Fix hang for writing messages
>>>>> larger than 16 bytes") the interrupt handler is prone to a possible
>>>>> NULL pointer dereference. This could happen if an interrupt fires
>>>>> before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
>>>>> on the RPi 3. Even this is an unexpected behavior the driver must
>>>>> handle that with an error instead of a crash.
>>>>>
>>>>> CC: Noralf Trønnes <noralf@tronnes.org>
>>>>> CC: Martin Sperl <kernel@martin.sperl.org>
>>>>> Reported-by: Peter Robinson <pbrobinson@gmail.com>
>>>>> Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than 16 bytes")
>>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>> Applied to for-next, thanks (will be in 4.11)!
>>>>
>>> since this patch is too late for 4.10, should i resent with CC to stable in
>>> order to get it into the next 4.10 release?
>> It has the Fixes: tag, that will do.
> But it moves it much lower on my "this needs to get into stable now!"
> priority list.  I'll try to remember this one when it goes by...
>
> thanks,
>
> greg k-h

should i resend, since i didn't send you the initial patch?
