From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: what is in bjdooks' i2c-for-2630 tree
Date: Fri, 27 Mar 2009 11:05:46 +0000
Message-ID: <20090327110546.GI19758@fluff.org.uk>
References: <E1Ln9js-00030o-8s@teyla.home.fluff.org> <20090327110331.GH19758@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090327110331.GH19758-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 27, 2009 at 11:03:31AM +0000, Ben Dooks wrote:
> On Fri, Mar 27, 2009 at 10:56:40AM +0000, Ben Dooks wrote:
> > The following changes since commit 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84:
> >   Linus Torvalds (1):
> >         Linux 2.6.29
> > 
> > are available in the git repository at:
> > 
> >   git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630
> 
> There's something very weird, either I get all the commits and a
> 'BRANCH NOT VERIFIED' or I get the correct branchname and just the
> one commit... Any ideas anyone?

The answer, of course, is push after finishing the 'git rebase'
command that you where doing to tidy the tree...
  
> > Darius Augulis (1):
> >       [I2C] iMX/MXC support
> > 
> >  arch/arm/plat-mxc/include/mach/i2c.h |   25 ++
> >  drivers/i2c/busses/Kconfig           |   10 +
> >  drivers/i2c/busses/Makefile          |    1 +
> >  drivers/i2c/busses/i2c-imx.c         |  617 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 653 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/plat-mxc/include/mach/i2c.h
> >  create mode 100644 drivers/i2c/busses/i2c-imx.c
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
