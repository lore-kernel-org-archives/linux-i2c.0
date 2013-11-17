From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on one bus, and mux bus
 naming
Date: Sun, 17 Nov 2013 09:23:32 -0800
Message-ID: <5288FB94.6000304@roeck-us.net>
References: <5287B9E4.1020107@roeck-us.net> <20131116214116.3d035b76@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131116214116.3d035b76-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 11/16/2013 12:41 PM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sat, 16 Nov 2013 10:31:00 -0800, Guenter Roeck wrote:
>> I have an interesting situation with multiple i2c multiplexers (pca9548) on a single i2c bus.
>>
>> The problem with this is that multiple mux i2c adapters and up with the same name,
>> "i2c-N-mux (chan_id M)", where N is the parent bus number and M is the mux channel.
>> This makes it difficult to identify the actual mux chip serving a mux adapter.
>>
>> Here is an example with two pca9548 in a system, both connected to i2c bus 2 (which is
>> itself a mux connected to bus 0).
>>
>> # grep . */name
>> i2c-0/name:MPC adapter at 0xfff703000
>> i2c-1/name:MPC adapter at 0xfff703100
>> i2c-10/name:i2c-2-mux (chan_id 7)
>> i2c-11/name:i2c-2-mux (chan_id 0)
>> i2c-12/name:i2c-2-mux (chan_id 1)
>> i2c-13/name:i2c-2-mux (chan_id 2)
>> i2c-14/name:i2c-2-mux (chan_id 3)
>> i2c-15/name:i2c-2-mux (chan_id 4)
>> i2c-16/name:i2c-2-mux (chan_id 5)
>> i2c-17/name:i2c-2-mux (chan_id 6)
>> i2c-18/name:i2c-2-mux (chan_id 7)
>> i2c-19/name:i2c-0-mux (chan_id 1)
>> i2c-2/name:i2c-0-mux (chan_id 0)
>> i2c-20/name:i2c-0-mux (chan_id 2)
>> i2c-21/name:i2c-0-mux (chan_id 3)
>> i2c-22/name:i2c-0-mux (chan_id 4)
>> i2c-23/name:i2c-0-mux (chan_id 5)
>> i2c-24/name:i2c-0-mux (chan_id 6)
>> i2c-25/name:i2c-0-mux (chan_id 7)
>> i2c-3/name:i2c-2-mux (chan_id 0)
>> i2c-4/name:i2c-2-mux (chan_id 1)
>> i2c-5/name:i2c-2-mux (chan_id 2)
>> i2c-6/name:i2c-2-mux (chan_id 3)
>> i2c-7/name:i2c-2-mux (chan_id 4)
>> i2c-8/name:i2c-2-mux (chan_id 5)
>> i2c-9/name:i2c-2-mux (chan_id 6)
>>
>> In this example, i2c-3 and i2c-11 share the same name, as do i2c-4 and i2c-12 and so on.
>> If I now have, say, temperature sensors on address 0x49 on both i2c-3 and i2c-11,
>> I have no means to determine the location of those temperature sensors. Sure,
>> I can figure it out manually, but if something changes in bus numbering I have
>> to start all over again.
>
> I am aware of the problem. I did mention it when the i2c-mux code was
> originally submitted, but apparently nobody paid attention.
>
>> Would it be possible to add the chip address into the mux name ? Something like
>> 	i2c-N-XX-M-mux
>> where N is the parent bus number, XX is the mux i2c address, and M is the mux channel.
>
> That would partly solve the problem indeed. "i2c-N-mux-XX (chan_id M)"
> would be a slightly less intrusive change but functionally equivalent
> to your proposal.
>
Yes, that would be ok as well and might be less invasive for name scanning code.

> I say "partly" because these new names would still not be unique
> identifiers. You still have to check which bus is "N" in order to tell
> what the segment really is. Unfortunately, coming up with a naming
> scheme that includes the root bus name and works with arbitrary depths
> of multiplexing isn't easy. We currently have a static limit to the name length
> of i2c_adapters (47 chars) and I'm not sure we want to change that.
> Tools such as i2cdetect only have room for 32 characters, lower than
> the current maximum. OTOH libsensors, for example, needs truly unique
> bus names for per-chip configuration, and that doesn't work with the
> current scheme nor the scheme you proposed.
>
I think it would still be unique name, as long as the parent adapter number
is well defined (which it hopefully is). At least with the change I can
1) identify the mux and 2) walk back in the tree of i2c adapters to find
the root. Using above example, I know that i2c-2-mux (chan_id 0) is on bus 2.
Bus 2 is i2c-0-mux (chan_id 0), so I know it is connected to bus 0.

Am I missing something ?

>> I understand this may require an API change, as the mux chip is not necessarily an i2c
>> and the i2c-mux core code doesn't really care what the mux chip is. So maybe there is
>> a different/better solution; ultimately, what I need is really a means to identify
>> the mux chip if there are multiple muxes on a single i2c bus. And, of course, unique
>> i2c adapter names would be nice to have as well.
>>
>> Is there another way to identify the mux adapter chip through sysfs in this situation ?
>
> No reliable way I can think of. You can only suppose that in most cases
> the i2c bus segments will be created in the same order as the I2C slave
> address of the multiplexer they are branched from. So i2c-3 would be on
> the mux with the lower I2C address and i2c-11 on the mux with the
> higher I2C address. But that's only a guess and that may become wrong
> for various reasons.
>
Yes, it falls apart if part of the i2c chain is inserted and removed dynamically.
We have tried using fixed bus numbers, but that has its own problems.

Thanks,
Guenter
