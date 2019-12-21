From: Radu Nicolae Pirea <radu_nicolae.pirea@upb.ro>
Subject: Re: [PATCH] i2c: cadence: Added slave support
Date: Sat, 21 Dec 2019 19:58:50 +0200
Message-ID: <0a09d9ed5fc5ae6c651491dead5f81bfecdbca4b.camel@upb.ro>
References: <20191219124120.53754-1-radu_nicolae.pirea@upb.ro>
 <20191219130501.GA958@kunai>
 <6504123809effc310ade02dbb8a63f10db6b6c92.camel@upb.ro>
 <CAKfKVtFqbtovQGQuzgCYzTu4bHOmAOmTz-tZMD89iUkMPc8awA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKfKVtFqbtovQGQuzgCYzTu4bHOmAOmTz-tZMD89iUkMPc8awA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, linux-i2c <linux-i2c@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2019-12-20 at 14:55 +0530, Shubhrajyoti Datta wrote:
> Hi ,
> 
> On Thu, Dec 19, 2019 at 7:00 PM Radu Pirea <radu_nicolae.pirea@upb.ro
> > wrote:
> > On Thu, 2019-12-19 at 14:05 +0100, Wolfram Sang wrote:
> > > > +/**
> > > > + * enum cdns_i2c_mode - I2C Controller current operating mode
> > > > + *
> > > > + * @CDNS_I2C_MODE_SLAVE:       I2C controller operating in
> > > > slave
> > > > mode
> > > > + * @CDNS_I2C_MODE_MASTER:      I2C Controller operating in
> > > > master
> > > > mode
> > > > + */
> > > 
> > > Can't the hardware operate as master and slave at the same time?
> > > 
> > 
> > Of course, it can. If the driver has a slave registered wait and
> > listens and if the subsystem needs to use the controller as master,
> > the
> > driver changes the state of the controller to master, sends and
> > reads
> > data from the bus and after this change the state of the controller
> > to
> > slave.
> 
> However that should be done only if no master is talking to the slave
> right?

Yes. The state of the slave must be IDLE, otherwise
cdns_i2c_master_xfer will return -EAGAIN.

> 
> > In cdns_i2c_master_xfer is done all the magic.
