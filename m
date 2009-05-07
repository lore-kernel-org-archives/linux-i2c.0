From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Use resource_size macro
Date: Thu, 7 May 2009 09:20:09 +0200
Message-ID: <20090507092009.1a2882cc@hyperion.delvare>
References: <1241641718-14585-1-git-send-email-linus.walleij@stericsson.com>
	<20090506213523.GB17311@pengutronix.de>
	<63386a3d0905061450t23b74998r68fd12198aab103b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <63386a3d0905061450t23b74998r68fd12198aab103b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 6 May 2009 23:50:55 +0200, Linus Walleij wrote:
> 2009/5/6 Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> 
> > On Wed, May 06, 2009 at 10:28:38PM +0200, Linus Walleij wrote:
> >> From: root <root@fecusia.(none)>
> >
> > Hello root :)
> 
> Hehe, I am experimenting with using the new git-send-email script that come
> with newer git versions. It's great because it safely avoids whitespace
> mangling and give you control over the send lines, but then it adds this in
> instead and now I need to figure out how to get rid of that :-P

In ~/.gitconfig:

[user]
	name = Linus Walleij
	email = linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org

Should do.

-- 
Jean Delvare
