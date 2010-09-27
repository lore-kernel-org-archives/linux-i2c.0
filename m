From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c-nomadik: documentation fixes
Date: Mon, 27 Sep 2010 10:59:22 +0200
Message-ID: <AANLkTim_O65ZKod8oSV245Zu3saEwjcitPw3twSO5NrX@mail.gmail.com>
References: <1285225420-916-1-git-send-email-linus.walleij@stericsson.com>
	<20100927002508.GF21564@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100927002508.GF21564-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2010/9/27 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:

> On Thu, Sep 23, 2010 at 09:03:40AM +0200, Linus Walleij wrote:
>> This fixes some kerneldoc and assorted documenatation in the
>> Nomadik I2C driver without semantic impact.
>>
>> Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>> Signed-off-by: Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>
> You've correctly got yourself in the signed-off-by line, but why is there
> a reference to 'Sundar R Iye' in there? If this is the original patch
> authour then you need to have a From: line at the top as it looks like
> you (Linus Walleij) are re-sending the patch.

Actually there are several original authors, we're squashing internal
company history into this patch set (with more on its way). The
changes are not split this way in the original git, they are split this
way because of your request to split the patch set.

Sundar is one author, I'm delivering so we're doing this with a
double-SoB, couldn't think of anything better.

> I'll apply these once this is sorted out.

OK I hope Sundar is happy with this, else he'll tell us.

Yours,
Linus Walleij
