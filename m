From: "Yates, Alexandra" <alexandra.yates@intel.com>
Subject: RE: [PATCH] i2c: ismt: Add Intel DNV PCI ID
Date: Fri, 19 Feb 2016 17:24:18 +0000
Message-ID: <5B3EBE90AD716C428A6F03AC478C5406B6270015@ORSMSX105.amr.corp.intel.com>
References: <1455807273-133516-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160219083917.GE1491@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3083 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424899AbcBSRYU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 19 Feb 2016 12:24:20 -0500
In-Reply-To: <20160219083917.GE1491@lahna.fi.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "Heasley, Seth" <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Mika, 

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Friday, February 19, 2016 12:39 AM
> To: Wolfram Sang <wsa@the-dreams.de>
> Cc: Heasley, Seth <seth.heasley@intel.com>; Neil Horman
> <nhorman@tuxdriver.com>; linux-i2c@vger.kernel.org; Yates, Alexandra
> <alexandra.yates@intel.com>
> Subject: Re: [PATCH] i2c: ismt: Add Intel DNV PCI ID
> 
> On Thu, Feb 18, 2016 at 04:54:33PM +0200, Mika Westerberg wrote:
> > Intel DNV has the same iSMT SMBus host controller than Intel Avoton.
> > Add DNV PCI ID to the list of supported devices.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Wolfram,
> 
> Please do not yet apply this patch. It seems to have same PCI ID that
> Alexandra (Cc'd) added to i2c-i801.c.
> 
> Alexandra, are you sure that the PCI ID you added for DNV is actually
> compatible with i2c-i801.c?
> 


I go this device ID from the External Design Specification (EDS) document for DNV.  The EDS lists this as the SMBus Controller as follows: 
 Bus: 0 Device:18 Function:0 Device ID: 0x19AC Description:  SMBus Controller - Host  

In the same document there is a list of PCI IDs. 

> > ---
> >  drivers/i2c/busses/i2c-ismt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-ismt.c
> > b/drivers/i2c/busses/i2c-ismt.c index 7ba795b24e75..24c48e899a22
> > 100644
> > --- a/drivers/i2c/busses/i2c-ismt.c
> > +++ b/drivers/i2c/busses/i2c-ismt.c
> > @@ -76,6 +76,7 @@
> >  #define PCI_DEVICE_ID_INTEL_S1200_SMT0	0x0c59
> >  #define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
> >  #define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
> > +#define PCI_DEVICE_ID_INTEL_DNV_SMT	0x19ac
> >
> >  #define ISMT_DESC_ENTRIES	2	/* number of descriptor
> entries */
> >  #define ISMT_MAX_RETRIES	3	/* number of SMBus retries to
> attempt */
> > @@ -181,6 +182,7 @@ static const struct pci_device_id ismt_ids[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_S1200_SMT0) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_S1200_SMT1) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCI_DEVICE_ID_INTEL_DNV_SMT) },
> >  	{ 0, }
> >  };
> >
> > --
> > 2.7.0
Thank you, 
Alexandra. 
