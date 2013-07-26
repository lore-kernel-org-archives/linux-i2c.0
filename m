From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Fri, 26 Jul 2013 06:20:17 +0200
Message-ID: <201307260620.17711.marex@denx.de>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com> <CAOMZO5DqeMGgM9uTM5jZ_96_T2dWGBLDUfVf9JNqo2gypLDgvA@mail.gmail.com> <1374799579.2480.1.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1374799579.2480.1.camel@deadeye.wl.decadent.org.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, wsa@the-dreams.de, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Dear Ben Hutchings,

> On Wed, 2013-07-24 at 00:09 -0300, Fabio Estevam wrote:
> > Hi Marek,
> > 
> > On Wed, Jul 24, 2013 at 12:02 AM, Marek Vasut <marex@denx.de> wrote:
> > > Yes, the big question is if we want to use this patch or fix the PIO. I
> > > think this one is much less intrusive, so I'd vouch for yours for 3.10
> > > .
> > 
> > Correct. Also according to Documentation/stable_kernel_rules.txt :
> > 
> > "Rules on what kind of patches are accepted, and which ones are not, into
> > the "-stable" tree:
> > 
> > ....
> > 
> >  - It cannot be bigger than 100 lines, with context."
> > 
> > Your PIO fix is really appreciated, but it surpasses 100 lines, so it
> > would be better if we go with this one first so that it can reach
> > 3.10, and then we can use your PIO fix later.
> 
> That one is not a hard and fast rule, but small localised fixes are
> preferred if possible.

Full agreement on this one, let's apply this patch.

Best regards,
Marek Vasut
