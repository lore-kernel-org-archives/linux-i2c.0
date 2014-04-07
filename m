From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] i2c-designware-pci: Add Haswell ULT device support
Date: Mon, 7 Apr 2014 12:09:00 +0300
Message-ID: <20140407090859.GH19349@intel.com>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
 <1382367944-3005-1-git-send-email-bleung@chromium.org>
 <20131021161428.GI3521@intel.com>
 <20140406135424.GA1840@node.dhcp.inet.fi>
 <20140406153104.GA2609@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140406153104.GA2609@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "Kirill A. Shutemov" <kirill-oKw7cIdHH8eLwutG50LtGA@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Apr 06, 2014 at 05:31:04PM +0200, Wolfram Sang wrote:
> On Sun, Apr 06, 2014 at 04:54:24PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Oct 21, 2013 at 07:14:28PM +0300, Mika Westerberg wrote:
> > > On Mon, Oct 21, 2013 at 08:05:42AM -0700, Benson Leung wrote:
> > > > Fixed 25Mhz clock instead of 100Mhz clock in 1/2 and a warning in 2/2.
> > > > 
> > > > [PATCH v2 1/2] i2c-designware-pci: Add Haswell ULT device IDs
> > > > [PATCH v2 2/2] i2c-designware-pci: Index Haswell ULT bus names from 0
> > > 
> > > Both patches,
> > > 
> > > Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > Guys, any idea why these patches have not upstreamed yet?
> 
> Yes, read the discussion of V1 of these patches. AFAIU the patches are
> obsolete.

Well, we still don't have HSW PCI Ids in the driver.

Benson, are you still planning to send a patch to add those? I can add them
as well, if you are fine with that.
