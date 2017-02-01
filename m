From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Add support for Intel Gemini Lake
Date: Wed, 1 Feb 2017 12:50:48 +0200
Message-ID: <20170201105048.GD17297@lahna.fi.intel.com>
References: <20170131101733.117705-1-mika.westerberg@linux.intel.com>
 <20170201113832.647a1f3e@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:55046 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdBAKu6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Feb 2017 05:50:58 -0500
Content-Disposition: inline
In-Reply-To: <20170201113832.647a1f3e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org

On Wed, Feb 01, 2017 at 11:38:32AM +0100, Jean Delvare wrote:
> Hi Mika,
> 
> On Tue, 31 Jan 2017 13:17:33 +0300, Mika Westerberg wrote:
> > Intel Gemini Lake has the same SMBus host controller than Intel Broxton.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/i2c/busses/i2c-i801.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Please also update drivers/i2c/busses/Kconfig and
> Documentation/i2c/busses/i2c-i801.

OK.

> Also please submit the new device to http://pci-ids.ucw.cz/read/PC/8086.

I will but it need to wait a bit since we don't yet have "marketing"
name for Gemini Lake. It is on my list so I'll do that immediately when
I know the right name.

> > 
> > diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> > index e242db43774b..6484fa6dbb84 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -65,6 +65,7 @@
> >   * Lewisburg (PCH)		0xa1a3	32	hard	yes	yes	yes
> >   * Lewisburg Supersku (PCH)	0xa223	32	hard	yes	yes	yes
> >   * Kaby Lake PCH-H (PCH)	0xa2a3	32	hard	yes	yes	yes
> > + * Gemini Lake (SOC)		0x31d4	32	hard	yes	yes	yes
> >   *
> >   * Features supported by this driver:
> >   * Software PEC				no
> > @@ -213,6 +214,7 @@
> >  #define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
> >  #define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS		0x2330
> >  #define PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS		0x23b0
> > +#define PCI_DEVICE_ID_INTEL_GEMINILAKE_SMBUS		0x31d4
> >  #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS		0x3b30
> >  #define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
> >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS		0x8c22
> > @@ -1012,6 +1014,7 @@ static const struct pci_device_id i801_ids[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS1) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS2) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GEMINILAKE_SMBUS) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> 
> Thanks,
> -- 
> Jean Delvare
> SUSE L3 Support
