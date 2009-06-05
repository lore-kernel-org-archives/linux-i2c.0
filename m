From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Fri, 5 Jun 2009 13:54:17 +0200
Message-ID: <20090605135417.5076682f@hyperion.delvare>
References: <4A2566E8.7080404@mocean-labs.com>
	<20090602224822.GE18453@fluff.org.uk>
	<20090603101533.599d41db@hyperion.delvare>
	<87oct53ewh.fsf@macbook.be.48ers.dk>
	<4A2639F6.2010505@mocean-labs.com>
	<20090604150752.6aa7668c@hyperion.delvare>
	<4A27D91E.1000306@mocean-labs.com>
	<20090604210243.078aeb2f@hyperion.delvare>
	<4A28C579.7090507@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A28C579.7090507-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?ISO-8859-15?B?UvZqZm9ycw==?= <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 05 Jun 2009 09:12:57 +0200, Richard R=F6jfors wrote:
> Jean Delvare wrote:
> >=20
> > I am now convinced your proposed implementation makes sense for you=
r
> > specific need (which is relatively rare, which is why i2c-core does=
n't
> > handle it.) And contrary to what I first wrote, this doesn't need t=
o be
> > moved to i2c-core: this is specific enough that I'd rather let the =
code
> > live in the bus driver (i2c-ocores) for now, and only if at least t=
wo
> > other bus drivers need the same, consider moving it to i2c-core.
> >=20
> > So if you fix the minor objection Ben had about your patch and rese=
nd
> > it, I think we can merge that.
>=20
> Will do.
>=20
> > Oh, and I also believe your driver
> > should call i2c_unregister_device() on removal, for symmetry.
>=20
> Isn't better to leave that to i2c_del_adapter? Otherwise we need to s=
tore a list
> of the I2C-clients returned by i2c_new_device.

Err, you're right. I tend to forget that the parameters passed to
i2c_unregister_device() differ from those passed to i2c_new_device().
Maybe we'd need i2c_unregister_device_by_addr() or something. In the
meantime, yes, just leave it to i2c_del_adapter() to clean up the
remaining clients.

--=20
Jean Delvare
