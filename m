From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v4 0/1] Add support for IPMB driver
Date: Tue, 30 Apr 2019 20:03:31 -0500
Message-ID: <20190501010300.GG6623@minyard.net>
References: <cover.1556645340.git.Asmaa@mellanox.com>
 <AM6PR05MB5224FCACBD4EF55F3890EC6AA23A0@AM6PR05MB5224.eurprd05.prod.outlook.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM6PR05MB5224FCACBD4EF55F3890EC6AA23A0@AM6PR05MB5224.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Michael Shych <michaelsh@mellanox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 30, 2019 at 09:24:29PM +0000, Vadim Pasternak wrote:
> 
> 
> > -----Original Message-----
> > From: Asmaa Mnebhi <Asmaa@mellanox.com>
> > Sent: Tuesday, April 30, 2019 8:59 PM
> > To: minyard@acm.org; wsa@the-dreams.de; Vadim Pasternak
> > <vadimp@mellanox.com>; Michael Shych <michaelsh@mellanox.com>
> > Cc: Asmaa Mnebhi <Asmaa@mellanox.com>; linux-kernel@vger.kernel.org;
> > linux-i2c@vger.kernel.org
> > Subject: [PATCH v4 0/1] Add support for IPMB driver
> > 
> > Thank you for your feedback Vadim. I have addressed your comments.
> 
> Hi Asmaa,
> 
> Thank you for your comments and added doc.
> 
> > 
> > 1) You are correct. This driver is not specific to Mellanox so I have removed the
> > Mellanox attribute.
> > 
> > 2) I have added a documentation file called IPMB.txt which explains how this
> > module works and how it should be instantiated. It is very similar to the existing
> > linux i2c-slave-eeprom module.
> > 
> > The HW for my testing works as follows:
> > A BMC is connected to a Satellite MC via I2C (I2C is equivalent to IPMB). The
> > BMC initiates the IPMB requests and sends them via I2C.
> > Obviously the BMC needs its own driver to do this which I haven't included in this
> > code. We have no intent of upstreaming that at the moment.
> 
> I believe you are going to do it at some point, right?

This is a little confusing to me.  Why wouldn't you use the same driver on the
BMC?  IIRC, the IPMB protocol is symmetric at this level.

-corey

> 
> > This ipmb-dev-int driver is to be loaded and instantiated on the Satellite MC to
> > be able to receive IPMB requests. These IPMB request messages will be picked
> > up by a user space program such (in my case it is OpenIPMI) to handle the
> > request and generate a response.
> > The response will be then passed from the user program back to kernel space.
> > Then this driver would send that response back to the BMC.
> > 
> > 3) You asked the following:
> > 
> > "Is it expected to be zero in vaid case?"
> > The 8 least significant bits of the sum is always expected to be 0 in the case
> > where the checksum is valid. I have added a comment for clarifications.
> 
> 
> > 
> > "why do you need this cast?"
> > buf[++ipmb_dev_p->msg_idx]=(u8)(client->addr<<1)
> > This is because client->addr is of type unsigned short which is
> > 2 bytes so it is safer to typecast it to u8 (u8* buf)
> 
> Better, if you can avoid cast.
> Would compiler warn if you use for example
> rol16(client->addr, 1) & GENMASK(7, 0);
> or something like it?
> 
> 
> > 
> > "It could be only single ipmb-dev within the system? Couldn't it be few, like
> > master/slave for example?"
> > My understanding of your question is that: what if we have multiple instances of
> > ipmb-dev-int, that we register it under different addresses?
> > This driver only works as a slave so it will only be instantiated once on the
> > Satellite MC under one slave address.
> 
> I mentioned some config like:
> BMC1 (master)  -- busA --|
> 			Satellite
> BMC2 (standby)	-- busB --| 
> 
> Since this is not Mellanox specific driver, maybe it would be good to support
> multiple instances of it.

I second this.  Especially if it's on a BMC, you can expect to have multiple
IPMBs.

-corey

> 
> > 
> > Asmaa Mnebhi (1):
> >   Add support for IPMB driver
> > 
> >  Documentation/IPMB.txt           |  53 ++++++
> >  drivers/char/ipmi/Kconfig        |   8 +
> >  drivers/char/ipmi/Makefile       |   1 +
> >  drivers/char/ipmi/ipmb_dev_int.c | 381
> > +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 443 insertions(+)
> >  create mode 100644 Documentation/IPMB.txt  create mode 100644
> > drivers/char/ipmi/ipmb_dev_int.c
> > 
> > --
> > 2.1.2
> 
