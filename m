From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Mon, 18 Apr 2016 17:26:54 +0200
Message-ID: <5714FCBE.3060009@metafoo.de>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
 <20160415080111.GD1714@lahna.fi.intel.com>
 <1460992811.8946.22.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460992811.8946.22.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean-Michel Hautbois <jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Jean-Michel Hautbois <jean-michel.hautbois-JiVWUdsMzBtWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/18/2016 05:20 PM, Srinivas Pandruvada wrote:
> On Fri, 2016-04-15 at 11:01 +0300, Mika Westerberg wrote:
>> +Srinivas
>>
>> On Sun, Jan 31, 2016 at 04:33:00PM +0100, Jean-Michel Hautbois wrote:
>>>
>>> Some I2C devices have multiple addresses assigned, for example each
>>> address
>>> corresponding to a different internal register map page of the
>>> device.
>>> So far drivers which need support for this have handled this with a
>>> driver
>>> specific and non-generic implementation, e.g. passing the
>>> additional address
>>> via platform data.
>>>
>>> This patch provides a new helper function called
>>> i2c_new_secondary_device()
>>> which is intended to provide a generic way to get the secondary
>>> address
>>> as well as instantiate a struct i2c_client for the secondary
>>> address.
>>>
>>> The function expects a pointer to the primary i2c_client, a name
>>> for the secondary address and an optional default address. The name
>>> is used
>>> as a handle to specify which secondary address to get.
>>>
>>> The default address is used as a fallback in case no secondary
>>> address
>>> was explicitly specified. In case no secondary address and no
>>> default
>>> address were specified the function returns NULL.
>>>
>>> For now the function only supports look-up of the secondary address
>>> from devicetree, but it can be extended in the future
>>> to for example support board files and/or ACPI.
>> It was not clear to me but does this support more than two addresses?
> 
> In past when we were looking at this for Invensese MPU60XX device, we
> had two I2cSerialBus() entries, but they belong to two different
> devices. The first one for the MPU60XX and second one for another
> device which is a slave for MPU60XX. This slave device can be also be
> reached from master i2c controller, by disabling i2c master capability
> of MPU60XX device.
> So ACPI spec is very vague in specifying what they really meant.
> 
>> For example we might a device with 3 I2cSerialBus() connectors:
>>
>>     Device (CAM1)
>>     {
>>         Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource
>> Settings
>>         {
>>             Name (SBUF, ResourceTemplate ()
>>             {
>>                 ...
>>                 I2cSerialBus (0x0010, ControllerInitiated,
>> 0x00061A80,
>>                     AddressingMode7Bit, "\\_SB.I2C4",
>>                     0x00, ResourceConsumer, ,)
>>                 I2cSerialBus (0x000C, ControllerInitiated,
>> 0x00061A80,
>>                     AddressingMode7Bit, "\\_SB.I2C4",
>>                     0x00, ResourceConsumer, ,)
>>                 I2cSerialBus (0x0054, ControllerInitiated,
>> 0x00061A80,
>>                     AddressingMode7Bit, "\\_SB.I2C4",
>>                     0x00, ResourceConsumer, ,)
>>             })
>>             Return (SBUF) /* \_SB_.I2C4.CAM1._CRS.SBUF */
>>         }
>>         ...
>>
>> Furthermore those do not have names.
> Correct. Better to use indexes. I think Mika also proposed similar API
> in past.

A generic API by indexes wont work. The order between DT and ACPI will most
likely be different. I'd even assume that the order will be different with
ACPI for the same device on different platforms.

If we want to support ACPI over the same interface drivers need to provide a
lookup table that maps a name to the index.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
