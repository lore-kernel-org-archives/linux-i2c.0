From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Date: Fri, 21 Dec 2018 17:16:51 +0100
Message-ID: <20181221161651.5n4zzapliyxzb76l@M43218.corp.atmel.com>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
 <20180720224141.lawanibd7v4hmbym@ninjato>
 <20180730071443.clib3swtsommj7jk@M43218.corp.atmel.com>
 <20181211192805.qsxptzkmczmm5vlz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211192805.qsxptzkmczmm5vlz@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, Dec 11, 2018 at 08:28:05PM +0100, Wolfram Sang wrote:
> Hi Ludovic,
> 
> > > >  - fix checkpatch errors
> > > >  - tests:
> > > >    - hangs with a SAMA5D4 (master and slave on different busses) after about
> > > >    100 transfers. It's the firs time I do this test.
> > > >    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
> > > >    I don't know if it's a regression. I don't remember having seen this
> > > >    behavior previously.
> > > >    I think it's worth taking those patches even if there are some possible
> > > >    bugs. It'll allow to get more people using it and so to consolidate the
> > > >    slave mode support.
> > > 
> > > I really want to see those patches go upstream, too. But I am also not a
> > > big fan of delivering the user something with known issues. Especially
> > > not when they affect the main feature to be added. My rationale here is
> > > that someone who is able to fix the issues remaining will also be able
> > > to pick up and apply patches.
> > > 
> > > Maybe, maybe if it was to be enabled by a special
> > > I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
> > > think twice about that, though.
> > > 
> > 
> > I understand your point. The experimental mentionning could be a good
> > trade-off. Let me know once you make up your mind.
> > 
> > > Speaking of Kconfig, I think this series needs to place a
> > > 
> > > 	select I2C_SLAVE
> > > 
> > > somewhere.
> > > 
> > 
> > Ok I'll update it if we go further with this set of patches.
> 
> Ok, I give in. If you:
> 
> * add 'select I2C_SLAVE'
> * make slave support selectable by I2C_AT91_SLAVE_STAGING or
>   _EXPERIMENTAL or something alike (default n)
> * and add to the help text of that symbol the above known issues
>   and 'not for production' and 'help wanted' and where to get more
>   info and all that
> 
> then I'll apply this series soonish. Promised!

Ok I will handle these requests and resend it.

Thanks

Ludovic
