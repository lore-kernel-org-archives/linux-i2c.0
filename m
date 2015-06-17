From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-tools: add Android.mk
Date: Wed, 17 Jun 2015 14:13:10 +0200
Message-ID: <20150617141310.16367b77@endymion.delvare>
References: <CA+TH9VkQzJaSa0okxK+s1ukpaqgiWegh3uumEb63LzZwBjV4nA@mail.gmail.com>
	<20150316101626.2c7a02be@endymion.delvare>
	<20150617102917.GB1517@katana>
	<CA+TH9Vm7oKH43S7j5G2_iQi7cF=y3G04V_nrswQ+6E1J6JNbOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+TH9Vm7oKH43S7j5G2_iQi7cF=y3G04V_nrswQ+6E1J6JNbOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 17 Jun 2015 12:38:54 +0200, Angelo Compagnucci wrote:
> Hi Wolfram,
> 
> 2015-06-17 12:29 GMT+02:00 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
> >
> >> Now if anyone has a more educated view on this than I do, please speak
> >> up. Android is really not my thing (as a developer, I mean.)
> >
> > While working again on adding i2ctransfer to i2c-tools, it became clear
> > that this android makefile would need an update for it, too. And since
> > nobody of us is using i2c-tools on android, nobody can provide a tested
> > update.
> 
> Nobody but me! Actually I'm using it and I had the need for it.
> Probably there are other people reinventing the wheel outside this
> mailinglist. Try to google for it.

We're not saying the immediate need doesn't exist. We're only
questioning whether the i2c-tools repository is the right place for the
extra file. This questioning is reinforced by the fact that I never saw
any Andoid.mk file in any other upstream project I'm working on.

It really reminds me of rpm spec files or Debian-specific files hosted
by upstream projects. My experience is that these files bitrot over time
because the upstream maintainers don't need them and often can't test
them. They are better maintained somewhere else.

(And then again I don't understand why they can't just use "make" as
everybody else.)

> > So, it would indeed be easier if the android universe would
> > figure a way in their sphere. So, I agree with Jean.
> 
> I think it's more a matter of a makefile approach. They use a non
> recursive one (recommended by several papers[1]) and it's up to

i2c-tools's Makefile is not recursive. In fact it's derived from
lm-sensors' Makefile, which itself was designed based on the paper
"Recursive Make Considered Harmful" - the one you just mentioned. Ah,
irony ;-)

i2c-tools's Makefile is modular. Not recursive.

> external projects if embrace it or no. Honestly I think that a
> minuscule file with really low maintenance should be added.
> 
> I'm glad to prepare a new patch if maintainership is interested!

I'm not.

-- 
Jean Delvare
SUSE L3 Support
