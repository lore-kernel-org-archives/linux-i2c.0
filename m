From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: i2ctools/i2cset: Remove obsolete means to specify value mask
Date: Sun, 13 Feb 2011 09:25:34 -0800
Message-ID: <20110213172534.GC13323@ericsson.com>
References: <20110131161945.GA4197@ericsson.com>
 <20110213112305.615c291b@endymion.delvare>
 <20110213164141.GA13323@ericsson.com>
 <20110213180555.1f364a41@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110213180555.1f364a41-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Sun, Feb 13, 2011 at 12:05:55PM -0500, Jean Delvare wrote:
[ ... ]
> >
> > No good idea how to split it, though.
> 
> Well, if nothing else, you have two changes mentioned in file CHANGES.
> This would seem to be a natural split point.
> 
> You may think it's not worth it because one of the patches will be
> pretty small. However, please remember that the time it takes to review
> a patch is more or less proportional to the square of its length [1].
> So even moving 10% of a patch to another may result in significant
> review time savings.
> 
> [1] This totally arbitrary and unproven statement is known as Jean
> Delvare's rule ;)
> 
I like that ;). I'll see what I can do.

[ ... ]

> > > >  
> > > > -	/* check for block data */
> > > >  	len = 0;
> > > 
> > > It's confusing why you initialize len here. I think it would make more
> > > sense to initialize it later, where you set it for block transactions.
> >
> > The compiler doesn't understand that len is only used for block transactions
> > in confirm(), and complains about an uninitialized variable otherwise.
> > So it needs to be initialized for all commands.
> 
> Sorry, I should have empathized my point. Once again:
> 
> It's confusing why you initialize len _here_.
> 
> > Let me know if you have a better idea how to handle this - I don't like it
> > too much either. For now I just added a comment explaining the reason for
> > the initialization.
> 
> I get that it has to be initialized. I just don't think this is the
> most logical place.
> 
Ah, now I understand. I moved it to just before 
	switch (size)

The current location is actually a leftover from the old code. 

Thanks,
Guenter
