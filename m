From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Poulsbo I2C - /dev/i2c not seen when loading i2c-dev
Date: Wed, 6 Apr 2011 19:20:59 +0200
Message-ID: <20110406192059.369c3143@endymion.delvare>
References: <fb407773c6a76f3ffef06ff357df2118.squirrel@host171.canaca.com>
	<20110401121027.49ce012b@endymion.delvare>
	<b9ff3e86cbf2aa2c34f614adf80e7ffb.squirrel@host171.canaca.com>
	<22a6003c213a91452d2a7312e4e5ad32.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <22a6003c213a91452d2a7312e4e5ad32.squirrel-N82HvsEaY4mscnXkh+DeetBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 5 Apr 2011 16:34:04 -0400, simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org wrote:
> > Thanks for the suggestion, unfortunately there is an issue with lpc_sch
> > loading, and error is reported via dmesg.
> > --
> > [  403.809826] ACPI: resource (null) [io  0x0480-0x04bf] conflicts with
> > ACPI region PHO_ [io 0x4bc-0x4bc]
> > [  403.809834] ACPI: If an ACPI driver is available for this device, you
> > should use it instead of the native driver
> > [  403.809921] lpc_sch: probe of 0000:00:1f.0 failed with error -16
> > --
> 
> I got a bit further, if I boot the device with the 'acpi=off' kernel
> option then I can modprobe both lpc_sch and i2c_dev, at which point
> i2c-detect works fine.

As expected. but acpi=off is a little harsh. acpi_enforce_resources=no
would work too, and is less risky.

> 
> This (and the error above) suggests that something else related to ACPI is
> grabbing the interface and blocking it from use for userland i2c, hence
> "16      /* Device or resource busy */" error.
> 
> This is a prototype board, the only thing on the SMBus/I2C is a PCI-E
> socket, which shouldn't be required by ACPI. I've attached the output of
> dmidecode and acpidump, in case they contain any clues..

>From your ACPI DSDT table:

    OperationRegion (PHO, SystemIO, 0x04BC, One)
    Field (PHO, ByteAcc, NoLock, Preserve)
    {
            ,   1, 
            ,   1, 
        GPB2,   1, 
            ,   1, 
            ,   1, 
            ,   1, 
            ,   1, 
                Offset (0x01)
    }

GPB2 is used later:

    Scope (_GPE)
    {
        Method (_L0E, 0, NotSerialized)
        {
            If (PBTS)
            {
                Store (One, GPB2)
                Notify (\_SB.PWRB, 0x80)
                Store (One, PBTS)
            }
        }
    }

I don't see _L0E being called anywhere, but maybe it's a standard name
called by generic acpi subsystem code. I have no clue what this code is
doing... Maybe twiddling a GPIO bit when entering some low power mode?

Anyway, this all means two things:
* As I seem to understand that the board is developed by your own
  company, you should ask the BIOS developers what they are up to. They
  should be able to tell you if the ACPI code above is intended and
  needed, or if it can be dropped (together with the PHO operation
  region.)
* The lpc_sch driver fails to load if _any_ if its subdevices fail to
  register. In your case, it seems that the gpio subdevice couldn't get
  registered, but maybe the smbus subdevice registration would have
  succeeded. I think this behavior of the mfd subsystem is discussable.
  I would expect mfd_add_devices to register as many devices as
  possible. If this isn't going to change then I suggest changing the
  lpc_sch driver so that it registers subdevices individually and only
  fails if no subdevice could be registered.

-- 
Jean Delvare
