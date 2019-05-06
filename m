From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] i2c: bcm2835: Model Divider in CCF
Date: Mon, 06 May 2019 17:59:12 +0200
Message-ID: <6436b4f65565e3fca6827b1c6c0b95f81b099d98.camel@suse.de>
References: <20190505034339.30778-1-nh6z@nh6z.net>
 <610c7594-85c9-72db-63a6-6e632e9586aa@i2se.com>
 <c43eb848-23cd-4b0c-638d-3bb0df58ed31@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8055653226505597447=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c43eb848-23cd-4b0c-638d-3bb0df58ed31@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Florian Fainelli <f.fainelli@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>, Annaliese McDermond <nh6z@nh6z.net>, eric@anholt.net, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com
List-Id: linux-i2c@vger.kernel.org


--===============8055653226505597447==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-NF/oAISSXjVajL9Q6zli"


--=-NF/oAISSXjVajL9Q6zli
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-05-05 at 10:13 -0700, Florian Fainelli wrote:
>=20
> On 5/5/2019 3:36 AM, Stefan Wahren wrote:
> > Hi Annaliese,
> >=20
> > Am 05.05.19 um 05:43 schrieb Annaliese McDermond:
> > > Model the I2C bus clock divider as a part of the Core Clock Framework=
.
> > > Primarily this removes the clk_get_rate() call from each transfer.
> > > This call causes problems for slave drivers that themselves have
> > > internal clock components that are controlled by an I2C interface.
> > > When the slave's internal clock component is prepared, the prepare
> > > lock is obtained, and it makes calls to the I2C subsystem to
> > > command the hardware to activate the clock.  In order to perform
> > > the I2C transfer, this driver sets the divider, which requires
> > > it to get the parent clock rate, which it does with clk_get_rate().
> > > Unfortunately, this function will try to take the clock prepare
> > > lock, which is already held by the slave's internal clock calls
> > > creating a deadlock.
> >=20
> > i think i understand the problem, but could you please explain the
> > specific use case where this happend?
> >=20
> > I suspect bcm2835 is not the only platform which is affected, so it
> > would be better to fix this in general.
>=20
> Agreed, if you could identify i2c bus drivers that support changing the
> bus clock and move the registration of the bus 'struct clk' into the i2c
> core that would scale a lot better.

For the record, some time ago I asked for directions on how to properly han=
dle
asyncronous clk rate changes on devices like this and the clk mantainers'
proposed solution[1] needed something similar to what Annaliese is proposin=
g.

That said, I can think of more subsystems that could benefit of a generic
solution for this. I'm pretty sure SPI would, but also MMC, UARTs, and othe=
rs.

[1] https://www.spinics.net/lists/linux-clk/msg36937.html




--=-NF/oAISSXjVajL9Q6zli
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzQWdAACgkQlfZmHno8
x/6IsAf+ID13VCoGqWG4174whG3Ks3+bn8WWuz8UlPe23RRO9vXQSurDN9839eIN
Hyd9h8CNClLc1TCNJmaxKURycfwavKNuedfa+WxZXVV4iNLbVJpRjtCWsYmcuEY6
BFR+d2hpi7xN8CwK7NlXc64Yim81OUdn3ph0sONRn+PJDIOeJfZIfUpueibMQA/B
K4JDfPBaMoACZ9piTLL0NsTHOfjc4MRmksFPMxsYr3KnfZXy9lm0haUZPrIrNVni
egDuNK0ZstLwiaGPtXrUVl8QaRSZFNWaB/tY4oZ4bmDwPkxOtYzz4ZOlFupvg1aK
vn2pwH8TuTDQsgizLuKOOnF2GzCiHQ==
=fidG
-----END PGP SIGNATURE-----

--=-NF/oAISSXjVajL9Q6zli--



--===============8055653226505597447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8055653226505597447==--
