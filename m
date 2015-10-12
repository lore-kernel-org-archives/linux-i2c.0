From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH 2/2] i2c: add ACPI support for I2C mux ports
Date: Mon, 12 Oct 2015 11:32:31 -0700
Message-ID: <20151012183231.GB5909@cumulusnetworks.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-3-git-send-email-dustin@cumulusnetworks.com>
 <20151012105023.GX1506@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33919 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbJLScd (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 14:32:33 -0400
Received: by padhy16 with SMTP id hy16so160264871pad.1
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2015 11:32:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151012105023.GX1506@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net

Hi Mika,

On Mon Oct 12 13:50, Mika Westerberg wrote:
> On Fri, Oct 09, 2015 at 05:41:47PM -0700, Dustin Byford wrote:
> > Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
> > device property compatible string match) enumerating I2C client devices
> > connected through a I2C mux device requires a little extra work.
> > 
> > This change implements a method for describing an I2C device hierarchy that
> > includes mux devices by using an ACPI Device() for each mux channel along
> > with an _ADR to set the channel number for the device.  See
> > Documentation/acpi/i2c-muxes.txt for a simple example.
> > 
> > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> > ---
> >  Documentation/acpi/i2c-muxes.txt | 58 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/i2c/i2c-core.c           | 18 +++++++++++--
> >  drivers/i2c/i2c-mux.c            |  8 ++++++
> >  3 files changed, 82 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/acpi/i2c-muxes.txt
> > 
> > diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
> > new file mode 100644
> > index 0000000..efdcf0d
> > --- /dev/null
> > +++ b/Documentation/acpi/i2c-muxes.txt
> > @@ -0,0 +1,58 @@
> > +ACPI I2C Muxes
> > +--------------
> > +
> > +Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
> > +Device() scope per mux channel.
> > +
> > +Consider this topology:
> > +
> > ++------+   +------+
> > +| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
> > +|      |   | 0x70 |--CH01--> i2c client B (0x50)
> > ++------+   +------+
> > +
> > +which corresponds to the following ASL:
> > +
> > +Device(SMB1)
> > +{
> > +    Name (_HID, ...)
> > +    Device(MUX0)
> 
> Nit: please be consistent:
> 
> 	Name ()
> 	Device ()

Sure thing.

> > +    {
> > +        Name (_HID, ...)
> > +        Name (_CRS, ResourceTemplate () {
> > +            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> > +                          AddressingMode7Bit, "^SMB1", 0x00,
> > +                          ResourceConsumer,,)
> > +        }
> > +
> > +        Device(CH00)
> > +        {
> > +            Name (_ADR, 0)
> > +
> > +            Device(CLIA)
> > +            {
> > +                Name (_HID, ...)
> > +                Name (_CRS, ResourceTemplate () {
> > +                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> > +                                  AddressingMode7Bit, "^CH00", 0x00,
> > +                                  ResourceConsumer,,)
> > +                }
> > +            }
> > +        }
> > +
> > +        Device(CH01)
> > +        {
> > +            Name (_ADR, 1)
> > +
> > +            Device(CLIB)
> > +            {
> > +                Name (_HID, ...)
> > +                Name (_CRS, ResourceTemplate () {
> > +                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> > +                                  AddressingMode7Bit, "^CH01", 0x00,
> > +                                  ResourceConsumer,,)
> > +                }
> > +            }
> > +        }
> > +    }
> > +}
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 3a4c54e..a2de010 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -156,7 +156,10 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
> >  	info.fwnode = acpi_fwnode_handle(adev);
> >  
> >  	memset(&lookup, 0, sizeof(lookup));
> > -	lookup.adapter_handle = ACPI_HANDLE(adapter->dev.parent);
> > +	if (i2c_parent_is_i2c_adapter(adapter))
> > +		lookup.adapter_handle = ACPI_HANDLE(&adapter->dev);
> > +	else
> > +		lookup.adapter_handle = ACPI_HANDLE(adapter->dev.parent);
> 
> So I don't really like this.

I don't love it either.

> Isn't there any other way to figure out the right companion for the
> device?

I've been trying to consider the options, perhaps you can help my
understanding.  Using the i801 driver as an example, the device is PCI
and the companion is associated with the PCI dev.  The driver creates
another device for the I2C interface (parented by the PCI device) by
calling i2c_add_adapter().  The I2C dev has no ACPI companion.

In the case of an I2C mux port, I've used acpi_preset_companion() to
associate each mux port I2C device with a ACPI node.  Unlike the i801,
which has a single port, these companions are one per channel.  It's not
an option to associate them all with the I2C mux device.

It seems like the options are to:

a) Special case the I2C mux to use the per-port I2C companions as I've
   done here.

b) Move (or copy?) the companion from the i801 PCI dev to the i801 I2C
   dev.  Then we would always look in the same place for the companion.
   I think this approach has some advantages, at least it would make
   more sense if an I2C PCI controller had more than one I2C port, but
   I'm not sure that case exists.  I didn't pursue this approach because
   it was specifically avoided in change b34bb1ee.


What do you think?  I'd be happy to try out any ideas you have.

Thanks,

		--Dustin
