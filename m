From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-i801: Add PCI idents for Sandy Bridge SMBus
 controllers
Date: Sat, 30 Oct 2010 19:15:50 -0400
Message-ID: <1288480550.4570.5.camel@macbook.infradead.org>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
	 <alpine.LFD.2.00.1010301448240.7306@dwoodhou-mobl2.ger.corp.intel.com>
	 <20101030183635.4899246f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101030183635.4899246f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 2010-10-30 at 18:36 +0200, Jean Delvare wrote:
> As a side note, I really don't get the point of using 4 different PCI
> device IDs for exactly the same device. Intel should really start to
> worry about their numbering space if they keep attributing IDs when
> they don't need to. 16 bit is fast to exhaust...

Don't we keep buying companies that have their own PCI vendor ID? :)

I certainly agree about the 0x1d7[012] IDs -- those seem fairly
gratuitous. The main one (0x1d22) lacks slave mode though, so it is
different from the others. Not that we care right now.

> > 
> >     Features supported by this driver:
> >     Software PEC                     no
> > @@ -127,6 +131,11 @@
> >   				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
> >   				 SMBHSTSTS_INTR)
> > 
> > +#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_PCH	0x1d22
> > +#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA1	0x1d70
> > +#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA2	0x1d71
> > +#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA3	0x1d72
> > +
> 
> These should go to pci_ids.h together with all other similar defines.

 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.


> >   struct i801_priv {
> >   	struct i2c_adapter adapter;
> >   	unsigned long smba;
> > @@ -602,6 +611,10 @@ static const struct pci_device_id i801_ids[] = {
> >   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
> >   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS) },
> >   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_PCH) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA1) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA2) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA3) },
> >   	{ 0, }
> >   };
> > 
> 
> You also have to list the new device in drivers/i2c/busses/Kconfig and
> Documentation/i2c/busses/i2c-i801.

Will update.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation
