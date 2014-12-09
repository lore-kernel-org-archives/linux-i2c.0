From: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [v3] i2c: Driver to expose PowerNV platform i2c busses
Date: Tue, 09 Dec 2014 18:48:40 +0530
Message-ID: <5486F6B0.4030302@linux.vnet.ibm.com>
References: <20141209094503.100F81400DE@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141209094503.100F81400DE-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On 12/09/2014 03:15 PM, Michael Ellerman wrote:
> On Mon, 2014-08-12 at 06:36:16 UTC, Neelesh Gupta wrote:
>> The patch exposes the available i2c busses on the PowerNV platform
>> to the kernel and implements the bus driver to support i2c and
>> smbus commands.
>> The driver uses the platform device infrastructure to probe the busses
>> on the platform and registers them with the i2c driver framework.
>>   arch/powerpc/include/asm/opal.h                    |   29 ++
>>   arch/powerpc/platforms/powernv/opal-wrappers.S     |    1
>>   arch/powerpc/platforms/powernv/opal.c              |   11 +
> This had major conflicts in the above files.
>
> I've fixed it up but please check I did it correctly:
>
>    https://github.com/mpe/powerpc-merge/commits/pw/neelesh-i2c
>
> It also doesn't build as a module:
>
>    $ grep CONFIG_I2C_OPAL .config
>    CONFIG_I2C_OPAL=m
>    $ make ...
>    ...
>    ERROR: "opal_i2c_request" [drivers/i2c/busses/i2c-opal.ko] undefined!

Yeah, this needs to be exported.
I think for the same reason, "opal-rtc" is still waiting, plus awaiting 
"ack" from
maintainers.

- Neelesh

>
> cheers
>
