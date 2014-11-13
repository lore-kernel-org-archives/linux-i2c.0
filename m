From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
Date: Thu, 13 Nov 2014 16:36:28 +1100
Message-ID: <1415856988.28703.7.camel@concordia>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
	 <1415772441.5124.39.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415772441.5124.39.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jeremy Kerr <jeremy.kerr-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2014-11-12 at 17:07 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2014-11-10 at 11:35 +0530, Neelesh Gupta wrote:
> > The patch exposes the available i2c busses on the PowerNV platform
> > to the kernel and implements the bus driver to support i2c and
> > smbus commands.
> > The driver uses the platform device infrastructure to probe the busses
> > on the platform and registers them with the i2c driver framework.
> > 
> > Signed-off-by: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> > Signed-off-by: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> 
> This version slightly modified removes the unrelated gunk in opal.c
> (but needs to apply on top of some other patches in the powerpc tree)
> 
> The driver is the same, it's only the
> arch/powerpc/platform/powernv/opal.c init bits that get cleaned up and
> simplified.
> 
> From: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
> Date: Fri, 7 Nov 2014 16:20:07 +1100
> Subject: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
> 
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> 
> If the devices are found on the device tree for a given bus/adapter,
> the platform init code registers them to the core and binds them
> a static bus/adapter number, otherwise the driver registers the
> adapter to get the adapter number dynamically.

So the driver part depends on the arch/powerpc changes.

I added Wolfram the i2c maintainer to CC. Wolfram are you happy if we take this
through the powerpc tree with your ack, or I can do a topic branch?

cheers
