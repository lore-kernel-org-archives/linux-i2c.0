From: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
Subject: Re: [PATCH, RFC] Earlier I2C initialization
Date: Thu, 12 Jun 2008 08:13:09 +1200
Message-ID: <485031D5.3020606__12617.639944847$1213172198$gmane$org@bluewatersys.com>
References: <200806091541.43899.u.luckas@road.de>	<20080609135739.GE30971@flint.arm.linux.org.uk>	<484D947D.1090900@bluewatersys.com>	<200806091359.12791.david-b@pacbell.net>	<484DA046.4010804@bluewatersys.com>	<20080610085708.12c2d2a2@hyperion.delvare>	<484F42AC.9030709@bluewatersys.com>
	<20080611094039.287ac136@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080611094039.287ac136-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Uli Luckas <u.luckas-vFjI0mZ6VZs@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Ryan,
>
> On Wed, 11 Jun 2008 15:12:44 +1200, Ryan Mallon wrote:
>   
>> Jean Delvare wrote:
>>     
>>> Why don't you simply initialize the drivers in question with
>>> subsys_initcall()? That's what i2c-pnx, i2c-omap, i2c-davinci and
>>> tps65010 are doing at the moment.
>>>       
>> I still think its a bit nasty marking a driver as subsys_initcall 
>> just because one particular setup needs it to be that way. We will
>> eventually end up with half of the busses/drivers in i2c marked
>> as subsys_initcall for random boards :-).
>>
>> How about this patch instead, which replaces module_init and 
>> subsys_initcalls in drivers/i2c with a new macro called
>> i2c_module_init. If CONFIG_I2C_EARLY is set then it will #define
>> to subsys_initcall, otherwise it becomes module_init. This way
>> boards that need i2c early can just select CONFIG_I2C_EARLY and
>> get all of i2c at subsys_initcall time. The link order should
>> guarantee that everything still comes up in the correct order in
>> the i2c driver subsystem.
>>
>> I have tested this on an ARM ep93xx board with a bit-bashed
>> i2c bus, a ds1339 rtc, and two max7311 IO expanders (using 
>> the pca953x) both with and without CONFIG_I2C_EARLY_INIT selected.
>> Of course it would need much more testing to verify it :-)
>>     
>
> Making this a compile time option means that you need different kernels
> for different machines, that's highly inconvenient. Or you end up using
> the I2C_EARLY_INIT one for all systems, but then why have a
> configuration option for it in the first place?
>   
Fair point. 

> Which problem are you trying to solve? Is there any actual drawback to
> abusing subsys_initcall() for the handful of i2c bus drivers which may
> need to come up early?
On many embedded devices there is a need for i2c to be early since it is
often used for core functionality. It seems at the moment, that the 
answer to this is to juggle a few of the drivers which people need to
get this to work. There are the drivers in drivers/i2c which use 
subsys_initcall. It does work, but it feels a bit untidy. Some of the i2c
IO expander drivers are now in drivers/gpio since that comes up early.
This can lead to confusion (see drivers/gpio/pca953x.c and 
drivers/i2c/chips/pca9539.c). As David suggested, if i2c is needed early
in enough cases, why not just move it early in the link order? My patch
was just an alternative approach which mimics the current behaviour, but
makes it possible to get any i2c driver early. Why not just mark all of
the drivers/busses that get used on embedded devices as subsys_initcall,
just in case somebody needs them early?

<snip>

> Bus drivers i2c-ali1535, i2c-ali1563, i2c-ali15x3, i2c-amd756-s4882,
> i2c-amd756, i2c-amd8111, i2c-i801, i2c-nforce2, i2c-piix4, i2c-sis5595,
> i2c-sis630, i2c-sis96x, i2c-via and i2c-viapro are for PC machines,
> where I2C is never needed early.
>
> Bus drivers i2c-i810, i2c-prosavage and i2c-savage4 are gone, no need
> to touch them.
>
> Bus drivers i2c-parport-light, i2c-parport, i2c-taos-evm and
> i2c-tiny-usb are for external adapters, so initializing them early
> isn't going to work... They depend on parport, serio and usb,
> respectively.
>
> i2c-stub is a software only driver for testing purposes, initializing
> it early is pointless (it's really only useful as a module.)
>   
<snip>

>
> Most of these chip drivers only expose sysfs interfaces. Having them
> initializing early is pointless. Only a few power management drivers
> may be needed early: isp1301_omap, menelaus, tps65010.
>
>   
>>  drivers/i2c/i2c-dev.c                  |    2 +-
>>     
>
> User-space interface, never needed early.
>
>   
>>  include/linux/i2c.h                    |    6 ++++++
>>  67 files changed, 74 insertions(+), 65 deletions(-)
>>     
>
> At the very least, you should only touch the drivers which you know
> need to be touched, rather than all drivers "just in case". But I don't
> think this is the way to go anyway, unless you can point out an actual
> problem with using subsys_initcall() unconditionally.
>
>   
I just ran a sed script over the drivers/i2c directory. The intent was to
mark the entire subsystem to come up early if CONFIG_I2C_EARLY is set,
and use i2c_module_init every where since it makes it more consistent, and
doesn't cost anything on setups where CONFIG_I2C_EARLY isn't defined.

The idea was basically that a board could clearly say: I want i2c early,
and have any busses and devices drivers it has configured as builtins
automatically be present early on.

~Ryan




_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
