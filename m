From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v10 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 20 Jun 2017 09:49:40 +0200
Message-ID: <20170620074940.GB1541@katana>
References: <20170603012952.2192-1-brendanhiggins@google.com>
 <20170603012952.2192-5-brendanhiggins@google.com>
 <20170619141322.devvmcbjaeq4jnv5@ninjato>
 <20170619142105.kynebk74y7nbvmfx@ninjato>
 <CAFd5g47D0zJax1X8MeV_OwMJvzd2Ba-hZc+8_X_Ks1ibH8ipeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFd5g47D0zJax1X8MeV_OwMJvzd2Ba-hZc+8_X_Ks1ibH8ipeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ryan Chen <ryan_chen@aspeedtech.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 05:58:19PM -0700, Brendan Higgins wrote:
> On Mon, Jun 19, 2017 at 7:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > And any chance for a MAINTAINERS entry?
> >
>=20
> We already have one:
> http://elixir.free-electrons.com/linux/v4.11.5/source/MAINTAINERS#L1090
>=20
> However, if you would like me to own this driver, I could add an entry
> for myself.

As far as get_maintainers.pl prints out someone responsibe, I am very
happy. The above line won't work for I2C (and maybe some other
subsystems), though,  because we are one directory level deeper
(drivers/i2c/busses/*aspeed*). That might want fixing.


--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllI05QACgkQFA3kzBSg
KbbNMBAAn/W1J+PtOGC7KB2IylKR79ve8dDiQcJUlqByR8CZ42UoyStLtXtyP+ew
oSg8q8eiQjpLxrL1zB0MZecKOvMH+JhdLsmXt0q7S7nT8Z1KvqyHgMTZxSYLgINL
PX43QGCBXdI502w4nPZH2Il1W4+CnYSV6Q46hmF8ZEytqoyIiAbfkrIipBPhIZXl
/hIqX2QoTLVZsLrz0eAID6GzN6YxVDaKdi4bVIkUHAvqyOrBJ+zO12/G/yygiic+
NrZmoylPPfJWJ2HMojOWud92e+zDnrnpQDlqwtTFdej1f9RjsJ6gFTPT2aLQt3p4
1uRtTSd5kBWnBYUPP2UnQW/i9/M/G95BnHcjl4/jJe1Ff4hUqfaR0ndYuAa7eEQy
ghYEhDB/63O9CH4E4cCbLbChp+8xqYLjqKz+XzP1Ep+xxUhddnXOC+BUb6XMgV9R
nYwzbDVsr0lmhX8CyBhDkRnlx+KtbDlPHviSaRTeZH6MiCPWmj9DXxUqxqPHaBai
DJKyduB8fhIEe7xclwwFqHrayXfQV7q4JD8Wx6QTnzEK49ss98fsK5ENvF2pCjBf
Cuk/zaHKljolHQF+Q+oM0prrRFgheHoHV8au8UCeOZwC355RpL/O0fZ6PWszzge+
3jGvwi4t5MVD+aeX32+ZmYi4szFM1TIMCj4PVLzhbvgEg5md12M=
=wg8i
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
