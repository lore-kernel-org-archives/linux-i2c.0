From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/6] i2cset: Remove deprecated method to provide the
 value mask
Date: Mon, 14 Feb 2011 09:09:33 -0800
Message-ID: <20110214170933.GA23753@ericsson.com>
References: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
 <1297628246-19367-2-git-send-email-guenter.roeck@ericsson.com>
 <20110214094847.6607ebaa@endymion.delvare>
 <20110214154610.GA22833@ericsson.com>
 <20110214171735.06270f30@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110214171735.06270f30-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Mon, Feb 14, 2011 at 11:17:35AM -0500, Jean Delvare wrote:
> On Mon, 14 Feb 2011 07:46:10 -0800, Guenter Roeck wrote:
> > On Mon, Feb 14, 2011 at 03:48:47AM -0500, Jean Delvare wrote:
> > > Hi Guenter,
> > > 
> > > Wow, 6 patches :)
> > > 
> > Just because I switched to git. Makes it much easier to me to handle 
> > a sequence of patches. Yes, I know, it probably works with svn as well.
> > Just a personal preference ...
> 
> Actually, no, SVN would be horrible for this I think. Quilt, OTOH,
> would work just fine.
> 
For some reason, Quilt and me seem to be at odds with each other. No idea
why. I tried, but it just doesn't work for me. Maybe it is too simple for me
to understand ;).

> > > (...)
> > > This looks good, however I think the code can be cleaned up further by
> > > getting rid of maskp. I introduced maskp [1] because the mask could be
> > > at two different places on the command line, but now it is no longer
> > > needed.
> >
> > Not sure how, though, since we either need the index to argv[mask] or the pointer, 
> > or we would have to read the mask while checking the parameters. The latter
> > doesn't look very clean to me.
> 
> The latter is actually what I had in mind. But if you don't like the
> idea, just leave the code as it is.
> 
Problem with that is that I can not check the value range at that time, and
I don't know if mask is a valid parameter to start with. So there would have to
be a value check later on anyway (which I just agreed to add). I think it is
better to keep reading the value and the range check together.

Thanks,
Guenter
