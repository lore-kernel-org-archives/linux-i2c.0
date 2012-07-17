From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: State of arbitration and i2c_gpio?
Date: Tue, 17 Jul 2012 09:11:15 +0200
Message-ID: <20120717091115.44e28fd0@endymion.delvare>
References: <loom.20120710T223443-322@post.gmane.org>
	<20120716225827.3425f4f8@endymion.delvare>
	<20120717065544.GF11678@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120717065544.GF11678-ci3XGGwdvIcvfNposrsB4g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Urlichs <matthias-+qxcz+fHsVSELgA04lAiVw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Jul 2012 08:55:45 +0200, Matthias Urlichs wrote:
> Jean Delvare:
> > At the other end of the
> > spectrum, we have to deal with the maximum I2C frequency, 400 kHz i=
n
> > our context. This means you can't have more than 1.25 =C2=B5s betwe=
en polls.
>=20
> Just wait until somebody implements Hs mode. :-P

Arbitration under HS-mode is handled differently: it is settled early
in the transaction. So this might not actually be a problem.

> > In all cases we'll certainly want to let adapters tell whether they=
 are
> > operating on a multi-master bus or not, so that the whole thing can=
 be
> > disabled when not needed.
>=20
> They'll certainly notice that the first time they lose arbitration.

They won't notice if the code is disabled. My point was that we don't
want to put an additional burden on single-master buses because
arbitration is never needed for them.

--=20
Jean Delvare
