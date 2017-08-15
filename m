From: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Tue, 15 Aug 2017 12:53:52 -0500
Message-ID: <7802dc48-6850-b7e3-5dbf-ee333cdf0c83@linux.vnet.ibm.com>
References: <1501089198-10356-1-git-send-email-eajames@linux.vnet.ibm.com>
 <f324da3b-7c9e-3dc1-0cdc-91576c7a50b8@axentia.se>
 <CACPK8XexFdz63t4y5uO1GzoWrx=wnkqBxbYKGtuFq0JupeLNHQ@mail.gmail.com>
 <59175354-07ba-2bbb-962e-ac1de36dfa4a@linux.vnet.ibm.com>
 <538605fe-f109-b84c-cc21-f1b9824ad5d0@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <538605fe-f109-b84c-cc21-f1b9824ad5d0-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Christopher Bostic <cbostic-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 08/15/2017 12:35 PM, Peter Rosin wrote:
> On 2017-08-15 18:28, Christopher Bostic wrote:
>> On 8/15/17 3:10 AM, Joel Stanley wrote:
>>> On Tue, Aug 15, 2017 at 4:06 PM, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org> wrote:
>>>> On 2017-07-26 19:13, Eddie James wrote:
>>>>> From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
>>>>>
>>>>> This series adds an algorithm for an I2C master physically located on an FSI
>>>>> slave device. The I2C master has multiple ports, each of which may be connected
>>>>> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>>>>>
>>>>> Due to the multi-port nature of the I2C master, the driver instantiates a new
>>>>> I2C adapter for each port connected to a slave. The connected ports should be
>>>>> defined in the device tree under the I2C master device.
>>>> Hmmm, AFAIU fsi is a bus, and on this bus you have some "client" device that
>>>> happens to be an i2c master, and this is a driver for that "client". Is it
>>>> totally inconceivable to have some other client device in the future that is
>>>> implementing an i2c master differently, but still using the fsi bus?
>>>>
>>>> With that in mind, is it wise to pick the driver name from the bus that the
>>>> device is connected to, and nothing else without further qualification?
>>>>
>>>> I don't see any "i2c-usb" driver, but I think there are a couple of i2c master
>>>> drivers that communicate via usb.
>>> You make a fair point. When I did a prototype of this driver I called
>>> it i2c-cfam, as it is part of the CFAM hardware unit inside of the
>>> Power8/Power9 processors.
>>>
>>> The documentation does call it FSI_I2CM, so that's an argument for the
>>> current name.
>>>
>>> I'm not sure how accurate that name is. Chris, Eddie, do you have any
>>> other suggestions?
>> The I2C engine up to now has been always accessed via the FSI bus so
>> historically I assume that's why its labelled as FSI_I2CM in the p8/p9
>> specs.  There isn't any reason this I2C device couldn't be implemented
>> in some other topology independent of FSI / CFAMs.  In other words there
>> are no FSI details internal to this I2C engine, an argument for removing
>> the 'FSI' tag.
> Note that I wasn't primarily concerned with this i2c engine growing some other
> non-fsi interface (like many devices have both i2c and spi interface versions).
> I was more concerned with some future and totally different i2c engine that
> naturally sports a totally different register map but still uses the fsi bus.
>
> But you have a point. If this i2c engine evolves and ends up supporting some
> other interface, then that too would be cause to regret the i2c-fsi name.

i2c-cfam would work, though it would also be possible for another type 
of i2c engine to exist on a CFAM... it has been done in the past.

Historically, this driver was called "iic-boe" for "Boeblingen". I'm not 
suggesting it's a good name for this driver, but it is unique...

Edduie

>
> Cheers,
> peda
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
