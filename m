From: Thilo Cestonaro <thilo@cestona.ro>
Subject: Re: [PATCH] i2c-i801: use MEM resource instead of IO resource
Date: Tue, 12 Apr 2016 09:33:28 +0200
Message-ID: <fd8747be64462b1708964249beb834da@cestona.ro>
References: <4b887e81aae134c2cfea3e8bb0443c7d@cestona.ro>
 <1460444562.5044.3.camel@chaos.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.cestona.ro ([85.10.192.88]:41841 "EHLO smtp.cestona.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609AbcDLHda (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Apr 2016 03:33:30 -0400
In-Reply-To: <1460444562.5044.3.camel@chaos.suse>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hey Jean,

Am 12.04.2016 09:02, schrieb Jean Delvare:
> Hi Thilo,
> 
> On lun., 2016-04-11 at 11:24 +0200, Thilo Cestonaro wrote:
>> > Whenever I load the i2c-i801 smbus controller module I get a resource
>> conflict with the ACPI:
>> > -----------------------
>> > ACPI Warning: SystemIO range 0x000000000000F040-0x000000000000F05F
>> > conflicts with OpRegion 0x000000000000F040-0x000000000000F04F
>> > (\_SB_.PCI0.SBUS.SMBI) (20150619/utaddress-254)
>> > -----------------------
>> >
>> 
>> As the resource conflict is about the IO resource, I overworked the
>> i2c-i801 module to use the MEM resource which is altough available.
>> This is IMHO the better alternative to using the
>> "acpi_enforce_resources=lax" boot parameter.
>> 
>> The patched module is working on my machine.
> 
> To be honest, I didn't know the 82801 SMBus controller supported memory
> access. Does it actually work since the first supported controller
> (82801AA)?
> 
Good question! Perhaps I will implement an IO and MEM access depending 
on the ACPI conflict prioizing the IO access.

> But anyway, I can't see how using it solves any problem. I guess you
> access the very same registers, just using a different method. If the
> BIOS is actually using the SMBus controller, you have exactly the same
> conflict as before, the only difference is that it is no longer
> reported. This would be a regression, not an improvement.
> 
You are absolutely right, it doesn't solve anything so it is just an 
alternative to the boot parameter.
The advantage IMHO is, that you don't need to add the boot parameter and 
that this change only affects the module itself,
instead of like the parameter the whole system.

I can still show the conflict by checking the MEM resource and the IO 
resource, so the user will be informed about the problem but can use 
it's smbus.
Currently if the conflict will be shown the probe returns an error.

Hmm, perhaps showing the conflict and not returning with an error is the 
more easier way. Many use the boot parameter and haven't reported 
problems with it,
so I think using it despite the conflict wouldn't do any harm.

Cheers,
Thilo
