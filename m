From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/5] i2c-i801: Add Device IDs for Intel Wellsburg PCH
Date: Sun, 10 Feb 2013 19:38:45 +0100
Message-ID: <20130210183845.GC12760@nekote.pengutronix.de>
References: <1360373535-2055-1-git-send-email-james.d.ralston@intel.com>
 <20130209200010.1b18fdb3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130209200010.1b18fdb3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


> Seth recently sent a patch adding IDs for the Avoton:
> http://marc.info/?l=linux-kernel&m=135959209218860&w=2
> 
> Your patch conflicts with his. Please rebase on top of Seth's patch, so
> that both patches can be applied in sequence.

Yes, please.

> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > (...)
> > @@ -165,6 +166,7 @@
> >  #define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS	0x2330
> >  #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
> >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
> > +#define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS	0x8d22
> >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS	0x9c22
> 
> Please keep sorted by ID.

Hum? This table looks sorted by numbers to me, so OK.
