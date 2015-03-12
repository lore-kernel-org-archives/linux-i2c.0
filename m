From: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Subject: Re: Another problem with I2C multiplexer bus naming
Date: Thu, 12 Mar 2015 12:12:45 -0700
Message-ID: <5501E52D.9060400@rafresearch.com>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com> <20150312094227.GA4225@katana> <20150312112917.GA4888@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150312112917.GA4888@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 3/12/2015 4:29 AM, Wolfram Sang wrote:
> On Thu, Mar 12, 2015 at 10:42:27AM +0100, Wolfram Sang wrote:
>>
>>> [    2.951717] omap_i2c 44e0b000.i2c: failure adding adapter
>>> ...snipped...
>>> [    2.964249] omap_i2c: probe of 44e0b000.i2c failed with error -16
>>> ... snipped ...
>>
>> Thanks! After a first glimpse, this seems to be a bug. The omap driver
>> uses i2c_add_numbered_adapter here in DT context, and thus
>> __i2c_first_dynamic_bus_num is not properly increased because there is
>> no static board_info. Will have a look.
>
> Using non-DT becomes so rare that my knowledge about it gets rusty :(
>
> Yes, one can't mix i2c_add_numbered_adapter and i2c_add_adapter well,
> and this is even documented. However, since you are DT only, this
> doesn't apply.
>
I have not seen any documentation to regarding this topic.
I remember adding an i2c multiplexer to an early beagleboard system years
ago. I think we were lucky that the fixed i2c bus addresses were probed
first, so they were not stolen by the multiplexer's dynamic allocations.
(Dynamic allocation does not steal bus addresses from previously
allocated adapters.)

> I don't know all of your dts files, but I assume there is already an
> alias for busses 0/2 somewhere?
>
Yes, aliases for known buses and adapters are in
/arch/arm/boot/dts/am33xx.dtsi
All of the cpu boards that use this chip include this file.

Although there is no documentation stating the effect that these aliases 
have, it gave me the idea to try to use them to name the multiplexer's 
child buses.

Other device documentation...
http://devicetree.org/Device_Tree_Usage#aliases_Node
describe an alias as a way to avoid "cumbersome" full path node names.
It also states, "The operating system is welcome to use the aliases when 
assigning an identifier to a device."

It would be useful also state that the i2c bus naming mechanism uses 
aliases to name i2c buses.

Thanks,
Bob
