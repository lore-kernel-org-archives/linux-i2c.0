From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: Fwd: Hid over I2C and ACPI interaction
Date: Mon, 09 Jul 2012 11:24:45 +0800
Message-ID: <4FFA4EFD.6090708@intel.com>
References: <CAN+gG=GnMX8Gu6w9za2QrjoVrmORncFgq-+hhmHvxtOPEB=nDw@mail.gmail.com> <4FF52C70.9010601@intel.com> <1341471717.1682.125.camel@rui.sh.intel.com> <20120706055234.GC2237@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120706055234.GC2237@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, jj_ding@emc.com.tw, bhelgaas@google.com, abelay@mit.edu
List-Id: linux-i2c@vger.kernel.org

On 2012=E5=B9=B407=E6=9C=8806=E6=97=A5 13:52, Mika Westerberg wrote:
> On Thu, Jul 05, 2012 at 03:01:57PM +0800, Zhang Rui wrote:
>> +Note that although these are ACPI devices, we prefer to use PnP dri=
vers
>> for them,
>> +this is because:
>> +1. all the non-ACPI-predefined Devices are exported as PnP devices =
as
>> well
>> +2. PnP bus is a well designed bus. Probing via PnP layer saves a lo=
t of
>> work
>> +   for the device driver, e.g. getting&  parsing ACPI resources.
>
> (Nice BKM, thanks for sharing)
>
> I have few questions about using PnP drivers instead of pure ACPI dri=
vers.
>
> ACPI 5.0 defined some new resources, for example "Fixed DMA descripto=
r"
> that has information about the request line + channel for the device =
to
> use. Hovewer, PnP drivers pass resources as 'struct resource', which
> basically only has start and end - how do you represent all this new =
stuff
> using 'struct resource'?
>
I think we can add new interface to get acpi specific resources. e.g
struct acpi_resource pnp_get_acpi_resource(...). When the pnp acpi devi=
ces
were initialized, put those acpi specific resources into a new resource=
 list
pnpdev->acpi_resources. What pnp_get_acpi_resource does is to get speci=
fied
type acpi resources and return. We also need to define some acpi resour=
ce types.

ACPI_RESOURCE_DMA
ACPI_RESOURCE_I2C_SERIALBUS
ACPI_RESOURCE_SPI_SERIALBUS
ACPI_RESOURCE_UART_SERIALBUS
ACPI_RESOURCE_COMMON_SERIALBUS
=2E..

How about this? welcome to comments.

> Or should we use acpi_walk_resources() where 'struct resource' is not
> suitable?
>

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
