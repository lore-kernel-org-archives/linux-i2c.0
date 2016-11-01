From: Phong Vo <pvo@apm.com>
Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when using DT
 ids through ACPI
Date: Tue, 1 Nov 2016 13:14:16 +0700
Message-ID: <8a69cdff155793e8e687d527d9ace97f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, leonard.crestez@intel.com
Cc: wsa+renesas@sang-engineering.com, rafael.j.wysocki@intel.com, len.brown@intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, daniel.baluta@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

>From: Mika Westerberg <mika.westerberg@linux.intel.com>
>Subject:=C2=A0Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when
using DT ids through ACPI
>Date: Monday 13th June 2016 09:26:55 UTC (5 months ago)
>
>On Fri, Jun 10, 2016 at 06:57:36PM +0300, Crestez Dan Leonard wrote:
>> On 06/10/2016 09:32 AM, Mika Westerberg wrote:
>> > On Thu, Jun 09, 2016 at 04:06:03PM +0300, Crestez Dan Leonard wrote:
>> >> When devices are instatiated through devicetree the i2c_client->name
is
>> >> set to the compatible string with company name stripped out. This is
>> >> then matched to the i2c_device_id table to pass the device_id to the
>> >> probe function. This id parameter is used by some device drivers to
>> >> differentiate between model numbers.
>> >>
>> >> When using ACPI this id parameter is NULL and the driver usually
needs
>> >> to do ACPI-specific differentiation.
>> >>
>> >> This patch attempts to find a valid i2c_device_id when using ACPI
with
>> >> DT-like compatible strings.
>> >
>> > So I don't really understand why it would be good idea to pass
>> > i2c_device_id for devices which are matched against their ACPI/DT
>> > tables. Apparently DT is already doing that so maybe there is some
>> > reason.
>> >
>> > Anyway, why not fill in the device name when it is first enumerated
>> > if it uses DT compatible property? Just like DT does.
>> >
>> This automatic matching of i2c_device_id works for devicetree because
>> of_i2c_register_device sets i2c_board_info.type to the compatible
string
>> with the vendor prefix removed. For I2C devices described via ACPI the
>> i2c_board_info.type string is set to the ACPI device name. This ends up
>> something like "PRP0001:00".
>>
>> This could be changed in acpi_i2c_get_info to use the of_compatible
>> string from DSD if present. Is that what you mean? That would work and
>> it would be cleaner than my patch. Something like this:
>>
>> diff --git drivers/i2c/i2c-core.c drivers/i2c/i2c-core.c
>> index 1e0ef9b..ba2fe7f 100644
>> --- drivers/i2c/i2c-core.c
>> +++ drivers/i2c/i2c-core.c
>> @@ -181,7 +181,24 @@ static int acpi_i2c_get_info(struct acpi_device
>*adev,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_dev_free_resource_l=
ist(&resource_list);
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strlcpy(info->type, dev_name(&adev=
->dev), sizeof(info->type));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we have a DT id set inf=
o.type to the first compatible
>> string with
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the vendor prefix stripped=
. This is similar to
>of_modalias_node
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->data.of_compatible) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const union acpi_object *obj;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const char *str, *chr;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 obj =3D adev->data.of_compatible;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0if (obj->type =3D=3D ACPI_TYPE_PACKAGE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 obj =3D obj=
->package.elements;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 str =3D obj->string.pointer;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 chr =3D strchr(str, ',');
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (chr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str =3D chr=
 + 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 strlcpy(info->type, str, sizeof(info->type));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 strlcpy(info->type, dev_name(&adev->dev),
>> sizeof(info->type));
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>=C2=A0 }>
>
>Yes, that's what I mean.
>
>> The biggest concern is that this would change the i2c device name
>> between kernel versions. Is that acceptable?
>
>I don't think that is a problem since I still have not seen a single
>system using ACPI _DSD so I would not expect anything to break.
>
>However, I'm still not convinced it is good idea to return i2c_device_id
>from a completely different table if we match using ACPI/DT table.

All,

Is there a conclusion on this? We have been tackling the same issue and
incidentally arrived at a
similar solution as like Lenard proposed=C2=A0 in the patch above.
