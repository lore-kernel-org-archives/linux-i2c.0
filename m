From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Tue, 21 Feb 2017 16:37:23 +0100
Message-ID: <9a264b18-a192-8640-846c-d471712e9236@i2se.com>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
 <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
 <48907a31-eaa6-27e2-633f-d36de521e868@tronnes.org>
 <1983281189.110224.1487619653742@email.1und1.de>
 <5b14ed6d-4db8-abf7-ceba-ef46534b6023@tronnes.org>
 <1487689632.14564.1.camel@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:63139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdBUPjE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Feb 2017 10:39:04 -0500
In-Reply-To: <1487689632.14564.1.camel@crowfest.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michael Zoran <mzoran@crowfest.net>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>, Peter Robinson <pbrobinson@gmail.com>, Eric Anholt <eric@anholt.net>
Cc: Will Deacon <will.deacon@arm.com>, Frank Rowand <frowand.list@gmail.com>, Martin Sperl <kernel@martin.sperl.org>, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>


Am 21.02.2017 um 16:07 schrieb Michael Zoran:
> On Mon, 2017-02-20 at 22:22 +0100, Noralf Trønnes wrote:
>> Den 20.02.2017 20.40, skrev Stefan Wahren:
>>> Hi,
>>>
>>>> Noralf Trønnes <noralf@tronnes.org> hat am 18. Februar 2017 um
>>>> 19:34 geschrieben:
>>>>
>>>>
>>>>
>>>> Den 16.02.2017 22.20, skrev Stefan Wahren:
>>>>> Since commit e2474541032d ("bcm2835: Fix hang for writing
>>>>> messages
>>>>> larger than 16 bytes") the interrupt handler is prone to a
>>>>> possible
>>>>> NULL pointer dereference. This could happen if an interrupt
>>>>> fires
>>>>> before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly
>>>>> occurs
>>>>> on the RPi 3. Even this is an unexpected behavior the driver
>>>>> must
>>>>> handle that with an error instead of a crash.
>>>>>
>>>>> CC: Noralf Trønnes <noralf@tronnes.org>
>>>>> CC: Martin Sperl <kernel@martin.sperl.org>
>>>>> Reported-by: Peter Robinson <pbrobinson@gmail.com>
>>>>> Fixes: e2474541032d ("bcm2835: Fix hang for writing messages
>>>>> larger than 16 bytes")
>>>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>> ---
>>>>>     drivers/i2c/busses/i2c-bcm2835.c |    4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-bcm2835.c
>>>>> b/drivers/i2c/busses/i2c-bcm2835.c
>>>>> index c3436f6..10e39c8 100644
>>>>> --- a/drivers/i2c/busses/i2c-bcm2835.c
>>>>> +++ b/drivers/i2c/busses/i2c-bcm2835.c
>>>>> @@ -195,7 +195,9 @@ static irqreturn_t bcm2835_i2c_isr(int
>>>>> this_irq, void *data)
>>>>>     	}
>>>>>     
>>>>>     	if (val & BCM2835_I2C_S_DONE) {
>>>>> -		if (i2c_dev->curr_msg->flags & I2C_M_RD) {
>>>>> +		if (!i2c_dev->curr_msg) {
>>>>> +			dev_err(i2c_dev->dev, "Got unexpected
>>>>> interrupt (from firmware?)\n");
>>>>> +		} else if (i2c_dev->curr_msg->flags &
>>>>> I2C_M_RD) {
>>>>>     			bcm2835_drain_rxfifo(i2c_dev);
>>>>>     			val = bcm2835_i2c_readl(i2c_dev,
>>>>> BCM2835_I2C_S);
>>>>>     		}
>>>> Thanks,
>>>>
>>>> Acked-by: Noralf Trønnes <noralf@tronnes.org>
>>>>
>>> thanks, but i would be more happier to receive feedback for patches
>>> 2 and 3.
>> I have only worked on dts files downstream and never done any arm64
>> stuff, so I'm not up to speed on this.
>>
>> Noralf.
>>
> Just a note, the original downstream driver returns IRQ_NONE in this
> case.  Does that make any difference?

Yes, i decided to handle the IRQ in order to avoid a possible interrupt 
storm. Please look at the github discussion [1] for more details.

>
> Also, the the original driver has the check at the start of the IRQ and
> it doesn't log an error message.
>
> I'm wondering if logging at err level is the best since it might make
> people think a serious error has happened.

It is a serious error and should be fixed by patch 2, 3 and a possible 
patch 4 later to disable i2c0.
But before i disable i2c0 we need the test results of patch 2 and 3. The 
reason why i don't disable i2c at first is that Gerd [2] reported that 
disabling the PWM fixed the i2c timeout issue, which doesn't fit to 
Martins theory.

[1] - https://github.com/anholt/linux/issues/89
[2] - 
http://lists.infradead.org/pipermail/linux-rpi-kernel/2016-June/003969.html
