From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Tue, 19 Apr 2016 17:40:27 +0300
Message-ID: <20160419144027.GH1725@lahna.fi.intel.com>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
 <20160415080111.GD1714@lahna.fi.intel.com>
 <1460992811.8946.22.camel@linux.intel.com>
 <5714FCBE.3060009@metafoo.de>
 <20160419124028.GF1725@lahna.fi.intel.com>
 <57162C4E.9090904@metafoo.de>
 <20160419131631.GG1725@lahna.fi.intel.com>
 <5716333D.1040106@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5716333D.1040106-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean-Michel Hautbois <jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Jean-Michel Hautbois <jean-michel.hautbois-JiVWUdsMzBtWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 19, 2016 at 03:31:41PM +0200, Lars-Peter Clausen wrote:
> It adds a standard API for dealing with devices that have more than one
> address. It uses the normal way of specifying multiple (named) address in DT.
> 
> reg = <0xa>, <0xb>, <0xc>;
> reg-names = "main", "aux1", "aux2";
> 
> The function the new i2c_new_secondary_device() function takes the name of
> the address region and allocates a dummy I2C client for it, which can be
> used to access that I2C part of the device that responds to that region. The
> name is used to lookup the address from the name to address map.

Thanks for the explanation.

Yes, I think we can support this in ACPI using both _DSD and built-in
properties so we do not need to add new fields to struct acpi_device
like we did with GPIOs. If _DSD does not have "reg-names" property we
can provide built-in version in a driver:

	static const char *mydev_reg_names[] = { "main", "aux1", "aux2" };
		
	static struct property_entry mydev_properties[] = {
		PROPERTY_ENTRY_STRING_ARRAY("reg-names", mydev_reg_names),
		{ },
	};

Then call device_add_properties() for the "primary" I2C client to make
them available to the unified properties API.

The i2c_new_secondary_device() would then look like:

	struct i2c_client *i2c_new_secondary_device(struct i2c_client *client,
					    const char *name, u16 default_addr)
	{       
		struct device_node *np = client->dev.of_node;
		u32 addr = default_addr;
		int i;
		
		i = device_property_match_string(&client->dev, "reg-names", name);
		if (i >= 0) {
			if (np) {
				of_property_read_u32_index(np, "reg", i, &addr);
			} else if (has_acpi_companion(&client->dev)) {
				/* Look for the ith I2cSerialBus() in _CRS */
			}
		}

		dev_dbg(&client->adapter->dev, "Address for %s : 0x%x\n", name, addr);
		return i2c_new_dummy(client->adapter, addr);
	}
	EXPORT_SYMBOL_GPL(i2c_new_secondary_device);

The above should work with both DT and ACPI so I'm OK with the current
patch. We can add ACPI parts later when needed.

Srinivas, do you think this works with the sensor stuff?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
