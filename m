From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v8 05/10] dt-bindings: i3c: Add macros to help fill
 I3C/I2C device's reg property
Date: Wed, 3 Oct 2018 21:06:13 +0200
Message-ID: <20181003210613.27d180c7@bbrezillon>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
        <20181003132212.12619-6-boris.brezillon@bootlin.com>
        <c7b929a8c8ebaec7ce0f0e09f803e414e74f986b.camel@perches.com>
        <20181003205953.426021bb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003205953.426021bb@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeau>
List-Id: linux-i2c@vger.kernel.org

On Wed, 3 Oct 2018 20:59:53 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Wed, 03 Oct 2018 11:37:17 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > On Wed, 2018-10-03 at 15:22 +0200, Boris Brezillon wrote:  
> > > The reg property of devices connected to an I3C bus have 3 cells, and
> > > filling them manually is not trivial. Provides macros to help doing
> > > that.    
> > 
> > This patch logic seems excessively fragile.  
> 
> Keep in mind that this header is meant to be include by .dts(i) files,
> not regular .c files.
> 
> >   
> > > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changes in v8:
> > > - None
> > > 
> > > Changes in v5:
> > > - none
> > > ---
> > >  include/dt-bindings/i3c/i3c.h | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >  create mode 100644 include/dt-bindings/i3c/i3c.h
> > > 
> > > diff --git a/include/dt-bindings/i3c/i3c.h b/include/dt-bindings/i3c/i3c.h
> > > new file mode 100644
> > > index 000000000000..97448c546649
> > > --- /dev/null
> > > +++ b/include/dt-bindings/i3c/i3c.h
> > > @@ -0,0 +1,28 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > > + *
> > > + * Author: Boris Brezillon <boris.brezillon@bootlin.com>
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_I3C_I3C_H
> > > +#define _DT_BINDINGS_I3C_I3C_H
> > > +
> > > +#define IS_I2C_DEV		0x80000000
> > > +
> > > +#define I2C_DEV(addr, lvr)					\
> > > +	(addr) (IS_I2C_DEV | (lvr)) 0x0    
> > 
> > This looks to be missing surrounding parentheses.  
> 
> Actually it's not. The macro is supposed to declare 3 u32 integers each
> of them separated by a space:
> 
> 	reg = <I2C_DEV(0x34, 0x1)>;
> 
> is translated into
> 
> 	reg = <0x34 0x80000001 0x0>;
> 
> >   
> > > +
> > > +#define I3C_PID(manufid, partid, instid, extrainfo)		\
> > > +	((manufid) << 1)					\
> > > +	(((partid) << 16) | ((instid) << 12) | (extrainfo))    
> > 
> > This macro doesn't make any sense.  Missing a shift and an or?  
> 
> Same here, the PID is taking 2 32-bit entries.
> 
> Now, I agree that this is far from obvious, and if Rob is okay, I'd
> like to propose a different binding to avoid having to define these
> macros:
> 
> 	reg = <i2c_addr_or_i3c_static_addr pid_msb pid_lsb>;
> 
> If pid_msb and pid_lsb are 0, then the node is defining an I2C device

Actually, I meant pid_msb == 0. This part of the PID is encoding the
manufacturer, and I don't think 0 is a valid manufacturer (I hope it's
not). So, we'd have something like:

	reg = <i2c_addr_or_i3c_static_addr pid_msb pid_lsb_or_i2c_lvr>;

> (AFAICT, 0 is not a valid PID), otherwise it's an I3C device. This way
> we get rid of the IS_I2C_DEV flag, and we can get rid of those macros
> without making I3C dev node definition too painful (the only part
> developers will have to get right is the PID) 
> 
> >   
> > > +
> > > +#define I3C_DEV_WITH_STATIC_ADDR(addr, manufid, partid,		\
> > > +				 instid, extrainfo)		\
> > > +	(addr) I3C_PID(manufid, partid, instid, extrainfo)
> > > +
> > > +#define I3C_DEV(manufid, partid, instid, extrainfo)		\
> > > +	I3C_DEV_WITH_STATIC_ADDR(0x0, manufid, partid,		\
> > > +				 instid, extrainfo)
> > > +
> > > +#endif    
> >   
> 
