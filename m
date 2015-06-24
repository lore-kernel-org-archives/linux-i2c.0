From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use enable on resume instead
 initialization
Date: Wed, 24 Jun 2015 14:27:23 +0300
Message-ID: <20150624112723.GE827@lahna.fi.intel.com>
References: <1433785828-4100-1-git-send-email-lucas.de.marchi@gmail.com>
 <20150609085146.GD1478@lahna.fi.intel.com>
 <CAKi4VAJwD45VbWuCHegfkB-tbgvgza52-cgVNF4AxF8NCuYyRQ@mail.gmail.com>
 <20150610070722.GM1478@lahna.fi.intel.com>
 <OF847FFF39.1FF5F96A-ONC1257E60.00506AFD-C1257E60.0052A8CE@LocalDomain>
 <OFB47A681B.5488F019-ONC1257E6D.005A6CD2-C1257E6D.005BD52F@alitech.com>
 <CAKi4VA+t3d-XoqDiL9ez+9qDR_ndgGnAOhkpZsJyJ2tMjfCYLA@mail.gmail.com>
 <OFB918064C.F72245F4-ONC1257E6E.00287EC7-C1257E6E.00299EF2@alitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <OFB918064C.F72245F4-ONC1257E6E.00287EC7-C1257E6E.00299EF2-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org
Cc: Lucas De Marchi <lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Fabio Mello <fabio.mello-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 24, 2015 at 09:36:43AM +0200, christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org wrote:
> Dear Lucas,
> 
> Lucas De Marchi <lucas.de.marchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote on 23.06.2015 19:02:03:
> > On Tue, Jun 23, 2015 at 1:45 PM,  <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org> wrote:
> > > Hello,
> > >
> > > Christian Ruppert/ALi_GVA/ALi wrote on 10.06.2015 17:05:16:
> > [...]
> > > The result is not very encouraging: Out of five (identical) designware 
> i2c
> > > controllers we have on my test SOC, the first one initialises properly 
> but
> > > the second one gets stuck in the famous irq loop right away when the
> > > module is enabled in i2c_dw_init. The system never gets around to try
> > 
> > Are you using the pci or platform driver?  I noticed yesterday the pci
> > version is failing here with a NULL pointer dereference.
> 
> The test was performed with the platform driver (instantiated through 
> device tree).
> I just re-checked and the ultimate problem which hangs/kills the system in 
> my case is the IRQ loop.
> I haven't observed any NULL pointer dereferences on the road.

Thanks Christian for testing.

Since the patch causes problems on your hardware, I don't think it is
good idea to merge it.
