From: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] i2c: add irq_flags to board info
Date: Mon, 18 Oct 2010 13:31:21 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713094520FA6@LIMKCMBX1.ad.analog.com>
References: <1287359019-1476-1-git-send-email-vapier@gentoo.org>
	<20101018103610.77b7e605@endymion.delvare>
	<544AC56F16B56944AEC3BD4E3D5917713094520EDB@LIMKCMBX1.ad.analog.com>
 <20101018140136.2b44d29e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101018140136.2b44d29e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, "device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org" <device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote on 2010-10-18:
> Hi Michael,
>
> On Mon, 18 Oct 2010 10:55:57 +0100, Hennerich, Michael wrote:
>> Jean Delvare wrote on 2010-10-18:
>>> Hi Mike,
>>>
>>> On Sun, 17 Oct 2010 19:43:39 -0400, Mike Frysinger wrote:
>>>> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>>>
>>>> These flags can be optionally defined - slave drivers may use them as
>>>> flags argument for request_irq().  In case they are left
>>>> uninitialized they will default to zero, and therefore shouldn't
>>>> cause problems.
>>>>
>>>> This allows us to avoid having to add dedicated platform init
>>>> code just to call set_irq_type()
>>>
>>> Do you have examples of this? Can we see a preview of the amount
>>> of cleanups this patch would allow?
>>
>> Examples can be found in various board setup files:
>>
>> One example arch/sh/boards/mach-ecovec24/setup.c:
>>
>> static struct i2c_board_info ts_i2c_clients = {
>>         I2C_BOARD_INFO("tsc2007", 0x48),
>>         .type           = "tsc2007",
>>         .platform_data  = &tsc2007_info,
>>         .irq            = IRQ0,
>> };
>>
>> [--snip--]
>>
>>                 /* enable TouchScreen */
>>                 i2c_register_board_info(0, &ts_i2c_clients, 1);
>>                 set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
>
> This example doesn't quite match the patch description. There's no
> "dedicated platform init code just to call set_irq_type()", as you
> already have platform code to call i2c_register_board_info(). It's
> really only calling set_irq_type() from platform code vs. from driver
> code.

In the past I also saw initcalls just doing set_irq_type(), to make drivers happy.
That doesn't pass the right irq_flags along with request_irq().

>>>> -- which doesn't work very well when coupled with module drivers.
>>>
>>> I don't quite get what you mean here.
>>
>> Since the driver doesn't setup the irq_type itself you need to do it
>> manually in advance using set_irq_type().
>> This happens most likely from your paltform setup/configuration file.
>>
>> Assuming the driver is built as a module, this code gets executed
>> unconditionally, no matter if the driver gets finally loaded or not.
>>
>> Assuming you have several drivers build as modules, using the same irq
>> but with different irq types, you run into problems here.
>
> I do not get why.
>
> You're not going to register several I2C devices using the same IRQ
> but requiring different IRQ flags anyway, as it wouldn't work. So
> you'll have to only register the I2C devices which are actually
> present on the system. Setting the IRQ type at the same time or
> deferring this action to the driver(s) doesn't make any difference then, does it?

If I remember correctly i2c as well as spi doesn't check for irq conflicts in irqs passed with
struct i2c/spi_board_info. So you can have multiple drivers build as modules all using the same
irq number but with different flags.

The user decides which add-on module is plugged onto the processor board, by loading the appropriate
driver module.

>> There are some development boards featuring extension options, which
>> all plug on the same socket but required different drivers/irq types.
>
> How do you figure out which extension option is plugged? You can't
> instantiate an I2C device which isn't present, so you must have a way
> to know what extension option is used, to instantiate the right I2C
> device at the right address.

The user decides.
The platform code provides resources for all potential boards being used.
And here is exactly the conflict.

>> The ideal way is therefore to pass the irq_flags together with the
> SPI/I2C board info.
>
> All I see so far is two data structures made slightly larger, for no
> actual benefit.

I don't see a reason why i2c/spi bus drivers should be different from other bus drivers.
The platform_device bus driver allows you to pass IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL with flags
in struct resource.

There are drivers that work around this deficiency, by adding irq_flags to the bus clients dev.platform_data
See include/linux/spi/ads7846.h for one example.

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
