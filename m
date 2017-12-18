From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 2/7] i3c: Add core I3C infrastructure
Date: Mon, 18 Dec 2017 09:37:40 +0100
Message-ID: <20171218093740.52eed20d@bbrezillon>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
        <20171214151610.19153-3-boris.brezillon@free-electrons.com>
        <63546906-2fab-300a-b952-a0a7e8eb8bb5@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42411 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757660AbdLRIhx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Dec 2017 03:37:53 -0500
In-Reply-To: <63546906-2fab-300a-b952-a0a7e8eb8bb5@infradead.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@co>

On Sun, 17 Dec 2017 14:32:04 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 12/14/17 07:16, Boris Brezillon wrote:
> > Add core infrastructure to support I3C in Linux and document it.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/Kconfig                 |    2 +
> >  drivers/Makefile                |    2 +-
> >  drivers/i3c/Kconfig             |   24 +
> >  drivers/i3c/Makefile            |    4 +
> >  drivers/i3c/core.c              |  573 ++++++++++++++++
> >  drivers/i3c/device.c            |  344 ++++++++++
> >  drivers/i3c/internals.h         |   34 +
> >  drivers/i3c/master.c            | 1433 +++++++++++++++++++++++++++++++++++++++
> >  drivers/i3c/master/Kconfig      |    0
> >  drivers/i3c/master/Makefile     |    0
> >  include/linux/i3c/ccc.h         |  380 +++++++++++
> >  include/linux/i3c/device.h      |  321 +++++++++
> >  include/linux/i3c/master.h      |  564 +++++++++++++++
> >  include/linux/mod_devicetable.h |   17 +
> >  14 files changed, 3697 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/i3c/Kconfig
> >  create mode 100644 drivers/i3c/Makefile
> >  create mode 100644 drivers/i3c/core.c
> >  create mode 100644 drivers/i3c/device.c
> >  create mode 100644 drivers/i3c/internals.h
> >  create mode 100644 drivers/i3c/master.c
> >  create mode 100644 drivers/i3c/master/Kconfig
> >  create mode 100644 drivers/i3c/master/Makefile
> >  create mode 100644 include/linux/i3c/ccc.h
> >  create mode 100644 include/linux/i3c/device.h
> >  create mode 100644 include/linux/i3c/master.h
> > 
> > diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> > new file mode 100644
> > index 000000000000..cf3752412ae9
> > --- /dev/null
> > +++ b/drivers/i3c/Kconfig
> > @@ -0,0 +1,24 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +menuconfig I3C
> > +	tristate "I3C support"
> > +	select I2C
> > +	help
> > +	  I3C is a serial protocol standardized by the MIPI alliance.
> > +
> > +	  It's supposed to be backward compatible with I2C while providing
> > +	  support for high speed transfers and native interrupt support
> > +	  without the need for extra pins.
> > +
> > +	  The I3C protocol also standardizes the slave device types and is
> > +	  mainly design to communicate with sensors.
> > +
> > +	  If you want I3C support, you should say Y here and also to the
> > +	  specific driver for your bus adapter(s) below.
> > +
> > +	  This I3C support can also be built as a module.  If so, the module
> > +	  will be called i3c.
> > +
> > +if I3C
> > +source "drivers/i3c/master/Kconfig"
> > +endif # I3C  
> 
> > diff --git a/drivers/i3c/core.c b/drivers/i3c/core.c
> > new file mode 100644
> > index 000000000000..7eb8e84acd33
> > --- /dev/null
> > +++ b/drivers/i3c/core.c
> > @@ -0,0 +1,573 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> > + */
> > +
> > +#include <linux/idr.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/slab.h>  
> 
> #include <linux/device.h>
> #include <linux/init.h>
> #include <linux/list.h>
> #include <linux/mutex.h>
> #include <linux/rwsem.h>

Do you have a tool to detect those missing inclusions?

