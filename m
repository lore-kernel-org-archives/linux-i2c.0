From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Tue, 21 Feb 2017 12:54:06 +0100
Message-ID: <74F47AB1-C275-45D7-B4C3-0861C1FDAD21@martin.sperl.org>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com> <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com> <48907a31-eaa6-27e2-633f-d36de521e868@tronnes.org> <1983281189.110224.1487619653742@email.1und1.de> <5b14ed6d-4db8-abf7-ceba-ef46534b6023@tronnes.org> <31b96f29-e369-546a-6270-266daea71062@i2se.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <31b96f29-e369-546a-6270-266daea71062-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


> On 21.02.2017, at 09:58, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> 
> Am 20.02.2017 um 22:22 schrieb Noralf Trønnes:
>> 
>> Den 20.02.2017 20.40, skrev Stefan Wahren:
>>> Hi,
>>> 
>>>> Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org> hat am 18. Februar 2017 um 19:34 geschrieben:
>>>> 
>>>> 
>>>> 
>>>> Den 16.02.2017 22.20, skrev Stefan Wahren:
>>>>> Since commit e2474541032d ("bcm2835: Fix hang for writing messages
>>>>> larger than 16 bytes") the interrupt handler is prone to a possible
>>>>> NULL pointer dereference. This could happen if an interrupt fires
>>>>> before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
>>>>> on the RPi 3. Even this is an unexpected behavior the driver must
>>>>> handle that with an error instead of a crash.
>>>>> 
>>>>> CC: Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
>>>>> CC: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>>>> Reported-by: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>> Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than 16 bytes")
>>>>> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>>>>> ---
>>>>>   drivers/i2c/busses/i2c-bcm2835.c |    4 +++-
>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
>>>>> index c3436f6..10e39c8 100644
>>>>> --- a/drivers/i2c/busses/i2c-bcm2835.c
>>>>> +++ b/drivers/i2c/busses/i2c-bcm2835.c
>>>>> @@ -195,7 +195,9 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
>>>>>       }
>>>>>          if (val & BCM2835_I2C_S_DONE) {
>>>>> -        if (i2c_dev->curr_msg->flags & I2C_M_RD) {
>>>>> +        if (!i2c_dev->curr_msg) {
>>>>> +            dev_err(i2c_dev->dev, "Got unexpected interrupt (from firmware?)\n");
>>>>> +        } else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
>>>>>               bcm2835_drain_rxfifo(i2c_dev);
>>>>>               val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
>>>>>           }
>>>> Thanks,
>>>> 
>>>> Acked-by: Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
>>>> 
>>> thanks, but i would be more happier to receive feedback for patches 2 and 3.
>> 
>> I have only worked on dts files downstream and never done any arm64
>> stuff, so I'm not up to speed on this.
>> 
>> Noralf.
>> 
> 
> Okay, at the end i only want to know 2 things:
> 
> Does new message "Got unexpected interrupt" still appear after applying all 3 patches?
> 
> Does the annoying message "i2c-bcm2835 3f805000.i2c: i2c transfer timed out" still appear after applying all 3 patches?

I believe the issue is primarily that i2c0@3f805000 is 
“owned” by the firmware.

This is less of a problem on the rpi1 and rpi2, as there is 
little to no activity on those on i2c0 by the firmware
(besides when using the camera).

But on the rpi3 some Voltage sensors as well as GPIO 
extenders are attached to this bus, which are frequently
read/modified by the firmware.

So in principle this i2c bus should be disabled.
But if it is then there will be an interrupt triggered
on the VC4 core as well as on the ARM core - both will
see the interrupt.
but typically the RT-firmware will respond much faster
and disable the irq sources already before the arm gets
to “detect” the active interrupt in the irq handler.
But sometimes the firmware is not fast enough (or the irq
path is currently active in linux at the right time)
so the interrupt handler will trigger even if there
was no running i2c transfer on that bus.

The patch is basically defensive programming to avoid
such cases.

Martin


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
