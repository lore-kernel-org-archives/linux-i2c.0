From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] i2c: designware: fix race between subsequent xfers
Date: Mon, 17 Jun 2013 10:19:33 +0200
Message-ID: <20130617081931.GB19380@ab42.lan>
References: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
 <1370595083-801-1-git-send-email-christian.ruppert@abilis.com>
 <20130614143740.GD2929@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130614143740.GD2929@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 14, 2013 at 04:37:41PM +0200, Wolfram Sang wrote:
> On Fri, Jun 07, 2013 at 10:51:23AM +0200, Christian Ruppert wrote:
> [...]
> > +	/*
> > +	 * We must disable the adapter before unlocking the &dev->lock mu=
tex
> > +	 * below. Otherwise the hardware might continue generating interr=
upts
> > +	 * which in turn causes a race condition with the following trans=
fer.
>=20
> I added "Needs some more investigation if the additional interrupts a=
re
> a hardware bug or this driver doesn't handle them correctly yet." to =
the
> comment and

Good idea, thanks.

> Applied to for-next, thanks!
>=20
> BTW since I am currently here: i2c-designware-core should be in the
> 'algos' directory, no?

At the risk of passing for a complete moron: What exactly is the
difference between I2C algos and I2C bus drivers?

Greetings,
  Christian

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
