From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: Handle signals gracefully
Date: Wed, 21 May 2014 10:17:27 +0200
Message-ID: <20140521081727.GE2708@katana>
References: <1389265885-26777-1-git-send-email-mike.looijmans@topic.nl>
 <1394779348-4084-1-git-send-email-mike.looijmans@topic.nl>
 <20140324161432.GA7524@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140324161432.GA7524@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  		dev_err(dev->dev, "controller timed out\n");
> >  		davinci_i2c_recover_bus(dev);
> >  		i2c_davinci_init(dev);
> > @@ -384,7 +384,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, stru=
ct i2c_msg *msg, int stop)
> >  	if (dev->buf_len) {
> >  		/* This should be 0 if all bytes were transferred
> >  		 * or dev->cmd_err denotes an error.
> > -		 * A signal may have aborted the transfer.
> >  		 */
> >  		if (r >=3D 0) {
> >  			dev_err(dev->dev, "abnormal termination buf_len=3D%i\n",
> > @@ -436,22 +435,24 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct=
 i2c_msg msgs[], int num)
> >  	ret =3D i2c_davinci_wait_bus_not_busy(dev, 1);
> >  	if (ret < 0) {
> >  		dev_warn(dev->dev, "timeout waiting for bus ready\n");
> > -		return ret;
> > +		goto error;
>=20
> You are fixing the error path here to include the completion? This is a
> seperate patch IMO.

Is my remark true? I still prefer the seperate patch, but we may also
simply update the commit message.



--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfGEXAAoJEBQN5MwUoCm2Fh4QAKVBRFy811+w6TIAEi0HYAhu
GwkCAGXGzWx0SseCP1y5eAJnHLgElsxG9riSwe82sNuG2OOeAQvTHmNlVcx9ym5+
ZU/SaWSid0d+EYXvc7iMpvy4VvO2M7nzJcLT9uopAG7RVapCldmeK9g591rZyIiK
Ml3KPvf5uZYtKyeHCpDqKUuJUtCsudRWXmRwVBGF5xx8Qpb+RcNu/epAFQuh4FPI
L26VJOeTY0T4dV08BBJwaEwI+wDd9lI1zBKfeMZ+aZsGww8Kj+8ABsq6VBEAQ8bj
pVy46fQHr+dUaRDCli7wSaatIlJB9a6l2I4GlbwkPQ9XSqDMekPP/jiXAzBzdxRM
AVUW2gjHkE9IAqekPvv/2jrrEuvVPbe/6whBvGtrOmo6/46+QabZrlf4+BBST9On
eXPY83gPIBtsnAvCdAzecd8HCsNnm/fSQHcKZqZO5HzUK0O2jBE9hGIu2Arq2Dda
CO5eAlTQLj7ON88qwD+x2DuJ5muZQcQhIPlkbWg4j2n5rwFEuF5WDv8y6Kpf+jJS
V6Joo+1Dc4Nd7IUwIVE0dHOEvjWDoG4uY8l42wsv1ZhzbfuO7c0z5hDhqq2h7fQg
r9XeO5pI+S2Mn1EjvVCTld4WTx/tAg4lswxfHaIQaY/+8UlR0wWuLLXR8Lm62IXu
Apm96xTa1MKCpYAxS5SG
=n973
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
