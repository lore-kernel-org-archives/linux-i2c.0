From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Tue, 11 Jun 2013 20:21:22 +0200
Message-ID: <20130611182121.GA3376@katana>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130605133945.GA2934@katana>
 <20130605213144.GB14209@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130605213144.GB14209@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2013 at 11:31:44PM +0200, Maxime Ripard wrote:
> Hi Wolfram,
>=20
> On Wed, Jun 05, 2013 at 03:39:47PM +0200, Wolfram Sang wrote:
> >=20
> > > +#define SUNXI_I2C_ADDR_REG		(0x00)
> > > +#define SUNXI_I2C_ADDR_ADDR(v)			((v & 0x7f) << 1)
> > > +#define SUNXI_I2C_XADDR_REG		(0x04)
> > > +#define SUNXI_I2C_DATA_REG		(0x08)
> > > +#define SUNXI_I2C_CNTR_REG		(0x0c)
> > > +#define SUNXI_I2C_CNTR_ASSERT_ACK		BIT(2)
> > > +#define SUNXI_I2C_CNTR_INT_FLAG			BIT(3)
> > > +#define SUNXI_I2C_CNTR_MASTER_STOP		BIT(4)
> > > +#define SUNXI_I2C_CNTR_MASTER_START		BIT(5)
> > > +#define SUNXI_I2C_CNTR_BUS_ENABLE		BIT(6)
> > > +#define SUNXI_I2C_CNTR_INT_ENABLE		BIT(7)
> > > +#define SUNXI_I2C_STA_REG		(0x10)
> > > +#define SUNXI_I2C_STA_BUS_ERROR			(0x00)
> > > +#define SUNXI_I2C_STA_START			(0x08)
> > > +#define SUNXI_I2C_STA_START_REPEAT		(0x10)
> > > +#define SUNXI_I2C_STA_MASTER_WADDR_ACK		(0x18)
> > > +#define SUNXI_I2C_STA_MASTER_WADDR_NAK		(0x20)
> > > +#define SUNXI_I2C_STA_MASTER_DATA_SENT_ACK	(0x28)
> > > +#define SUNXI_I2C_STA_MASTER_DATA_SENT_NAK	(0x30)
> > > +#define SUNXI_I2C_STA_MASTER_RADDR_ACK		(0x40)
> > > +#define SUNXI_I2C_STA_MASTER_RADDR_NAK		(0x48)
> > > +#define SUNXI_I2C_STA_MASTER_DATA_RECV_ACK	(0x50)
> > > +#define SUNXI_I2C_STA_MASTER_DATA_RECV_NAK	(0x58)
> > > +#define SUNXI_I2C_CCR_REG		(0x14)
> > > +#define SUNXI_I2C_CCR_DIV_N(val)		(val & 0x3)
> > > +#define SUNXI_I2C_CCR_DIV_M(val)		((val & 0xf) << 3)
> > > +#define SUNXI_I2C_SRST_REG		(0x18)
> > > +#define SUNXI_I2C_SRST_RESET			BIT(0)
> > > +#define SUNXI_I2C_EFR_REG		(0x1c)
> > > +#define SUNXI_I2C_LCR_REG		(0x20)
> > > +
> > > +#define SUNXI_I2C_DONE			BIT(0)
> > > +#define SUNXI_I2C_ERROR			BIT(1)
> > > +#define SUNXI_I2C_NAK			BIT(2)
> > > +#define SUNXI_I2C_BUS_ERROR		BIT(3)
> >=20
> > The register set looks similar to i2c-mv64xxx.c. Has it been considered
> > to merge the two drivers?
>=20
> Hmm, right, the logic seems surprisingly similar. I wasn't aware of such
> a driver, so I didn't put much thought into merging them :)

Too late now, yet grepping for specific register names is a good thing
to do before writing a new driber.

> However, the register layout is quite different enough to be quite
> painful to support: the XADDR register here seems to be equivalent to
> the Marvell's EXT_SLAVE_ADDR register, yet in the allwinner case, the
> offset is 0x4, while it's 0x1c in Marvell's case, which offsets all the
> other registers obviously. The status and clock registers in marvell
> case looks to be merged together, while they are separate registers
> here, etc.
>=20
> I guess it would make the code much more complicated for such simple
> drivers, so I wouldn't push too much for merging, but I guess it's your
> call.

The thing is: If there is a bug/errata found in one driver, it goes
unnoticed that it probably should be fixed in the other, too. This is
why sharing logic is a good thing from a maintenance view.

Register offsets are annoying, but one can handle them. There are
examples in the kernel tree. If some registers are totally different
they often can be encapsulated in specific functions processing them.

So, I'd like to ask you if you can prepare a list of what would be
needed to merge this support into mv64xxx? Then I get a better picture
of what way to go. Can you do this?

Thanks,

   Wolfram


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRt2qgAAoJEBQN5MwUoCm2Zh4P/24AVwE029AjTwogssgqpDqB
Sxu2EgneUCIYq5WUMbUftl6YxAgXOYm3AaflRj8RSthK/IH8O7ZN96Wcj0ta+gZb
LMEhjoDtgbJCMOEinwz7LXbSVI5RjXUkObwLYaZiz1mv4sB6j7JcgPG54W6npSov
r0o9QqrpQJ8W1YgA2PU7kc8FalsctbogkMu7G0Dcc3P9OnnWfubJ3XTh5DEcI/dQ
Yess2kx58LNA5mkXfiHw2xs8hDm6/rCM5BenSrfXUHXu33igkUNI3nrI70LXmYeU
35j8cT6OhqkCj+qHCeFYG8WkCRNYga1y8pLhkfM71RYrfj/QOwqMFfufzHC8uWwb
rlYKDQnQtS9CiXAVBNDye1uwy1uDm9Vl7vqlQbU/12sES+wfktZxN1TySPh5NDvw
QbPjrwWq1l7sSIMxAkSGEKjTFxrqAZOyZwNyK2CL+LJjAupR3Hh2cXASN3OEUwTf
SfbnmXPLxUJ+/BpQ76KR/iHgJ/8aUbMlfXh8XlTJPy5VCzv4yyvySekXuWZX/3xt
kcG0GMvbEtDngNC9WrO15hxg1qK8Ta/aSgDk0edb5KQxi30ZleP/Xbjx+6kavJp6
cJqjnC6v+eamqkgXYsdcev8sgYZNRnOyiZlEkbAJka+2amsAu/Bvj4KL+uldauJR
uwY9O8p+g4uLwSV4zSmL
=7ZmC
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
