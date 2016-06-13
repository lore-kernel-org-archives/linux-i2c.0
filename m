From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when using DT
 ids through ACPI
Date: Mon, 13 Jun 2016 12:26:55 +0300
Message-ID: <20160613092655.GF1791@lahna.fi.intel.com>
References: <cover.1465477193.git.leonard.crestez@intel.com>
 <f5d92224a005bc7b82e210957719b7be142c6388.1465477193.git.leonard.crestez@intel.com>
 <20160610063232.GR1791@lahna.fi.intel.com>
 <6721468a-753d-fb52-5bc5-8738312b7bd0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12654 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964801AbcFMJ1C (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 13 Jun 2016 05:27:02 -0400
Content-Disposition: inline
In-Reply-To: <6721468a-753d-fb52-5bc5-8738312b7bd0@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>

On Fri, Jun 10, 2016 at 06:57:36PM +0300, Crestez Dan Leonard wrote:
> On 06/10/2016 09:32 AM, Mika Westerberg wrote:
> > On Thu, Jun 09, 2016 at 04:06:03PM +0300, Crestez Dan Leonard wrote:
> >> When devices are instatiated through devicetree the i2c_client->name is
> >> set to the compatible string with company name stripped out. This is
> >> then matched to the i2c_device_id table to pass the device_id to the
> >> probe function. This id parameter is used by some device drivers to
> >> differentiate between model numbers.
> >>
> >> When using ACPI this id parameter is NULL and the driver usually needs
> >> to do ACPI-specific differentiation.
> >>
> >> This patch attempts to find a valid i2c_device_id when using ACPI with
> >> DT-like compatible strings.
> > 
> > So I don't really understand why it would be good idea to pass
> > i2c_device_id for devices which are matched against their ACPI/DT
> > tables. Apparently DT is already doing that so maybe there is some
> > reason.
> > 
> > Anyway, why not fill in the device name when it is first enumerated
> > if it uses DT compatible property? Just like DT does.
> > 
> This automatic matching of i2c_device_id works for devicetree because
> of_i2c_register_device sets i2c_board_info.type to the compatible string
> with the vendor prefix removed. For I2C devices described via ACPI the
> i2c_board_info.type string is set to the ACPI device name. This ends up
> something like "PRP0001:00".
> 
> This could be changed in acpi_i2c_get_info to use the of_compatible
> string from DSD if present. Is that what you mean? That would work and
> it would be cleaner than my patch. Something like this:
> 
> diff --git drivers/i2c/i2c-core.c drivers/i2c/i2c-core.c
> index 1e0ef9b..ba2fe7f 100644
> --- drivers/i2c/i2c-core.c
> +++ drivers/i2c/i2c-core.c
> @@ -181,7 +181,24 @@ static int acpi_i2c_get_info(struct acpi_device *adev,
> 
>         acpi_dev_free_resource_list(&resource_list);
> 
> -       strlcpy(info->type, dev_name(&adev->dev), sizeof(info->type));
> +       /*
> +        * If we have a DT id set info.type to the first compatible
> string with
> +        * the vendor prefix stripped. This is similar to of_modalias_node
> +        */
> +       if (adev->data.of_compatible) {
> +               const union acpi_object *obj;
> +               const char *str, *chr;
> +
> +               obj = adev->data.of_compatible;
> +               if (obj->type == ACPI_TYPE_PACKAGE)
> +                       obj = obj->package.elements;
> +               str = obj->string.pointer;
> +               chr = strchr(str, ',');
> +               if (chr)
> +                       str = chr + 1;
> +               strlcpy(info->type, str, sizeof(info->type));
> +       } else
> +               strlcpy(info->type, dev_name(&adev->dev),
> sizeof(info->type));
> 
>         return 0;
>  }

Yes, that's what I mean.

> The biggest concern is that this would change the i2c device name
> between kernel versions. Is that acceptable?

I don't think that is a problem since I still have not seen a single
system using ACPI _DSD so I would not expect anything to break.

However, I'm still not convinced it is good idea to return i2c_device_id
from a completely different table if we match using ACPI/DT table.
