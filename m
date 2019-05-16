From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: bcm2835: Model Divider in CCF
Date: Thu, 16 May 2019 09:58:48 +0200
Message-ID: <20190516075848.GA1033@kunai>
References: <20190508071227.18609-1-nh6z@nh6z.net>
 <4174B26B-4E3A-4CCA-A5ED-BE62A3B5E66A@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2971374227558525926=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4174B26B-4E3A-4CCA-A5ED-BE62A3B5E66A@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: stefan.wahren@i2se.com, f.fainelli@gmail.com, swarren@wwwdotorg.org, team@nwdigitalradio.com, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============2971374227558525926==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Annaliese,

On Wed, May 15, 2019 at 10:37:03PM -0700, Annaliese McDermond wrote:
> I=E2=80=99m just following up on this since I haven=E2=80=99t heard anyth=
ing since I submitted the
> v2 patch a week ago.  Wolfram, does this look like a sane approach?  Stef=
an,
> were my changes in v2 acceptable?

There is a bit of overhead involved, but conceptually it looks like an
elegant solution to me. However, I am not an expert of CCF. Grepping
through kernel sources, I don't see many clocks defined outside
drivers/clk. So, I'd appreciate if we could get some ack/feedback from
one of the CCF experts/maintainers.

> I=E2=80=99m happy to go back to the drawing board to change things if the=
re=E2=80=99s a better
> answer to the problem.
>=20
> Thanks for everyone=E2=80=99s patience with me trying to work through the=
 proper
> process.

Thanks for working on this one!

Kind regards,

   Wolfram


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzdGDQACgkQFA3kzBSg
KbYQWg/5AdfmRi/ctOOZd7sOQgmD0lEnr9/6ymkWQRAGt5Q9ydawpT6Naol0J+wP
3V/a6n6NCsrzRl+8U2SfV6TUPIPGhEz32NwWx3rnbPSG0JKJcoWA3rkPbnZOFWzh
/4jojbUzI6TJQiOpizOKzGex+Pyjb1mo3oSw7mgYPQ13wHISa4gZdy84fjGeQeUf
2XGHQqkPJII47O4inWLXGc81IQfnWld1CGgY87EgY7YgzmwYXDqH/uzfnxVo8CTU
CU5UNiPBnIgdcC9zbkajNqIbPn5OXbZ2AwnNekIXKzAseJcjfciAAJKyo4Wrx8Aa
5HkbkCYxl2FudXhJLhNv+aEl2wOgCi17aujJgMYseDZlfPPL7NZYJ1KSVIbCdam9
XrkOb1ukxbdu4jh+bzQSRkmQoPlcPCV1UVvJOU4yvSzpjqzUKIwqY1OLLAJDvZh2
qNPcI52UWiv1NQLyYflcHWAgweQl7DmxMOVbF8P4FGvkIfY2AJhor1i05KbNzdW2
QMaOjAEE5EHhSARBK2365kfucjpcib3tDrVC+pZsE0uISVUp1Eabs8JeAu+1Vy2Y
HI/3R1BfvgIjhnwv1jPAdD1qND0dD0px5PeQ0Sl/vqx4eW597pHNxUUItHcUpKfU
QhXINFxHkoP45ozosW2YyrVfHFPKDGm0Bf3ZnZcqev5A+GaDQSM=
=XauL
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--


--===============2971374227558525926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2971374227558525926==--
