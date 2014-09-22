From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] i2c: Add generic support passing secondary devices addresses
Date: Mon, 22 Sep 2014 16:11:52 +0200
Message-ID: <54202E28.80500@metafoo.de>
References: <1409925739-28188-1-git-send-email-jean-michel.hautbois@vodalys.com> <20140922104555.GQ1786@lahna.fi.intel.com> <542023C8.8080802@metafoo.de> <20140922134535.GZ1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140922134535.GZ1786@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, srinivas.pandruvada@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On 09/22/2014 03:45 PM, Mika Westerberg wrote:
> On Mon, Sep 22, 2014 at 03:27:36PM +0200, Lars-Peter Clausen wrote:
>> On 09/22/2014 12:45 PM, Mika Westerberg wrote:
>>> On Fri, Sep 05, 2014 at 04:02:19PM +0200, Jean-Michel Hautbois wrote:
>>>> Some I2C devices have multiple addresses assigned, for example each address
>>>> corresponding to a different internal register map page of the device.
>>>> So far drivers which need support for this have handled this with a driver
>>>> specific and non-generic implementation, e.g. passing the additional address
>>>> via platform data.
>>>>
>>>> This patch provides a new helper function called i2c_new_secondary_device()
>>>> which is intended to provide a generic way to get the secondary address
>>>> as well as instantiate a struct i2c_client for the secondary address.
>>>>
>>>> The function expects a pointer to the primary i2c_client, a name
>>>> for the secondary address and an optional default address. The name is used
>>>> as a handle to specify which secondary address to get.
>>>>
>>>> The default address is used as a fallback in case no secondary address
>>>> was explicitly specified. In case no secondary address and no default
>>>> address were specified the function returns NULL.
>>>>
>>>> For now the function only supports look-up of the secondary address
>>> >from devicetree, but it can be extended in the future
>>>> to for example support board files and/or ACPI.
>>>>
>>>> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
>>>
>>> Sorry, just noticed this one.
>>>
>>> Srinivas (CC'd) and I did similar patch series here:
>>>
>>> http://patchwork.ozlabs.org/patch/338342/
>
> Sorry I gave wrong link. That one is older version.
>
> Here is the current:
>
> http://patchwork.ozlabs.org/patch/386409/
> http://patchwork.ozlabs.org/patch/386410/
>
>>>
>>> We should probably collaborate on this one to get both DT and ACPI
>>> supported.
>>
>> Yes. The idea was to keep the interface of the API generic so it can be used
>> by ACPI or other device topology description mechanisms as well.
>>
>> But it looks as if the ACPI case is a bit more complex and we may need a
>> revision of the API. How for example in the ACPI case do you know which
>> address is which, when different parts of a chip are addressed using
>> different addresses?
>
> Unfortunately there is no way in ACPI 5.0 to find out which is which. So
> we trust the ordering of I2cSerialBus() resources. Even that has been
> problematic because some vendors then list things like SMBus ARA
> addresses there in random order :-(
>
> Our API has following signature:
>
> int i2c_address_by_index(struct i2c_client *client, int index,
> 			 struct i2c_board_info *info,
> 			 struct i2c_adapter **adapter)
>
> and we use index to find out which address to use.
>
> Note also that in ACPI it is possible that the I2cSerialBus() resource
> points to another I2C host controller, so we need to have 'adapter'
> parameter as well.
>

Ok, looks like there are two main differences in the two implementations.

1) The ACPI one uses a integer index and the DT one uses a string index to 
lookup the device.

The problem with the index lookup is that the order is binding specific. So 
it might be different between e.g. the devicetree binding and the ACPI 
binding. This makes it quite hard to use the API in a generic way and you'd 
end up with hacks like:

if (client->dev.of_node)
	index = 3;
else if (ACPI_COMPANION(client->dev))
	index = 1;
else
	index = 5;


So we might need a extra translation table which maps a name to a ACPI index 
and then we could use the name as the generic index in the driver.

2) The ACPI implementation returns the i2c_board_info and the adapter, while 
the DT implementation returns the instantiated I2C client device.

It might make sense to have both. I image that most drivers are just 
interested in creating a new client device and will simply pass the board 
info and adapter they got to i2c_new_device(). In this case it makes sense 
to have a helper function which already does this internally to avoid 
boilerplate code duplication.

There will probably some special cases though in which case the driver wants 
to get the adapter and the board info and then manually call 
i2c_new_device() after having done some additional steps.

- Lars
