From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c-nomadik: documentation fixes
Date: Mon, 27 Sep 2010 23:35:09 +0100
Message-ID: <20100927223509.GI21564@trinity.fluff.org>
References: <1285225420-916-1-git-send-email-linus.walleij@stericsson.com> <20100927002508.GF21564@trinity.fluff.org> <AANLkTim_O65ZKod8oSV245Zu3saEwjcitPw3twSO5NrX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim_O65ZKod8oSV245Zu3saEwjcitPw3twSO5NrX-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 27, 2010 at 10:59:22AM +0200, Linus Walleij wrote:
> 2010/9/27 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> 
> > On Thu, Sep 23, 2010 at 09:03:40AM +0200, Linus Walleij wrote:
> >> This fixes some kerneldoc and assorted documenatation in the
> >> Nomadik I2C driver without semantic impact.
> >>
> >> Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> >> Signed-off-by: Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> >> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> >
> > You've correctly got yourself in the signed-off-by line, but why is there
> > a reference to 'Sundar R Iye' in there? If this is the original patch
> > authour then you need to have a From: line at the top as it looks like
> > you (Linus Walleij) are re-sending the patch.
>
> Actually there are several original authors, we're squashing internal
> company history into this patch set (with more on its way). The
> changes are not split this way in the original git, they are split this
> way because of your request to split the patch set.

I would much prefer to see less squashing, it makes life difficult for
the upstream. I'll accept your signed-off as a you have made sure that
this is work that is yours to submit.

I do not like having authours removed from patches, it is all too easy
if you go about squashing two different authours work together and
then not being able to re-split them if you have a problem.

It means that if your tree is handling external patches, then you could end
up with the situation where it is difficult or almost impossible to undo
a change which the original sender either did not have the authority to
send, or has something in that should have never been sent (i've seen
several issues where companies have had desperate back-peddling because
someone forgot to remove some $secret from the repository before allowing
it to be uploaded somewhere).

The other issue is that if you start squashing different fixes and updates
together, it makes it difficult to go through examining the effects of a
change. When these are merged upstream it is occasionally useful to be
able to bisect these change in case one fix or change breaks something
for another user.

Basically, if possible, please avoid too much squashing and also avoid
squashing two different authours of patches together.

> Sundar is one author, I'm delivering so we're doing this with a
> double-SoB, couldn't think of anything better.

It would have been helpful to add a 'From:' line as well, git can be
made to re-write the authour of a patch, but you'll have to search for
it. Please find a method for future reference.
 
> > I'll apply these once this is sorted out.
> 
> OK I hope Sundar is happy with this, else he'll tell us.
> 
> Yours,
> Linus Walleij

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
