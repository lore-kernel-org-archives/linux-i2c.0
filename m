From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [RFC v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Tue, 29 Sep 2015 16:19:12 -0700
Message-ID: <20150929231912.GA7913@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <20150817120305.GB1552@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35623 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbbI2XTO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Sep 2015 19:19:14 -0400
Received: by pacfv12 with SMTP id fv12so19686876pac.2
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2015 16:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150817120305.GB1552@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-i2c@vger.kernel.org

Hi Mika,

On Mon Aug 17 15:03, Mika Westerberg wrote:
> I think the current code in I2C core is not actually doing the right
> thing according the ACPI spec at least. To my understanding you can have
> device with I2cSerialBus resource _anywhere_ in the namespace, not just
> directly below the host controller. It's the ResourceSource attribute
> that tells the corresponding host controller.
> 
> I wonder if it helps if we scan the whole namespace for devices with
> I2cSerialBus that matches the just registered adapter? Something like
> the patch below.

I've been working with the patch you suggested below.

> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index c83e4d13cfc5..2a309d27421a 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c

...

>  static void acpi_i2c_register_devices(struct i2c_adapter *adap)
>  {
> -     acpi_handle handle;
>       acpi_status status;
>  
> -     if (!adap->dev.parent)
> -             return;
> -
> -     handle = ACPI_HANDLE(adap->dev.parent);
> -     if (!handle)
> +     if (!adap->dev.parent || !has_acpi_companion(adap->dev.parent))
>               return;
>  
> -     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +                                  ACPI_I2C_MAX_SCAN_DEPTH,
>                                    acpi_i2c_add_device, NULL,
>                                    adap, NULL);

On my systems (which admittedly all define their i2c clients below the
controller) this works as expected, i.e. there's no change in behavior.
As far as I can tell it more accurately implements the spec.


However, it doesn't quite solve my problem.  When
acpi_i2c_register_devices(adap) is called on the "virtual" controller
that is created for an i2c mux channel, the adap->dev.parent (set to the
parent i2c bus for the mux) does not have an acpi companion.  That
ultimately causes acpi_i2c_add_device() to never find a match.

I'll recap a bit since it's been a while and I've learned a few things
that might affect the discussion.  For now, I'll focus on my proposed
ASL for an I2C mux using device properties.

Lets say we have i2c hardware attached like this:

i801 controller (PCI)
   pca9548 8-channel mux (address 0x70)
       lm75 temperature sensor (channel 0 on the mux with address 0x50)

I think this is a sensible way to represent it:

Device (MUX0) {
    Name (_ADR, 0x70)
    Name (_HID, "PRP0001")
    Name (_CRS, ResourceTemplate()
    {
        I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
                      AddressingMode7Bit, "^^SMB2", 0x00,
                      ResourceConsumer,,)
    })
    Name (_DSD, Package ()
    {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package (2) { "compatible", "nxp,pca9548" },
        }
    })

    // MUX channel 0
    Device (CH00) {
        Name (_ADR, 0x0)

        Device (TMP0) {
            Name (_ADR, 0x50)
            Name (_CRS, ResourceTemplate()
            {
                I2cSerialBus (0x60, ControllerInitiated, I2C_SPEED,
                              AddressingMode7Bit, "^CH00", 0x00,
                              ResourceConsumer,,)
            })
            Name (_DSD, Package ()
            {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package (2) { "compatible", "national,lm75" },
                }
            })
        }
    }
}

The new thing here is using _ADR to treat each mux channel as a device
and referencing those devices elsewhere (CH00).  I arrived at this
because it seems to fit the ACPI model reasonably well* and it's easy to
implement (just like in other callers to acpi_preset_companion())

* by reasonably well, I think it's clear and works naturally but this
use of _ADR isn't explicitly defined in the spec [ACPI 6, Table 6-168
(page 278)]

Hopefully the spec ambiguity isn't too much effort to clarify.  I think
it's a good change.  But, perhaps it's unnecessary.  Any feedback on
whether this ASL seem like the right way to go for device property i2c
muxes?

If not, is there an acceptable alternative?  I wonder how muxes are
handled otherwise?  Hopefully not ASL methods :)

thanks,

                --Dustin
