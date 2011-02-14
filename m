From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/6] i2cset: Remove deprecated method to provide the
  value mask
Date: Mon, 14 Feb 2011 17:17:35 +0100
Message-ID: <20110214171735.06270f30@endymion.delvare>
References: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
	<1297628246-19367-2-git-send-email-guenter.roeck@ericsson.com>
	<20110214094847.6607ebaa@endymion.delvare>
	<20110214154610.GA22833@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110214154610.GA22833-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 14 Feb 2011 07:46:10 -0800, Guenter Roeck wrote:
> On Mon, Feb 14, 2011 at 03:48:47AM -0500, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > Wow, 6 patches :)
> > 
> Just because I switched to git. Makes it much easier to me to handle 
> a sequence of patches. Yes, I know, it probably works with svn as well.
> Just a personal preference ...

Actually, no, SVN would be horrible for this I think. Quilt, OTOH,
would work just fine.

> > (...)
> > This looks good, however I think the code can be cleaned up further by
> > getting rid of maskp. I introduced maskp [1] because the mask could be
> > at two different places on the command line, but now it is no longer
> > needed.
>
> Not sure how, though, since we either need the index to argv[mask] or the pointer, 
> or we would have to read the mask while checking the parameters. The latter
> doesn't look very clean to me.

The latter is actually what I had in mind. But if you don't like the
idea, just leave the code as it is.

-- 
Jean Delvare
