From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c-nomadik: documentation fixes
Date: Wed, 29 Sep 2010 00:08:08 +0100
Message-ID: <20100928230808.GM21564@trinity.fluff.org>
References: <1285225420-916-1-git-send-email-linus.walleij@stericsson.com> <20100927002508.GF21564@trinity.fluff.org> <AANLkTim_O65ZKod8oSV245Zu3saEwjcitPw3twSO5NrX@mail.gmail.com> <20100927223509.GI21564@trinity.fluff.org> <AANLkTikjUyxLaEURVh-42T9NL_XCvwPLU6pobV1yq2BD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikjUyxLaEURVh-42T9NL_XCvwPLU6pobV1yq2BD-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 28, 2010 at 10:55:37AM +0200, Linus Walleij wrote:
> 2010/9/28 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> 
> > It means that if your tree is handling external patches, then you could end
> > up with the situation where it is difficult or almost impossible to undo
> > a change which the original sender either did not have the authority to
> > send, or has something in that should have never been sent (i've seen
> > several issues where companies have had desperate back-peddling because
> > someone forgot to remove some $secret from the repository before allowing
> > it to be uploaded somewhere).
> 
> We actually have that part under control, believe it or not :-)

Ok, but it is probably useful for other people out there.
 
> > It would have been helpful to add a 'From:' line as well, git can be
> > made to re-write the authour of a patch, but you'll have to search for
> > it. Please find a method for future reference.
> 
> I'm on it... thanks Ben.

My personal view is to always keep attributions. Even if they are then
posted through someone else, or require a corporate stamp on them before
they get out of the building.

Let me know what you'd like to do, and I'll sort out something for -next.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
