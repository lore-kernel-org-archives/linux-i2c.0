From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add missing KERN_* constants to printks
Date: Fri, 6 Feb 2009 21:53:54 +0100
Message-ID: <20090206205354.GA7400@strlen.de>
References: <498C3EEA.5060508@suse.de> <20090206183542.GB6361@strlen.de> <498C96B0.7050408@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <498C96B0.7050408-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
Cc: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hallo Frank,

On Fri, Feb 06, 2009 at 08:59:44PM +0100, Frank Seidel wrote:
> Uwe Kleine-K=F6nig schrieb:
> > Are you sure about KERN_WARNING?  I havn't looked deeper, but DEB2
> > suggests KERN_DEBUG?  What about fixing DEB[1-3] directly instead o=
f
> > each "call".  e.g.
>=20
> No, in this case the DEB* macro was already in many places used
> with KERN_* constants just like direct printk. I didn't wanna
> change that.
> KERN_WARNING is just the standard/default loglevel so that this
> change doesn't introduce different behaviour.
Ah, OK.  Then you have my Acked-by.

Best regards
Uwe
