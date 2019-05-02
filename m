From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v4 0/1] Add support for IPMB driver
Date: Thu, 2 May 2019 14:49:54 -0500
Message-ID: <20190502194954.GJ6623@minyard.net>
References: <cover.1556645340.git.Asmaa@mellanox.com>
 <AM6PR05MB5224FCACBD4EF55F3890EC6AA23A0@AM6PR05MB5224.eurprd05.prod.outlook.com>
 <VI1PR05MB62392EDC0FD3C960519C91ABDA340@VI1PR05MB6239.eurprd05.prod.outlook.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR05MB62392EDC0FD3C960519C91ABDA340@VI1PR05MB6239.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Asmaa Mnebhi <Asmaa@mellanox.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Michael Shych <michaelsh@mellanox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 02, 2019 at 06:06:12PM +0000, Asmaa Mnebhi wrote:
> Hi Vadim, Hi Corey,
> 
> Please find inline comments answering your questions.
> 
> -----Original Message-----
> From: Vadim Pasternak 
> Sent: Tuesday, April 30, 2019 5:24 PM
> To: Asmaa Mnebhi <Asmaa@mellanox.com>; minyard@acm.org; wsa@the-dreams.de; Michael Shych <michaelsh@mellanox.com>
> Cc: Asmaa Mnebhi <Asmaa@mellanox.com>; linux-kernel@vger.kernel.org; linux-i2c@vger.kernel.org
> Subject: RE: [PATCH v4 0/1] Add support for IPMB driver
> 
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
> > 1) You are correct. This driver is not specific to Mellanox so I have 
> > removed the Mellanox attribute.
> > 
> > 2) I have added a documentation file called IPMB.txt which explains 
> > how this module works and how it should be instantiated. It is very 
> > similar to the existing linux i2c-slave-eeprom module.
> > 
> > The HW for my testing works as follows:
> > A BMC is connected to a Satellite MC via I2C (I2C is equivalent to 
> > IPMB). The BMC initiates the IPMB requests and sends them via I2C.
> > Obviously the BMC needs its own driver to do this which I haven't 
> > included in this code. We have no intent of upstreaming that at the moment.
> 
> >> I believe you are going to do it at some point, right?
> @Vadim Pasternak: I would.
> @Corey: The ipmb-dev-int driver is not responsible for sending requests via I2C (unlike for example the ipmi_ssif driver). It is only responsible for receiving those requests and passing them to a user space program. Once a response is received from user space, it will forward that response back to the requester So in my testing for example, the source requester is the BMC, so I issue ipmitool commands from the BMC itself.
> 
> The driver that I have on my BMC (which I primarily designed for testing ipmb-dev-int) works hand in hand with the ipmi_msghandler and ipmi_devint to create the /dev/ipmi0 device file to enable the use of ipmitool program on the BMC. Once an ipmitool command is issued on the BMC,  the request message is sent to the Satellite MC. Once the BMC driver gets the response back from the Satellite MC, it will pass it to the ipmitool program which will display the output to the user. 
> 
> Please note that this ipmb-dev-int driver does not need ipmi_msghandler nor does it need ipmi_devintf to be loaded.

Ah, I misunderstood.  I thought you were talking about the IPMB driver on
the BMC.  So what you have is something like:

    Host                   BMC              Sat MC
    ----                   ---              ------
                       ipmb-dev-int <----> ipmb-dev-int
    Linux IPMI drv <---> ipmi-host-int

I assume you can use the same ipmb-dev-int on the BMC and satellite MCs
(assuming Linux runs on both).  You have another driver that runs on
the BMC that talks to the host system through some sort of semi-custom
interface, and then another driver that's on the Linux host that sits
under ipmi_msghandler and provides the host access to that interface.

That's a separate issue, as you said.

-corey

> 
> > This ipmb-dev-int driver is to be loaded and instantiated on the 
> > Satellite MC to be able to receive IPMB requests. These IPMB request 
> > messages will be picked up by a user space program such (in my case it 
> > is OpenIPMI) to handle the request and generate a response.
> > The response will be then passed from the user program back to kernel space.
> > Then this driver would send that response back to the BMC.
> > 
> > 3) You asked the following:
> > 
> > "Is it expected to be zero in vaid case?"
> > The 8 least significant bits of the sum is always expected to be 0 in 
> > the case where the checksum is valid. I have added a comment for clarifications.
> 
> 
> > 
> > "why do you need this cast?"
> > buf[++ipmb_dev_p->msg_idx]=(u8)(client->addr<<1)
> > This is because client->addr is of type unsigned short which is
> > 2 bytes so it is safer to typecast it to u8 (u8* buf)
> 
> >>Better, if you can avoid cast.
> >>Would compiler warn if you use for example rol16(client->addr, 1) & GENMASK(7, 0); or something like it?
> I thought it wouldn't be too much of an issue to use typecast here since other existing ipmi drivers use typecasting: bt-bmc.c, kcs_bmc_aspeed.c, kcs_bmc_npcm7xx.c all use (u8) typecasting. 
> But if you really think it is worth it, I could do that.
> I just think it is not as straight forward to read this code as using a simple typecast. Some might wonder why a GENMASK is needed in this case.
> 
> 
> 
> > 
> > "It could be only single ipmb-dev within the system? Couldn't it be 
> > few, like master/slave for example?"
> > My understanding of your question is that: what if we have multiple 
> > instances of ipmb-dev-int, that we register it under different addresses?
> > This driver only works as a slave so it will only be instantiated once 
> > on the Satellite MC under one slave address.
> 
> >>I mentioned some config like:
> >>BMC1 (master)  -- busA --|
> >>			Satellite
> >>BMC2 (standby)	-- busB --| 
> 
> >>Since this is not Mellanox specific driver, maybe it would be good to support multiple instances of it.
> 
> I see, I understand now. That sounds good.
> I added support to instantiate several ipmb devices for the purpose of having multiple BMC masters for one Satellite MC. The design consists in naming each instantiated device with the IPMBus/I2C bus number associated with it. For example, :
> BMC1 -----I2C/IPMB bus 1 ----- Satellite MC (/dev/ipmb-1)
> BMC2 -----I2C/IPMB bus 2 ----- Satellite MC (/dev/ipmb-2)
> 
> I added documentation for that as well.
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
