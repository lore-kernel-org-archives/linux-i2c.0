From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when using DT
 ids through ACPI
Date: Tue, 6 Dec 2016 09:00:36 -0800
Message-ID: <20161206170036.GA12356@dtor-ws>
References: <8a69cdff155793e8e687d527d9ace97f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8a69cdff155793e8e687d527d9ace97f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Phong Vo <pvo@apm.com>
Cc: mika.westerberg@linux.intel.com, leonard.crestez@intel.com, wsa+renesas@sang-engineering.com, rafael.j.wysocki@intel.com, len.brown@intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, daniel.baluta@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 01, 2016 at 01:14:16PM +0700, Phong Vo wrote:
> >From: Mika Westerberg <mika.westerberg@linux.intel.com>
> >Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when
> using DT ids through ACPI
> >Date: Monday 13th June 2016 09:26:55 UTC (5 months ago)
> >
> >On Fri, Jun 10, 2016 at 06:57:36PM +0300, Crestez Dan Leonard wrote:
> >> On 06/10/2016 09:32 AM, Mika Westerberg wrote:
> >> > On Thu, Jun 09, 2016 at 04:06:03PM +0300, Crestez Dan Leonard wrote:
> >> >> When devices are instatiated through devicetree the i2c_client->name
> is
> >> >> set to the compatible string with company name stripped out. This is
> >> >> then matched to the i2c_device_id table to pass the device_id to the
> >> >> probe function. This id parameter is used by some device drivers to
> >> >> differentiate between model numbers.
> >> >>
> >> >> When using ACPI this id parameter is NULL and the driver usually
> needs
> >> >> to do ACPI-specific differentiation.
> >> >>
> >> >> This patch attempts to find a valid i2c_device_id when using ACPI
> with
> >> >> DT-like compatible strings.
> >> >
> >> > So I don't really understand why it would be good idea to pass
> >> > i2c_device_id for devices which are matched against their ACPI/DT
> >> > tables. Apparently DT is already doing that so maybe there is some
> >> > reason.
> >> >
> >> > Anyway, why not fill in the device name when it is first enumerated
> >> > if it uses DT compatible property? Just like DT does.
> >> >
> >> This automatic matching of i2c_device_id works for devicetree because
> >> of_i2c_register_device sets i2c_board_info.type to the compatible
> string
> >> with the vendor prefix removed. For I2C devices described via ACPI the
> >> i2c_board_info.type string is set to the ACPI device name. This ends up
> >> something like "PRP0001:00".
> >>
> >> This could be changed in acpi_i2c_get_info to use the of_compatible
> >> string from DSD if present. Is that what you mean? That would work and
> >> it would be cleaner than my patch. Something like this:
> >>
> >> diff --git drivers/i2c/i2c-core.c drivers/i2c/i2c-core.c
> >> index 1e0ef9b..ba2fe7f 100644
> >> --- drivers/i2c/i2c-core.c
> >> +++ drivers/i2c/i2c-core.c
> >> @@ -181,7 +181,24 @@ static int acpi_i2c_get_info(struct acpi_device
> >*adev,
> >>
> >>         acpi_dev_free_resource_list(&resource_list);
> >>
> >> -       strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
> >> +       /*
> >> +        * If we have a DT id set info.type to the first compatible
> >> string with
> >> +        * the vendor prefix stripped. This is similar to
> >of_modalias_node
> >> +        */
> >> +       if (adev->data.of_compatible) {
> >> +               const union acpi_object *obj;
> >> +               const char *str, *chr;
> >> +
> >> +               obj = adev->data.of_compatible;
> >> +               if (obj->type == ACPI_TYPE_PACKAGE)
> >> +                       obj = obj->package.elements;
> >> +               str = obj->string.pointer;
> >> +               chr = strchr(str, ',');
> >> +               if (chr)
> >> +                       str = chr + 1;
> >> +               strlcpy(info->type, str, sizeof(info->type));
> >> +       } else
> >> +               strlcpy(info->type, dev_name(&adev->dev),
> >> sizeof(info->type));
> >>
> >>         return 0;
> >>  }>
> >
> >Yes, that's what I mean.
> >
> >> The biggest concern is that this would change the i2c device name
> >> between kernel versions. Is that acceptable?
> >
> >I don't think that is a problem since I still have not seen a single
> >system using ACPI _DSD so I would not expect anything to break.
> >
> >However, I'm still not convinced it is good idea to return i2c_device_id
> >from a completely different table if we match using ACPI/DT table.
> 
> All,
> 
> Is there a conclusion on this? We have been tackling the same issue and
> incidentally arrived at a
> similar solution as like Lenard proposed  in the patch above.

FWIW I agree with Mika (I think?) and I do not like that we mangle OF
data. This causes issues with module loading (where every OF ID has to
be stripped and added to the legacy table), and so forth. Drivers can
either use of_device_get_match_data() to get "real" OF id, or maybe we
could temporarily transform of_device_id into i2c_device_id in i2c bus
code and pass it to probe(), and do the same with ACPI match data.

Thanks.

-- 
Dmitry
