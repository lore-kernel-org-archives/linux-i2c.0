From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [v3] i2c: Driver to expose PowerNV platform i2c busses
Date: Fri, 12 Dec 2014 16:30:48 +1100
Message-ID: <1418362248.1465.6.camel@ellerman.id.au>
References: <20141209094503.100F81400DE@ozlabs.org>
	 <1418120492.13358.45.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418120492.13358.45.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Jeremy Kerr <jeremy.kerr-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2014-12-09 at 21:21 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2014-12-09 at 20:45 +1100, Michael Ellerman wrote:
> > On Mon, 2014-08-12 at 06:36:16 UTC, Neelesh Gupta wrote:
> > > The patch exposes the available i2c busses on the PowerNV platform
> > > to the kernel and implements the bus driver to support i2c and
> > > smbus commands.
> > > The driver uses the platform device infrastructure to probe the busses
> > > on the platform and registers them with the i2c driver framework.
> > 
> > >  arch/powerpc/include/asm/opal.h                    |   29 ++
> > >  arch/powerpc/platforms/powernv/opal-wrappers.S     |    1 
> > >  arch/powerpc/platforms/powernv/opal.c              |   11 +
> > 
> > This had major conflicts in the above files.
> > 
> > I've fixed it up but please check I did it correctly:
> > 
> >   https://github.com/mpe/powerpc-merge/commits/pw/neelesh-i2c
> > 
> > It also doesn't build as a module:
> > 
> >   $ grep CONFIG_I2C_OPAL .config
> >   CONFIG_I2C_OPAL=m
> >   $ make ...
> >   ...
> >   ERROR: "opal_i2c_request" [drivers/i2c/busses/i2c-opal.ko] undefined!
> 
> Right that needs to be exported, however for those OPAL wrappers to work
> when exported as modules on an LE kernel with ABI v2 (pfiew !) we need
> another patch from jk to sort out the external entry to the asm...
> 
> Jeremy, is that already in or not yet ?

Yeah it's been in since October.

Please send a v4 with a fix for this Neelesh.

cheers
