From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] i2c: cadence: Added slave support
Date: Fri, 20 Dec 2019 14:55:05 +0530
Message-ID: <CAKfKVtFqbtovQGQuzgCYzTu4bHOmAOmTz-tZMD89iUkMPc8awA@mail.gmail.com>
References: <20191219124120.53754-1-radu_nicolae.pirea@upb.ro>
 <20191219130501.GA958@kunai> <6504123809effc310ade02dbb8a63f10db6b6c92.camel@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6504123809effc310ade02dbb8a63f10db6b6c92.camel@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Chirag Parekh <chirag.parekh@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

Hi ,

On Thu, Dec 19, 2019 at 7:00 PM Radu Pirea <radu_nicolae.pirea@upb.ro> wrote:
>
> On Thu, 2019-12-19 at 14:05 +0100, Wolfram Sang wrote:
> > > +/**
> > > + * enum cdns_i2c_mode - I2C Controller current operating mode
> > > + *
> > > + * @CDNS_I2C_MODE_SLAVE:       I2C controller operating in slave
> > > mode
> > > + * @CDNS_I2C_MODE_MASTER:      I2C Controller operating in master
> > > mode
> > > + */
> >
> > Can't the hardware operate as master and slave at the same time?
> >
>
> Of course, it can. If the driver has a slave registered wait and
> listens and if the subsystem needs to use the controller as master, the
> driver changes the state of the controller to master, sends and reads
> data from the bus and after this change the state of the controller to
> slave.

However that should be done only if no master is talking to the slave right?

> In cdns_i2c_master_xfer is done all the magic.
