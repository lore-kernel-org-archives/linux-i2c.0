From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 0/6] drivers/i2c: Add FSI-attached I2C master algorithm
Date: Tue, 15 Aug 2017 11:28:50 -0500
Message-ID: <59175354-07ba-2bbb-962e-ac1de36dfa4a@linux.vnet.ibm.com>
References: <1501089198-10356-1-git-send-email-eajames@linux.vnet.ibm.com>
 <f324da3b-7c9e-3dc1-0cdc-91576c7a50b8@axentia.se>
 <CACPK8XexFdz63t4y5uO1GzoWrx=wnkqBxbYKGtuFq0JupeLNHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XexFdz63t4y5uO1GzoWrx=wnkqBxbYKGtuFq0JupeLNHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>, Peter Rosin <peda@axentia.se>
Cc: Eddie James <eajames@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org



On 8/15/17 3:10 AM, Joel Stanley wrote:
> On Tue, Aug 15, 2017 at 4:06 PM, Peter Rosin <peda@axentia.se> wrote:
>> On 2017-07-26 19:13, Eddie James wrote:
>>> From: "Edward A. James" <eajames@us.ibm.com>
>>>
>>> This series adds an algorithm for an I2C master physically located on an FSI
>>> slave device. The I2C master has multiple ports, each of which may be connected
>>> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>>>
>>> Due to the multi-port nature of the I2C master, the driver instantiates a new
>>> I2C adapter for each port connected to a slave. The connected ports should be
>>> defined in the device tree under the I2C master device.
>> Hmmm, AFAIU fsi is a bus, and on this bus you have some "client" device that
>> happens to be an i2c master, and this is a driver for that "client". Is it
>> totally inconceivable to have some other client device in the future that is
>> implementing an i2c master differently, but still using the fsi bus?
>>
>> With that in mind, is it wise to pick the driver name from the bus that the
>> device is connected to, and nothing else without further qualification?
>>
>> I don't see any "i2c-usb" driver, but I think there are a couple of i2c master
>> drivers that communicate via usb.
> You make a fair point. When I did a prototype of this driver I called
> it i2c-cfam, as it is part of the CFAM hardware unit inside of the
> Power8/Power9 processors.
>
> The documentation does call it FSI_I2CM, so that's an argument for the
> current name.
>
> I'm not sure how accurate that name is. Chris, Eddie, do you have any
> other suggestions?
The I2C engine up to now has been always accessed via the FSI bus so 
historically I assume that's why its labelled as FSI_I2CM in the p8/p9 
specs.  There isn't any reason this I2C device couldn't be implemented 
in some other topology independent of FSI / CFAMs.  In other words there 
are no FSI details internal to this I2C engine, an argument for removing 
the 'FSI' tag.

Thanks,
Chris

>
> Cheers,
>
> Joel
>
