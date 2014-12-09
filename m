From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [v3] i2c: Driver to expose PowerNV platform i2c busses
Date: Tue,  9 Dec 2014 20:45:02 +1100 (AEDT)
Message-ID: <20141209094503.100F81400DE@ozlabs.org>
References: <20141208063039.14356.34770.stgit@localhost.localdomain>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141208063039.14356.34770.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-08-12 at 06:36:16 UTC, Neelesh Gupta wrote:
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> The driver uses the platform device infrastructure to probe the busses
> on the platform and registers them with the i2c driver framework.

>  arch/powerpc/include/asm/opal.h                    |   29 ++
>  arch/powerpc/platforms/powernv/opal-wrappers.S     |    1 
>  arch/powerpc/platforms/powernv/opal.c              |   11 +

This had major conflicts in the above files.

I've fixed it up but please check I did it correctly:

  https://github.com/mpe/powerpc-merge/commits/pw/neelesh-i2c

It also doesn't build as a module:

  $ grep CONFIG_I2C_OPAL .config
  CONFIG_I2C_OPAL=m
  $ make ...
  ...
  ERROR: "opal_i2c_request" [drivers/i2c/busses/i2c-opal.ko] undefined!

cheers