> 
> 
> > +#include "internals.h"
> > +
> > +static DEFINE_IDR(i3c_bus_idr);
> > +static DEFINE_MUTEX(i3c_core_lock);
> > +  
> 
> > +/**
> > + * i3c_bus_maintenance_lock - Release the bus lock after a maintenance  
> 
>                           unlock
> 

Will fix that.

> > + *			      operation
> > + * @bus: I3C bus to release the lock on
> > + *
> > + * Should be called when the bus maintenance operation is done. See
> > + * i3c_bus_maintenance_lock() for more details on what these maintenance
> > + * operations are.
> > + */
> > +void i3c_bus_maintenance_unlock(struct i3c_bus *bus)
> > +{
> > +	up_write(&bus->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_bus_maintenance_unlock);
> > +  
> 
> > +/**
> > + * i3c_bus_normaluse_lock - Release the bus lock after a normal operation  
> 
>                         unlock

Ditto.

> 
> > + * @bus: I3C bus to release the lock on
> > + *
> > + * Should be called when a normal operation is done. See
> > + * i3c_bus_normaluse_lock() for more details on what these normal operations
> > + * are.
> > + */
> > +void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
> > +{
> > +	up_read(&bus->lock);
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_bus_normaluse_unlock);  
> 
> 
> 
> > +static int i3c_device_match(struct device *dev, struct device_driver *drv)  
> 
> bool?
> 
> > +{
> > +	struct i3c_device *i3cdev;
> > +	struct i3c_driver *i3cdrv;
> > +
> > +	if (dev->type != &i3c_device_type)
> > +		return 0;
> > +
> > +	i3cdev = dev_to_i3cdev(dev);
> > +	i3cdrv = drv_to_i3cdrv(drv);
> > +	if (i3c_device_match_id(i3cdev, i3cdrv->id_table))
> > +		return 1;
> > +
> > +	return 0;
> > +}  
> 
> 
> > diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> > new file mode 100644
> > index 000000000000..dcf51150b7cb
> > --- /dev/null
> > +++ b/drivers/i3c/device.c
> > @@ -0,0 +1,344 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> > + */
> > +
> > +#include <linux/slab.h>  
> 
> #include <linux/atomic.h>
> #include <linux/bug.h>
> #include <linux/completion.h>
> #include <linux/device.h>
> #include <linux/mutex.h>
> 
> > +#include "internals.h"  
> 
> 
> 
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > new file mode 100644
> > index 000000000000..1c85abac08d5
> > --- /dev/null
> > +++ b/drivers/i3c/master.c
> > @@ -0,0 +1,1433 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> > + */  
> 
> #include <linux/atomic.h>
> #include <linux/device.h>
> #include <linux/err.h>
> #include <linux/export.h>
> #include <linux/kernel.h>
> #include <linux/list.h>
> #include <linux/of.h>
> 
> > +#include <linux/slab.h>  
> 
> #include <linux/spinlock.h>
> #include <linux/workqueue.h>
> 
> #include <asm-generic/bug.h>
> 
> > +#include "internals.h"  
> 
> 
> and I probably missed a few.
> 
> 
> 
> 
> > diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
> > new file mode 100644
> > index 000000000000..ff3e1a3e2c4c
> > --- /dev/null
> > +++ b/include/linux/i3c/ccc.h
> > @@ -0,0 +1,380 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> > + */  
> 
> > +/**
> > + * struct i3c_ccc_dev_desc - I3C/I3C device descriptor used for DEFSLVS  
> 
> Is one of those I3C above supposed to be I2C?

Indeed, should be I2C/I3C.

> 
> > + *
> > + * @dyn_addr: dynamic address assigned to the I3C slave or 0 if the entry is
> > + *	      describing an I2C slave.
> > + * @dcr: DCR value (not applicable to entries describing I2C devices)
> > + * @lvr: LVR value (not applicable to entries describing I3C devices)
> > + * @bcr: BCR value or 0 if this entry is describing an I2C slave
> > + * @static_addr: static address or 0 if the device does not have a static
> > + *		 address
> > + *
> > + * The DEFSLVS command should be passed an array of i3c_ccc_dev_desc
> > + * descriptors (one entry per I3C/I2C dev controlled by the master).
> > + */
> > +struct i3c_ccc_dev_desc {
> > +	u8 dyn_addr;
> > +	union {
> > +		u8 dcr;
> > +		u8 lvr;
> > +	};
> > +	u8 bcr;
> > +	u8 static_addr;
> > +} __packed;  
> 
> 
> Needs bitops.h
> 
> > diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> > new file mode 100644
> > index 000000000000..83958d3a02e2
> > --- /dev/null
> > +++ b/include/linux/i3c/device.h
> > @@ -0,0 +1,321 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> > + */
> > +
> > +#ifndef I3C_DEV_H
> > +#define I3C_DEV_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>  
> 
> 
> Needs bitops.h, kconfig.h.
> 
> 
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > new file mode 100644
> > index 000000000000..7ec9a4821bac
> > --- /dev/null
> > +++ b/include/linux/i3c/master.h
> > @@ -0,0 +1,564 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2017 Cadence Design Systems Inc.
> > + *
> > + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> > + */
> > +
> > +#ifndef I3C_MASTER_H
> > +#define I3C_MASTER_H
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/i3c/ccc.h>
> > +#include <linux/i3c/device.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define I3C_HOT_JOIN_ADDR		0x2
> > +#define I3C_BROADCAST_ADDR		0x7e
> > +#define I3C_MAX_ADDR			GENMASK(6, 0)
> > +  
> 
> Needs bitops.h, workqueue.h, rwsem.h
> 
> 
> Needs <asm-generic/bitsperlong.h>

Okay, that's really weird to directly include a header from the
asm-generic directory, are you sure this is the right thing to do here?

> 
> 
> 
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index abb6dc2ebbf8..e59da92d8ac9 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -442,6 +442,23 @@ struct pci_epf_device_id {
> >  	kernel_ulong_t driver_data;
> >  };
> >  
> > +/* i3c */
> > +
> > +#define I3C_MATCH_DCR			BIT(0)
> > +#define I3C_MATCH_MANUF			BIT(1)
> > +#define I3C_MATCH_PART			BIT(2)
> > +#define I3C_MATCH_EXTRA_INFO		BIT(3)
> 
> Needs bitops.h.

I think I'll just avoid using BIT() here, as done for other definitions
in this file.

> 
> > +struct i3c_device_id {
> > +	__u8 match_flags;
> > +	__u8 dcr;
> > +	__u16 manuf_id;
> > +	__u16 part_id;
> > +	__u16 extra_info;
> > +
> > +	const void *data;
> > +};
> > +
> >  /* spi */
> >  
> >  #define SPI_NAME_SIZE	32
> >   
> 
> 
