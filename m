From: Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c: add missing KERN_* constants to printks
Date: Fri, 06 Feb 2009 20:59:44 +0100
Message-ID: <498C96B0.7050408@suse.de>
References: <498C3EEA.5060508@suse.de> <20090206183542.GB6361@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090206183542.GB6361-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org>
Cc: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Uwe Kleine-K=F6nig schrieb:
> Are you sure about KERN_WARNING?  I havn't looked deeper, but DEB2
> suggests KERN_DEBUG?  What about fixing DEB[1-3] directly instead of
> each "call".  e.g.

No, in this case the DEB* macro was already in many places used
with KERN_* constants just like direct printk. I didn't wanna
change that.
KERN_WARNING is just the standard/default loglevel so that this
change doesn't introduce different behaviour.

Thanks,
=46rank
