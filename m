From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c_imc: New driver for Intel's iMC, found on
 LGA2011 chips
Date: Tue, 17 Mar 2015 13:14:43 -0700
Message-ID: <CALCETrXvBxcZCyupHM6trb2Gv99MH9-HVG7ZuNGE2OPMZ7d7hA@mail.gmail.com>
References: <cover.1425934386.git.luto@amacapital.net> <86c8b4d72f76cfdb7f76ad48825fb10e51634429.1425934386.git.luto@amacapital.net>
 <5503B59B.2020502@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5503B59B.2020502-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Alun Evans <alun-eX+YDEU5biwsV2N9l4h3zg@public.gmane.org>, Robert Elliott <Elliott-VXdhtT5mjnY@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mar 13, 2015 9:15 PM, "Guenter Roeck" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>
> On 03/09/2015 01:55 PM, Andy Lutomirski wrote:
>>
>> Sandy Bridge Xeon and Extreme chips have integrated memory
>> controllers with (rather limited) onboard SMBUS masters.  This
>> driver gives access to the bus.
>>
>> There are various groups working on standardizing a way to arbitrate
>> access to the bus between the OS, SMM firmware, a BMC, hardware
>> thermal control, etc.  In the mean time, running this driver is
>> unsafe except under special circumstances.  Nonetheless, this driver
>> has real users.
>>
>> As a compromise, the driver will refuse to load unless
>> i2c_imc.allow_unsafe_access=Y.  When safe access becomes available,
>> we can leave this option as a way for legacy users to run the
>> driver, and we'll allow the driver to load by default if safe bus
>> access is available.
>>
>> Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
>> ---
>>   drivers/i2c/busses/Kconfig   |  17 ++
>>   drivers/i2c/busses/Makefile  |   1 +
>>   drivers/i2c/busses/i2c-imc.c | 567 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 585 insertions(+)
>>   create mode 100644 drivers/i2c/busses/i2c-imc.c
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index ab838d9e28b6..50e3d79122dd 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -149,6 +149,23 @@ config I2C_ISMT
>>           This driver can also be built as a module.  If so, the module will be
>>           called i2c-ismt.
>>
>> +config I2C_IMC
>> +       tristate "Intel iMC (LGA 2011) SMBus Controller"
>> +       depends on PCI && X86
>> +       help
>> +         If you say yes to this option, support will be included for the Intel
>> +         Integrated Memory Controller SMBus host controller interface.  This
>> +         controller is found on LGA 2011 Xeons and Core i7 Extremes.
>> +
>> +         There are currently no systems on which the kernel knows that it can
>> +         safely enable this driver.  For now, you need to pass this driver a
>> +         scary module parameter, and you should only pass that parameter if you
>> +         have a special motherboard and know exactly what you are doing.
>> +         Special motherboards include the Supermicro X9DRH-iF-NV.
>> +
>
> I think the current approach of issuing warnings here and in the driver on load
> is the wrong one. For the most part, users will just run with distributions.
> If a distribution enables the driver, it will end up being used, warning or not.
>
> A much better approach, in my opinion, would be to only enable the driver for
> systems where it is known (or presumed) to be good, such as the Supermicro board
> mentioned above. This can be done with DMI data.
>
> For other boards, a 'force' module parameter can be added. This would ensure
> that the user _has_ to do something manually to load the driver. The warning
> on load would then only be displayed if the force module parameter is set.
>

This driver already has that: that's what "allow_unsafe_access" does.

I wouldn't be opposed to adding a DMI whitelist, although I really
don't want DMI entries to proliferate.

> Having said that, I am still not convinced that the driver should be in the kernel
> to start with. Browsing through Intel's datasheets, the registers are supported
> in E5-2600 v1, v2, and v3. However, in v3 Intel added a note saying that the registers
> should not be accessed by the OS directly, but only through the bios. Given that,
> and if that is possible, it might make more sense to rely on ACPI. It would then
> be up to the board and/or BIOS vendor to decide if the information should be available
> to the OS or not.

I think the plan is to add something to ACPI to tell us when we can
use these registers.  Unfortunately I'm not privy to whatever the ACPI
committee is doing.


--Andy
