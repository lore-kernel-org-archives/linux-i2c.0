From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: Add generic support passing secondary devices
 addresses
Date: Mon, 22 Sep 2014 16:45:35 +0300
Message-ID: <20140922134535.GZ1786@lahna.fi.intel.com>
References: <1409925739-28188-1-git-send-email-jean-michel.hautbois@vodalys.com>
 <20140922104555.GQ1786@lahna.fi.intel.com>
 <542023C8.8080802@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <542023C8.8080802-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 22, 2014 at 03:27:36PM +0200, Lars-Peter Clausen wrote:
> On 09/22/2014 12:45 PM, Mika Westerberg wrote:
> >On Fri, Sep 05, 2014 at 04:02:19PM +0200, Jean-Michel Hautbois wrote:
> >>Some I2C devices have multiple addresses assigned, for example each address
> >>corresponding to a different internal register map page of the device.
> >>So far drivers which need support for this have handled this with a driver
> >>specific and non-generic implementation, e.g. passing the additional address
> >>via platform data.
> >>
> >>This patch provides a new helper function called i2c_new_secondary_device()
> >>which is intended to provide a generic way to get the secondary address
> >>as well as instantiate a struct i2c_client for the secondary address.
> >>
> >>The function expects a pointer to the primary i2c_client, a name
> >>for the secondary address and an optional default address. The name is used
> >>as a handle to specify which secondary address to get.
> >>
> >>The default address is used as a fallback in case no secondary address
> >>was explicitly specified. In case no secondary address and no default
> >>address were specified the function returns NULL.
> >>
> >>For now the function only supports look-up of the secondary address
> >>from devicetree, but it can be extended in the future
> >>to for example support board files and/or ACPI.
> >>
> >>Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois-B+Q8N6RmIDZBDgjK7y7TUQ@public.gmane.org>
> >
> >Sorry, just noticed this one.
> >
> >Srinivas (CC'd) and I did similar patch series here:
> >
> >http://patchwork.ozlabs.org/patch/338342/

Sorry I gave wrong link. That one is older version.

Here is the current:

http://patchwork.ozlabs.org/patch/386409/
http://patchwork.ozlabs.org/patch/386410/

> >
> >We should probably collaborate on this one to get both DT and ACPI
> >supported.
> 
> Yes. The idea was to keep the interface of the API generic so it can be used
> by ACPI or other device topology description mechanisms as well.
> 
> But it looks as if the ACPI case is a bit more complex and we may need a
> revision of the API. How for example in the ACPI case do you know which
> address is which, when different parts of a chip are addressed using
> different addresses?

Unfortunately there is no way in ACPI 5.0 to find out which is which. So
we trust the ordering of I2cSerialBus() resources. Even that has been
problematic because some vendors then list things like SMBus ARA
addresses there in random order :-(

Our API has following signature:

int i2c_address_by_index(struct i2c_client *client, int index,
			 struct i2c_board_info *info,
			 struct i2c_adapter **adapter)

and we use index to find out which address to use.

Note also that in ACPI it is possible that the I2cSerialBus() resource
points to another I2C host controller, so we need to have 'adapter'
parameter as well.
