From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Wed, 30 Sep 2015 14:52:28 +0200
Message-ID: <2521626.jxElES8O1e@vostro.rjw.lan>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com> <20150929231912.GA7913@cumulusnetworks.com> <20150930094336.GF1551@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54831 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932089AbbI3MYI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Sep 2015 08:24:08 -0400
In-Reply-To: <20150930094336.GF1551@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Dustin Byford <dustin@cumulusnetworks.com>
Cc: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org

On Wednesday, September 30, 2015 12:43:36 PM Mika Westerberg wrote:
> On Tue, Sep 29, 2015 at 04:19:12PM -0700, Dustin Byford wrote:
> > Hi Mika,
> > 
> > On Mon Aug 17 15:03, Mika Westerberg wrote:
> > > I think the current code in I2C core is not actually doing the right
> > > thing according the ACPI spec at least. To my understanding you can have
> > > device with I2cSerialBus resource _anywhere_ in the namespace, not just
> > > directly below the host controller. It's the ResourceSource attribute
> > > that tells the corresponding host controller.
> > > 
> > > I wonder if it helps if we scan the whole namespace for devices with
> > > I2cSerialBus that matches the just registered adapter? Something like
> > > the patch below.
> > 
> > I've been working with the patch you suggested below.
> > 
> > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > index c83e4d13cfc5..2a309d27421a 100644
> > > --- a/drivers/i2c/i2c-core.c
> > > +++ b/drivers/i2c/i2c-core.c
> > 
> > ...
> > 
> > >  static void acpi_i2c_register_devices(struct i2c_adapter *adap)
> > >  {
> > > -     acpi_handle handle;
> > >       acpi_status status;
> > >  
> > > -     if (!adap->dev.parent)
> > > -             return;
> > > -
> > > -     handle = ACPI_HANDLE(adap->dev.parent);
> > > -     if (!handle)
> > > +     if (!adap->dev.parent || !has_acpi_companion(adap->dev.parent))
> > >               return;
> > >  
> > > -     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> > > +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> > > +                                  ACPI_I2C_MAX_SCAN_DEPTH,
> > >                                    acpi_i2c_add_device, NULL,
> > >                                    adap, NULL);
> > 
> > On my systems (which admittedly all define their i2c clients below the
> > controller) this works as expected, i.e. there's no change in behavior.
> > As far as I can tell it more accurately implements the spec.
> > 
> > 
> > However, it doesn't quite solve my problem.  When
> > acpi_i2c_register_devices(adap) is called on the "virtual" controller
> > that is created for an i2c mux channel, the adap->dev.parent (set to the
> > parent i2c bus for the mux) does not have an acpi companion.  That
> > ultimately causes acpi_i2c_add_device() to never find a match.
> > 
> > I'll recap a bit since it's been a while and I've learned a few things
> > that might affect the discussion.  For now, I'll focus on my proposed
> > ASL for an I2C mux using device properties.
> > 
> > Lets say we have i2c hardware attached like this:
> > 
> > i801 controller (PCI)
> >    pca9548 8-channel mux (address 0x70)
> >        lm75 temperature sensor (channel 0 on the mux with address 0x50)
> > 
> > I think this is a sensible way to represent it:
> > 
> > Device (MUX0) {
> >     Name (_ADR, 0x70)
> 
> This..
> 
> >     Name (_HID, "PRP0001")
> >     Name (_CRS, ResourceTemplate()
> >     {
> >         I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> >                       AddressingMode7Bit, "^^SMB2", 0x00,
> >                       ResourceConsumer,,)
> >     })
> >     Name (_DSD, Package ()
> >     {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package () {
> >             Package (2) { "compatible", "nxp,pca9548" },
> >         }
> >     })
> > 
> >     // MUX channel 0
> >     Device (CH00) {
> >         Name (_ADR, 0x0)
> > 
> >         Device (TMP0) {
> >             Name (_ADR, 0x50)
> 
> ... and this are not needed. I2cSerialBus already contains the address.
> 
> Also I think you need to have "PRP0001" here as well.

The idea is to use _ADR kind of instead of "PRP0001" to express the "you
don't need a driver for this" idea AFAICS.

> >             Name (_CRS, ResourceTemplate()
> >             {
> >                 I2cSerialBus (0x60, ControllerInitiated, I2C_SPEED,
> >                               AddressingMode7Bit, "^CH00", 0x00,
> >                               ResourceConsumer,,)
> >             })
> >             Name (_DSD, Package ()
> >             {
> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                 Package () {
> >                     Package (2) { "compatible", "national,lm75" },
> >                 }
> >             })
> >         }
> >     }
> > }
> > 
> > The new thing here is using _ADR to treat each mux channel as a device
> > and referencing those devices elsewhere (CH00).  I arrived at this
> > because it seems to fit the ACPI model reasonably well* and it's easy to
> > implement (just like in other callers to acpi_preset_companion())
> > 
> > * by reasonably well, I think it's clear and works naturally but this
> > use of _ADR isn't explicitly defined in the spec [ACPI 6, Table 6-168
> > (page 278)]

Yes, it is a gray area, but I think it is reasonable.

> > Hopefully the spec ambiguity isn't too much effort to clarify.  I think
> > it's a good change.  But, perhaps it's unnecessary.  Any feedback on
> > whether this ASL seem like the right way to go for device property i2c
> > muxes?
> 
> Well to me your ASL looks reasonable. Usage of _ADR to specify mux
> channel seems natural and follows other buses which have an entry in
> that table. I don't know if it is forbidden to invent this kind of
> things that are not explicitly mentioned in the spec, though.
> 
> > If not, is there an acceptable alternative?  I wonder how muxes are
> > handled otherwise?  Hopefully not ASL methods :)
> 
> I cannot think of any better way. I have never seen ACPI DSDT/SSDT
> containing I2C mux before.

Me neither.

Thanks,
Rafael
