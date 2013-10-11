From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Sat, 12 Oct 2013 00:16:02 +0200
Message-ID: <2393462.4JRAMNeigd@vostro.rjw.lan>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com> <20131011144946.GS3521@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131011144946.GS3521-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, October 11, 2013 05:49:46 PM Mika Westerberg wrote:
> +Rafael
> 
> On Thu, Oct 10, 2013 at 05:17:49PM +0300, Jarkko Nikula wrote:
> > There is a minor fault about ACPI enumerated I2C devices with their modalias
> > attribute. Now modalias is set by device instance not by hardware ID.
> > For example "i2c:INTABCD:00", "i2c:INTABCD:01" etc.
> 
> I think that this is intentional. We don't want that the i2c modalias
> matches with the ACPI device (like with the i2c:INTABCD). Instead use ACPI
> IDs that are added to the driver to match with the ACPI device.

Well, I'm not really sure this was intentional, but I wonder how other bus
types work in that respect?

> > This means each device instance gets different modalias which does match
> > with generated modules.alias. Currently this is not problem as matching can
> > happen also with "acpi:INTABCD" modalias.
> > 
> > Fix this by using ACPI hardware ID.
> > 
> > Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> > Generated on top of v3.12-rc4-29-g0e7a3ed.
> > ---
> >  drivers/i2c/i2c-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 29d3f04..6dd0c53 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1111,7 +1111,7 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
> >  	if (ret < 0 || !info.addr)
> >  		return AE_OK;
> >  
> > -	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
> > +	strlcpy(info.type, acpi_device_hid(adev), sizeof(info.type));
> >  	if (!i2c_new_device(adapter, &info)) {
> >  		dev_err(&adapter->dev,
> >  			"failed to add I2C device %s from ACPI\n",
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
