From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] i2c-designware-core: disable adapter before fill dev
 structure
Date: Thu, 13 Jun 2013 10:58:05 +0200
Message-ID: <20130613085803.GA17347@ab42.lan>
References: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ@mail.gmail.com>
 <1370597401-22501-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20130613081621.GB19061@ab42.lan>
 <1371112436.29283.340.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371112436.29283.340.camel@smile>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 13, 2013 at 11:33:56AM +0300, Andy Shevchenko wrote:
> On Thu, 2013-06-13 at 10:16 +0200, Christian Ruppert wrote:=20
> > As promised, I gave this one some over-night stress testing and I c=
an
> > confirm what I said previously:
> >=20
> > - The patch does _not_ solve the interrupt loop lockups on its own.
>=20
> So, it just means my assumptions about what is happening there were
> wrong.

So were my initial ones... Or at least insufficient.

> > - The patch works well in conjunction with
> >   http://patchwork.ozlabs.org/patch/249622/ (which in turn depends =
on
> >   Mika's patch). Under this condition you can assume
> >   Tested-By: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> >=20
> > I still think the code is more logical with this patch than without=
 it
> > and I am in favour of applying both (if Andy agrees that is).
>=20
> Since my patch doesn't fix anything, I think we may drop it away.
>=20
> >  We must keep in mind, however, that http://patchwork.ozlabs.org/pa=
tch/249622
> > does fix a real problem we can observe on our chip and for our TB10=
x
> > product we do require some form of it for stability reasons.
>=20
> I feel like a real fix is to add a memory barier to make changes in t=
he
> structure consistent. However, I have no clue where.

I'm still not sure about the interrupt behaviour of the dw-i2c block in
the case of error (and since our problem is fixed it's difficult to
justify spending time to investigate further). I suspect that the thing
in some situations sends spurious interrupts which confuse the state
machine - in which case memory barriers won't help us either.

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
