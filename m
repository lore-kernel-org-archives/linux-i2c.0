From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] i2c-designware-core: disable adapter before fill dev
 structure
Date: Wed, 12 Jun 2013 11:41:49 +0200
Message-ID: <20130612094148.GF31524@ab42.lan>
References: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ@mail.gmail.com>
 <1370597401-22501-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20130607130133.GH11875@ab42.lan>
 <20130611184036.GD3376@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130611184036.GD3376@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 11, 2013 at 08:40:37PM +0200, Wolfram Sang wrote:
> On Fri, Jun 07, 2013 at 03:01:34PM +0200, Christian Ruppert wrote:
> > Hi Andy,
> >=20
> > I like your patch and I just did some testing on it. Unluckily, it
> > doesn't solve the lock-up problem.
> >=20
> > I haven't investigated any further but I suspect that on top of the
> > cases I observed when debugging this (interrupts after initialisati=
on of
> > dev, easy to prove) there are more obscure cases in which interrupt=
s are
> > generated in an unexpected manner after errors. The interrupt-drive=
n
> > transfer state machine of the driver implicitly relies on the fact =
that
> > all updates of dev which are related to the same transfer are perfo=
rmed
> > between the mutex_lock and mutex_unlock calls in i2c_dw_xfer. Thus,=
 I
> > decided it was safer to disable the block before releasing the mute=
x
> > when I wrote my patch.
> >=20
> > That said, I think the sequencing at transfer initialisation is mor=
e
> > logical with your patch and I wonder if it is still worth applying.=
 Any
> > other opinions on this?
>=20
> Ping. There are:
>=20
> [V2] i2c: designware: fix race between subsequent xfers
> [RFC] i2c-designware-core: disable adapter before fill dev structure
>=20
> What is the consensus of those two patches?

Although I almost like Andy's code better than my own it doesn't seem t=
o
fix the issue we're aiming at (system lock ups due to undesired
interrupts) in all cases. The "[V2] i2c: designware: fix race between
subsequent xfers" is currently the only patch preventing those lock ups
in our tests.

That said, IMHO Andy's patch seems to be a valuable code clean up
nevertheless and could be applied in addition to the other. I suggest I
give the combination of both patches some additional testing on the
occasion and tag Andy's RFC with tested-by me in case it's stable.

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
