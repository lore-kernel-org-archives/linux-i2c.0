From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Patch V3 0/5] I2C ACPI operation region handler
Date: Wed, 21 May 2014 10:16:13 +0800
Message-ID: <537C0C6D.4030203@intel.com>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com> <6169981.jIBZPeBvRE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <6169981.jIBZPeBvRE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B405=E6=9C=8821=E6=97=A5 05:25, Rafael J. Wysocki wrote:
> On Tuesday, May 20, 2014 08:59:19 PM Lan Tianyu wrote:
>> ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart) op=
eration
>> region. It allows ACPI aml code able to access such kind of devices =
to
>> implement some ACPI standard method.
>>
>> On the Asus T100TA, Bios use GenericSerialBus operation region to ac=
cess
>> i2c device to get battery info. So battery function depends on the I=
2C
>> operation region support. Here is the bug link.
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D69011
>>
>> Change since V2:
>>         Drop patchs of adding I2C smbus quick read/write and word/bl=
ock
>> process call functions because not find machines supporting such pro=
tocols
>> so far and can't test these functions.
>>         Merge patchs of "I2C ACPI related code clear up" and "Add CO=
NFIG_I2C_ACPI
>> config"
>> 	Patch 2: Add acpi_bus_detach_private_data() function to detach data=
 from
>> ACPI handle and replace ACPI_ERROR() with acpi_handle_debug() to avo=
id some redundant
>> error log. =20
>>
>> Change since V1:
>>        Fix some code style issues. Change prefix i2c_acpi to acpi_i2=
c.
>> Move ACPI related code in the i2c core to i2c-acpi.c. Add CONFIG_I2C=
_ACPI
>> and make i2c core built-in when it's set to avoid i2c ACPI operation=
 region
>> being removed.
>>
>> Lan Tianyu (5):
>>   ACPICA: Export acpi_buffer_to_resource symbol
>=20
> Redundant?

Yes.

>=20
>>   ACPI: Add acpi_bus_attach_private_data() to facilitate to attach d=
ata
>>     to ACPI handle
>>   ACPI/Thermal: Use acpi_bus_attach_private_data() to attach private
>>     data
>=20
> I can take the above two regardless of the I2C material below I guess=
?

Yes.

>=20
>>   I2C/ACPI: Add i2c ACPI operation region support
>>   I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI config
>>
>>  drivers/acpi/acpica/rscreate.c |   1 +
>>  drivers/acpi/bus.c             |  28 +++-
>>  drivers/acpi/thermal.c         |  11 +-
>>  drivers/i2c/Kconfig            |  18 +-
>>  drivers/i2c/Makefile           |   5 +-
>>  drivers/i2c/i2c-acpi.c         | 362 ++++++++++++++++++++++++++++++=
+++++++++++
>>  drivers/i2c/i2c-core.c         |  97 +----------
>>  include/acpi/acpi_bus.h        |   2 +
>>  include/linux/acpi.h           |  11 ++
>>  include/linux/i2c.h            |  12 ++
>>  10 files changed, 439 insertions(+), 108 deletions(-)
>>  create mode 100644 drivers/i2c/i2c-acpi.c
>>
>>
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
