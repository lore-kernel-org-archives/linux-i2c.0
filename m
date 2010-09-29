From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] fix PCA waitforcompletion() return value
Date: Wed, 29 Sep 2010 09:11:56 +0200
Message-ID: <20100929091156.29011485@endymion.delvare>
References: <4C99CA70.2070109@visionsystems.de>
	<20100922093123.GE2693@pengutronix.de>
	<20100922120848.6a43c5c2@endymion.delvare>
	<20100928230845.GN21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100928230845.GN21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 29 Sep 2010 00:08:45 +0100, Ben Dooks wrote:
> On Wed, Sep 22, 2010 at 12:08:48PM +0200, Jean Delvare wrote:
> > Hi Wolfram,
> > 
> > On Wed, 22 Sep 2010 11:31:23 +0200, Wolfram Sang wrote:
> > > On Wed, Sep 22, 2010 at 11:20:48AM +0200, Yegor Yefremov wrote:
> > > > ret is still -1, if during the polling read_byte() returns at once
> > > > with I2C_PCA_CON_SI set. So ret > 0 would lead *_waitforcompletion()
> > > > to return 0, in spite of the proper behavior.
> > > > 
> > > > The routine was rewritten, so that ret has always a proper value,
> > > > before returning.
> > > > 
> > > > Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> > > > Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > 
> > > Great! Jean, I think this is .36-relevant. Do you plan another
> > > pull-request (hmm, there is still my clientdata-patch ;))? Should
> > > probably go to stable, too.
> > 
> > Yes, I have a few i2c patches scheduled for 2.6.36 and plan to send
> > Linus a pull request soon. I'm a little busy this week at work, and also
> > due to a complete workstastion update so I must setup a number of
> > things again and this temporarily hinders my efficiency.
> 
> Want me to push it, i've a few fixes too.

No, thanks. It's already in my tree and ready to go to Linus. I know
I'm lagging behind a bit these days but this should get better by the
end of the week.

-- 
Jean Delvare
