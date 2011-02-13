From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2ctools/i2cset: Remove obsolete means to specify value mask
Date: Sun, 13 Feb 2011 18:05:55 +0100
Message-ID: <20110213180555.1f364a41@endymion.delvare>
References: <20110131161945.GA4197@ericsson.com>
	<20110213112305.615c291b@endymion.delvare>
	<20110213164141.GA13323@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110213164141.GA13323-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 13 Feb 2011 08:41:41 -0800, Guenter Roeck wrote:
> Hi Jean,
> 
> On Sun, Feb 13, 2011 at 05:23:05AM -0500, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > Sorry for the late reply.
> > 
> No problem. I appreciate your feedback.
> 
> > On Mon, 31 Jan 2011 08:19:45 -0800, Guenter Roeck wrote:
> > > Attached patch removes the obsolete means to specify the value mask from i2cset.
> > > It also streamlines and improves parameter validation.
> > 
> > I'm afraid these are too many changes at once for an easy review. I'll
> > try still, but ideally this would have been two patches at least.
>
> No good idea how to split it, though.

Well, if nothing else, you have two changes mentioned in file CHANGES.
This would seem to be a natural split point.

You may think it's not worth it because one of the patches will be
pretty small. However, please remember that the time it takes to review
a patch is more or less proportional to the square of its length [1].
So even moving 10% of a patch to another may result in significant
review time savings.

[1] This totally arbitrary and unproven statement is known as Jean
Delvare's rule ;)

> > Overall it looks good and I agree the new code is slightly easier to
> > follow than the original code. I didn't really have a problem with the
> > original code, but my view is certainly biased as I wrote most of it ;)
>
> Another option would be to just keep the original code. This patch doesn't
> really change anything from a functionality perspective (other than being
> more stringent with parameter checking), and the proposed changes are not
> really needed. So I am perfectly fine with dropping it if you think
> it isn't worth it.

Well, at least dropping the alternative way to set the mask seems sane.
And your patch lets us get rid of a goto and a label, which is always a
good thing. Last but not least, if you had the feeling that the code
could be rewritten to be clearer, before you became familiar with it,
it is also a good hint.

> > I did some tests and did not find any problem.
> > 
> > > --
> > > Index: tools/i2cset.c
> > > ===================================================================
> > > --- tools/i2cset.c	(revision 5911)
> > > +++ tools/i2cset.c	(working copy)
> > > @@ -156,7 +156,7 @@
> > >  	char *end;
> > >  	const char *maskp = NULL;
> > >  	int res, i2cbus, address, size, file;
> > > -	int value, daddress, vmask = 0;
> > > +	int value = -1, daddress, vmask = 0;
> > 
> > I'd rather move this initialization to where it is needed (the default
> > case in the switch block which reads the values from the command line).
> > Pre-initializing variables unconditionally to prevent gcc warnings
> > voids the value of these warnings.
>
> The compiler does not understand when value is not used when passed to confirm(),

Yes, I understood this.

> so it will have be initialized all the time, including the BLOCK_DATA case
> (because its use there is more of a side effect). I moved the initialization
> to the default and to the BLOCK_DATA cases. 

Ah, yes, I hadn't noticed this.

> > > @@ -207,74 +207,78 @@
> > >  		help();
> > >  	}
> > >  
> > > -	/* check for block data */
> > >  	len = 0;
> > 
> > It's confusing why you initialize len here. I think it would make more
> > sense to initialize it later, where you set it for block transactions.
>
> The compiler doesn't understand that len is only used for block transactions
> in confirm(), and complains about an uninitialized variable otherwise.
> So it needs to be initialized for all commands.

Sorry, I should have empathized my point. Once again:

It's confusing why you initialize len _here_.

> Let me know if you have a better idea how to handle this - I don't like it
> too much either. For now I just added a comment explaining the reason for
> the initialization.

I get that it has to be initialized. I just don't think this is the
most logical place.

Thanks,
-- 
Jean Delvare
