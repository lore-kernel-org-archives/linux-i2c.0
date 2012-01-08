From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c: convert drivers/i2c/* to use  
 module_platform_driver()
Date: Sun, 8 Jan 2012 11:36:56 +0100
Message-ID: <20120108113656.70c6fcd0@endymion.delvare>
References: <1322439206.2709.2.camel@phoenix>
	<20111128092721.15ac7b7d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111128092721.15ac7b7d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 28 Nov 2011 09:27:21 +0100, Jean Delvare wrote:
> On Mon, 28 Nov 2011 08:13:26 +0800, Axel Lin wrote:
> > This patch converts the drivers in drivers/i2c/* to use the
> 
> Now drivers/i2c/busses/* even.
> 
> > module_platform_driver() macro which makes the code smaller and a bit
> > simpler.
> > 
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> > Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
> > Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> > Cc: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> > Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Acked-by: Jochen Friedrich<jochen-NIgtFMG+Po8@public.gmane.org>
> > Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-at91.c         |   17 ++---------------
> >  drivers/i2c/busses/i2c-au1550.c       |   13 +------------
> >  drivers/i2c/busses/i2c-cpm.c          |   13 +------------
> >  drivers/i2c/busses/i2c-highlander.c   |   13 +------------
> >  drivers/i2c/busses/i2c-ibm_iic.c      |   13 +------------
> >  drivers/i2c/busses/i2c-iop3xx.c       |   16 +---------------
> >  drivers/i2c/busses/i2c-isch.c         |   13 +------------
> >  drivers/i2c/busses/i2c-ixp2000.c      |   13 +------------
> >  drivers/i2c/busses/i2c-mpc.c          |   13 +------------
> >  drivers/i2c/busses/i2c-mv64xxx.c      |   15 +--------------
> >  drivers/i2c/busses/i2c-ocores.c       |   17 ++---------------
> >  drivers/i2c/busses/i2c-octeon.c       |   16 +---------------
> >  drivers/i2c/busses/i2c-pca-platform.c |   14 +-------------
> >  drivers/i2c/busses/i2c-pmcmsp.c       |   17 ++---------------
> >  drivers/i2c/busses/i2c-powermac.c     |   19 ++-----------------
> >  drivers/i2c/busses/i2c-puv3.c         |   16 ++--------------
> >  drivers/i2c/busses/i2c-sh7760.c       |   13 +------------
> >  drivers/i2c/busses/i2c-simtec.c       |   18 ++----------------
> >  drivers/i2c/busses/i2c-xiic.c         |   18 ++----------------
> >  19 files changed, 26 insertions(+), 261 deletions(-)
> > (...)
> 
> Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> As said before, I'll let Ben pick the patch in his tree to minimize the
> risks of merge conflicts.

As Ben did not pick this patch after over a month, I'll include it in
my own tree. As I plan to send it to Linus quickly, hopefully it won't
have the time to cause merge conflicts.

-- 
Jean Delvare
