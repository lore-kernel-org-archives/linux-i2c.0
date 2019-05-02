From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH v4 0/1] Add support for IPMB driver
Date: Thu, 2 May 2019 17:59:11 -0500
Message-ID: <20190502225910.GK6623@minyard.net>
References: <cover.1556645340.git.Asmaa@mellanox.com>
 <AM6PR05MB5224FCACBD4EF55F3890EC6AA23A0@AM6PR05MB5224.eurprd05.prod.outlook.com>
 <VI1PR05MB62392EDC0FD3C960519C91ABDA340@VI1PR05MB6239.eurprd05.prod.outlook.com>
 <20190502194954.GJ6623@minyard.net>
 <VI1PR05MB6239E3C9B9BBBA226DCFDD12DA340@VI1PR05MB6239.eurprd05.prod.outlook.com>
 <AM6PR05MB522465330E2C594B0309AE78A2340@AM6PR05MB5224.eurprd05.prod.outlook.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM6PR05MB522465330E2C594B0309AE78A2340@AM6PR05MB5224.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Michael Shych <michaelsh@mellanox.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 02, 2019 at 09:14:46PM +0000, Vadim Pasternak wrote:
>  [...]
> > >
> > > >>Better, if you can avoid cast.
> > > >>Would compiler warn if you use for example rol16(client->addr, 1) &
> > GENMASK(7, 0); or something like it?
> > > I thought it wouldn't be too much of an issue to use typecast here since other
> > existing ipmi drivers use typecasting: bt-bmc.c, kcs_bmc_aspeed.c,
> > kcs_bmc_npcm7xx.c all use (u8) typecasting.
> > > But if you really think it is worth it, I could do that.
> > > I just think it is not as straight forward to read this code as using a simple
> > typecast. Some might wonder why a GENMASK is needed in this case.
> > >
> 
> Hi Asmaa,
> 
> I will not insist in case it's OK with maintainers.
> 
>  [...]

I'm mostly against casts unless they are necessary, as they tend
to clutter up the code.  But I don't feel that strongly about
it.  I'm not sure how other maintainers feel.

-corey
