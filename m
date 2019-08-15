From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] hwmon/ltc2990: Generalise DT to fwnode support
Date: Thu, 15 Aug 2019 15:43:41 -0700
Message-ID: <20190815224341.GA12420@roeck-us.net>
References: <20190815125802.16500-1-max@enpas.org>
 <20190815125802.16500-2-max@enpas.org>
 <6920f2da-3139-6fc8-b02c-3678cc17912e@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6920f2da-3139-6fc8-b02c-3678cc17912e@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 16, 2019 at 12:19:42AM +0200, Max Staudt wrote:
> On 08/15/2019 02:58 PM, Max Staudt wrote:
> > -	if (of_node) {
> > -		ret = of_property_read_u32_array(of_node, "lltc,meas-mode",
> > -						 data->mode, 2);
> > +	if (i2c->dev.of_node || i2c->dev.fwnode) {
> 
> One more idea, would it be better here to do the following?
> 
> 	if (device_property_present(i2c->dev, "lltc,meas-mode")) {
> 		ret = of_property_read_u32_array(of_node, "lltc,meas-mode",
> 						 data->mode, 2);
> 	}
> 
> I'm happy to prepare a patch if you wish to have this in - just let me know whether it should be on top of the last one, or instead of it.

That would be semantically different. The property is currently mandatory.
The above code would make it optional. This might work:

	if (dev_fwnode(&i2c->dev)) {
		ret = device_property_read_u32_array(...);
		...
	}

Feel free to send another version of your patch.

Thanks,
Guenter
