From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 06/15] i2c: acpi: Assign fwnode for devices created via
 i2c_acpi_new_device()
Date: Wed, 21 Nov 2018 12:44:27 +0100
Message-ID: <c2ad13ad-cf27-2700-a051-4dda56755ebd@redhat.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
 <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120155924.10773-7-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 20-11-18 16:59, Andy Shevchenko wrote:
> i2c_acpi_new_device() doesn't assign fwnode like it's done, for example,
> in i2c_acpi_register_devices() path.
> 
> Assign fwnode in i2c_acpi_new_device() as it's done elsewhere.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As already mentioned in my reply to the cover letter, a NACK from me for
this one.

The problem is that this causes the fwnode to be shared by all the
"struct device"-s (embedded in the i2c-clients created).

This in itself is not necessarily a problem, but it does become a
problem when combined with using device_add_properties as
intel_cht_int33fe.c does.

Since the info in the ACPI tables for devices which use this
driver is pretty terrible, we add a bunch of properties to notify
the drivers about how the different parts which make up the Type-C
functionality are tied together.

device_add_properties creates a new fwnode and then calls
set_secondary_fwnode. For devices which already have a fwnode
assigned (which the i2c-clients will have after this patch)
set_secondary_fwnode sets dev->fwnode->secondary to the fwnode
which has been newly created to hold the added properties.

Since all i2c-clients instantiated now share dev->fwnode,
the result of this is that all i2c-clients created now will
have the properties of the last i2c-client instantiated for
an acpi-node which describes multiple clients in a single
node.

Also the fwnodes created  for the properties of earlier
instantiated i2c-clients will be leaked.

I see 2 possible solutions here:

1) Changing this patch so that i2c_acpi_new_device() does:

         /*
          * The fwnode can not be shared between instantiated clients when
          * adding device-properties to the instantiated client.
          */
	if (!info->properties)
		info->fwnode = acpi_fwnode_handle(adev);

2) Leave whether info->fwnode should be set or not up to the
caller of i2c_acpi_new_device() (info is already passed in as
a param). E.g. i2c-multi-instantiate.c could do this (for now,
maybe in the future we will also want to add properties for
some HIDs).

I think that 1. is the best solution and this is all kernel internal,
so we can always revisit this if necessary.

Regards,

Hans



> ---
>   drivers/i2c/i2c-core-acpi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index af4b5bd5d973..478862abb82a 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -420,6 +420,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
>   	if (!adapter)
>   		return NULL;
>   
> +	info->fwnode = acpi_fwnode_handle(adev);
>   	return i2c_new_device(adapter, info);
>   }
>   EXPORT_SYMBOL_GPL(i2c_acpi_new_device);
> 
