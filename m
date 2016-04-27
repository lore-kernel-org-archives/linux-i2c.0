From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] i2c-smbus: Don't report duplicate alerts
Date: Wed, 27 Apr 2016 09:28:07 -0500
Message-ID: <5720CC77.2080507@acm.org>
References: <1453222848-20457-1-git-send-email-minyard@acm.org>
 <20160303205754.GE1711@katana> <1457086557.4527.15.camel@chaos.site>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33425 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbcD0O2L (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Apr 2016 10:28:11 -0400
Received: by mail-oi0-f65.google.com with SMTP id f63so7649118oig.0
        for <linux-i2c@vger.kernel.org>; Wed, 27 Apr 2016 07:28:10 -0700 (PDT)
In-Reply-To: <1457086557.4527.15.camel@chaos.site>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On 03/04/2016 04:15 AM, Jean Delvare wrote:
> Le Thursday 03 March 2016 =C3=A0 21:57 +0100, Wolfram Sang a =C3=A9cr=
it :
>> On Tue, Jan 19, 2016 at 11:00:48AM -0600, minyard@acm.org wrote:
>>> From: Corey Minyard <cminyard@mvista.com>
>>>
>>> Getting the same alert twice in a row is legal and normal,
>>> especially on a fast device (like running in qemu).  Kind of
>>> like interrupts.  So don't report duplicate alerts, and deliver
>>> them normally.
>>>
>>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Looks plausible to me, but I never used SMBALERT myself. Any chance =
this
>> can cause a regression? Jean, what do you think?
> I'm afraid I had a good reason to add this check back then. I'll test
> with my ADM1032 evaluation board when I get back home (tomorrow at th=
e
> earliest.) Maybe my hardware was misbehaving, in which case I agree a=
ny
> filtering should be done at the device driver level. But I must doubl=
e
> check what the SMBus specification says too.

I looked at the SMBus specification and I couldn't find anything that
would speak to this particular issue.  It says it has to stop asserting
the interrupt when the ack is received on the bus, but it doesn't say
when it can re-assert the interrupts.

I will say that without this change SMBus alerts are fairly useless
with IPMI over SMBus on both real hardware and in qemu.  It just
spews out these warning messages in qemu, and it prints them out
periodically on real hardware.

To give an idea of what's happening here, on IPMI over SMBus, the
IPMI controller (BMC) will signal that it needs the host to do somethin=
g
using an alert.  The driver does an I2C write to send a request to the
BMC to find out what it needs.  The BMC performs the request then
signals with an SMBus alert that the response is ready.  If the BMC is
very fast (like in the qemu case) or the host gets delayed enough befor=
e
coming back to this loop, the BMC will have the response ready and
reassert alert before the next check in the loop.

I don't see a way to fix this that handles both scenarios.

-corey

> Either way the patch's subject is misleading. Should be "Don't filter
> out duplicate alerts" or something like that.
>
>>> ---
>>>   drivers/i2c/i2c-smbus.c | 7 -------
>>>   1 file changed, 7 deletions(-)
>>>
>>> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
>>> index 94765a8..cecd423 100644
>>> --- a/drivers/i2c/i2c-smbus.c
>>> +++ b/drivers/i2c/i2c-smbus.c
>>> @@ -75,7 +75,6 @@ static void smbus_alert(struct work_struct *work)
>>>   {
>>>   	struct i2c_smbus_alert *alert;
>>>   	struct i2c_client *ara;
>>> -	unsigned short prev_addr =3D 0;	/* Not a valid address */
>>>  =20
>>>   	alert =3D container_of(work, struct i2c_smbus_alert, alert);
>>>   	ara =3D alert->ara;
>>> @@ -99,18 +98,12 @@ static void smbus_alert(struct work_struct *wor=
k)
>>>   		data.flag =3D status & 1;
>>>   		data.addr =3D status >> 1;
>>>  =20
>>> -		if (data.addr =3D=3D prev_addr) {
>>> -			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
>>> -				"0x%02x, skipping\n", data.addr);
>>> -			break;
>>> -		}
>>>   		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
>>>   			data.addr, data.flag);
>>>  =20
>>>   		/* Notify driver for the device which issued the alert */
>>>   		device_for_each_child(&ara->adapter->dev, &data,
>>>   				      smbus_do_alert);
>>> -		prev_addr =3D data.addr;
>>>   	}
>>>  =20
>>>   	/* We handled all alerts; re-enable level-triggered IRQs */
>
