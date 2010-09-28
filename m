From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c-nomadik: documentation fixes
Date: Tue, 28 Sep 2010 10:55:37 +0200
Message-ID: <AANLkTikjUyxLaEURVh-42T9NL_XCvwPLU6pobV1yq2BD@mail.gmail.com>
References: <1285225420-916-1-git-send-email-linus.walleij@stericsson.com>
	<20100927002508.GF21564@trinity.fluff.org>
	<AANLkTim_O65ZKod8oSV245Zu3saEwjcitPw3twSO5NrX@mail.gmail.com>
	<20100927223509.GI21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100927223509.GI21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2010/9/28 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:

> It means that if your tree is handling external patches, then you could end
> up with the situation where it is difficult or almost impossible to undo
> a change which the original sender either did not have the authority to
> send, or has something in that should have never been sent (i've seen
> several issues where companies have had desperate back-peddling because
> someone forgot to remove some $secret from the repository before allowing
> it to be uploaded somewhere).

We actually have that part under control, believe it or not :-)

> It would have been helpful to add a 'From:' line as well, git can be
> made to re-write the authour of a patch, but you'll have to search for
> it. Please find a method for future reference.

I'm on it... thanks Ben.

Yours,
Linus Walleij
