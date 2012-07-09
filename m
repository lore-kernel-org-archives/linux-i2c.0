From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Fwd: Hid over I2C and ACPI interaction
Date: Mon, 9 Jul 2012 04:02:25 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B0A606@ORSMSX101.amr.corp.intel.com>
References: <CAN+gG=GnMX8Gu6w9za2QrjoVrmORncFgq-+hhmHvxtOPEB=nDw@mail.gmail.com>
 <4FF52C70.9010601@intel.com> <1341471717.1682.125.camel@rui.sh.intel.com>
 <20120706055234.GC2237@intel.com> <4FFA4EFD.6090708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FFA4EFD.6090708-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jkosina-AlSwsSmVLrQ@public.gmane.org" <jkosina-AlSwsSmVLrQ@public.gmane.org>, "chatty-rXV5z7KbLFk@public.gmane.org" <chatty-rXV5z7KbLFk@public.gmane.org>, "jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org" <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "abelay-3s7WtUTddSA@public.gmane.org" <abelay-3s7WtUTddSA@public.gmane.org>, "Lin, Ming M" <ming.m.lin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tang, Feng" <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

These are already defined in acpica - in the file acrestyp.h

    ACPI_RESOURCE_FIXED_DMA                 FixedDma;

    ACPI_RESOURCE_GPIO                      Gpio;
    ACPI_RESOURCE_I2C_SERIALBUS             I2cSerialBus;
    ACPI_RESOURCE_SPI_SERIALBUS             SpiSerialBus;
    ACPI_RESOURCE_UART_SERIALBUS            UartSerialBus;
    ACPI_RESOURCE_COMMON_SERIALBUS          CommonSerialBus;



>-----Original Message-----
>From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-acpi-
>owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Lan Tianyu
>Sent: Sunday, July 08, 2012 8:25 PM
>To: Mika Westerberg
>Cc: Zhang, Rui; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org;
>w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; jkosina-AlSwsSmVLrQ@public.gmane.org;
>chatty-rXV5z7KbLFk@public.gmane.org; jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; abelay-3s7WtUTddSA@public.gmane.org
>Subject: Re: Fwd: Hid over I2C and ACPI interaction
>
>On 2012年07月06日 13:52, Mika Westerberg wrote:
>> On Thu, Jul 05, 2012 at 03:01:57PM +0800, Zhang Rui wrote:
>>> +Note that although these are ACPI devices, we prefer to use PnP drivers
>>> for them,
>>> +this is because:
>>> +1. all the non-ACPI-predefined Devices are exported as PnP devices as
>>> well
>>> +2. PnP bus is a well designed bus. Probing via PnP layer saves a lot of
>>> work
>>> +   for the device driver, e.g. getting&  parsing ACPI resources.
>>
>> (Nice BKM, thanks for sharing)
>>
>> I have few questions about using PnP drivers instead of pure ACPI
>drivers.
>>
>> ACPI 5.0 defined some new resources, for example "Fixed DMA descriptor"
>> that has information about the request line + channel for the device to
>> use. Hovewer, PnP drivers pass resources as 'struct resource', which
>> basically only has start and end - how do you represent all this new
>stuff
>> using 'struct resource'?
>>
>I think we can add new interface to get acpi specific resources. e.g
>struct acpi_resource pnp_get_acpi_resource(...). When the pnp acpi devices
>were initialized, put those acpi specific resources into a new resource
>list
>pnpdev->acpi_resources. What pnp_get_acpi_resource does is to get specified
>type acpi resources and return. We also need to define some acpi resource
>types.
>
>ACPI_RESOURCE_DMA
>ACPI_RESOURCE_I2C_SERIALBUS
>ACPI_RESOURCE_SPI_SERIALBUS
>ACPI_RESOURCE_UART_SERIALBUS
>ACPI_RESOURCE_COMMON_SERIALBUS
>...
>
>How about this? welcome to comments.
>
>> Or should we use acpi_walk_resources() where 'struct resource' is not
>> suitable?
>>
>
>--
>Best Regards
>Tianyu Lan
>linux kernel enabling team
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
