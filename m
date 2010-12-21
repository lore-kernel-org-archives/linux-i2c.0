From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Tue, 21 Dec 2010 23:51:27 +0000
Message-ID: <20101221235127.GC10081@opensource.wolfsonmicro.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
 <201012181559.50347.rjw@sisk.pl>
 <20101220150051.GI26706@rakim.wolfsonmicro.main>
 <201012202213.53902.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201012202213.53902.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 20, 2010 at 10:13:53PM +0100, Rafael J. Wysocki wrote:

> Well, the _solution_ is to get rid of the legacy stuff from those buses in the
> first place.  Then, they'll just need to use the generic ops without any
> trouble.

> What you're proposing is a workaround that people will use as an excuse for
> not doing the right thing forever.

I hadn't actually realised that there was any urgency about removing the
old APIs - I'd not really seen much work in that direction.  If the
intention is to actively push people over to dev_pm_ops that does make a
bit more sense.
