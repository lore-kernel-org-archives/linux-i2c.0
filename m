From: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/3] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Fri, 23 Jan 2015 10:56:51 -0800
Message-ID: <20150123185651.GA1739@psi-dev26.jf.intel.com>
References: <1421937869-28376-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150122190301.GA15297@psi-dev26.jf.intel.com>
 <20150122191758.GB14880@katana>
 <20150122222712.GA3678@psi-dev26.jf.intel.com>
 <1422014249.31903.159.camel@linux.intel.com>
 <20150123175044.GA14183@psi-dev26.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150123175044.GA14183-UmZa8NLUsbhHELxPJs4m+1DQ4js95KgL@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 23, 2015 at 09:50:44AM -0800, David Cohen wrote:
> On Fri, Jan 23, 2015 at 01:57:29PM +0200, Andy Shevchenko wrote:
> > On Thu, 2015-01-22 at 14:27 -0800, David Cohen wrote:
> > > On Thu, Jan 22, 2015 at 08:17:58PM +0100, Wolfram Sang wrote:
> > > > 
> > > > > Since you're doing this rework, could you remove moorestown for good?
> > > > > It's no longer supported as one of intel mid's platform anyway.
> > > > 
> > > > If support for that platform is not broken anyhow, I'd say let's keep
> > > > it. There still might be users out there...
> > > > 
> > > 
> > > It actually is. When Medfield, Clover Trail and Merrifield support was
> > > merged, Moorefield support became broken with no interest from anybody
> > > to fix it. It's time now to remove all of its code :)
> > 
> > You perhaps meant Moorestown.
> 
> Oops. Sorry for the typo. Yes, I meant Morrestown :)

Grrr... Moorestown :)

> 
> Br, David
