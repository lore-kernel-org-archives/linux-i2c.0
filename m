From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v10 3/8] i2c: thunderx: Add i2c driver for ThunderX SOC
Date: Tue, 23 Aug 2016 23:09:34 +0200
Message-ID: <20160823210934.GA28936@hardcore>
References: <cover.1465997603.git.jglauber@cavium.com>
 <1ead8831e4dd879d452e8bc1a2a33ccba3a74b3d.1465997604.git.jglauber@cavium.com>
 <20160823203628.GB20872@katana>
 <20160823203941.GC20872@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160823203941.GC20872@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 23, 2016 at 10:39:41PM +0200, Wolfram Sang wrote:
> On Tue, Aug 23, 2016 at 10:36:29PM +0200, Wolfram Sang wrote:
> > 
> > >  i2c-octeon-objs := i2c-cavium.o i2c-octeon-core.o
> > >  obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
> > > +i2c-thunderx-objs := i2c-cavium.o i2c-thunderx-core.o
> > > +obj-$(CONFIG_I2C_THUNDERX)	+= i2c-thunderx.o
> > 
> > Shouldn't that rather be "i2c-cavium-core.o",
> 
> Thinking of it again, it should probably even be "i2c-octeon-core.o" to
> avoid confusion because all the functions start with octeon_*
> 
> > "i2c-octeon-platdrv.o",  and "i2c-thunderx-pcidrv.o" for the -objs?
> 
> Those names still make sense :)
> 

Agreed, the naming you propose looks much better.

--Jan
