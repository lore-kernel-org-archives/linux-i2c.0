From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c-ismt: add Initialize DMA buffer code
 ismt_access()
Date: Sat, 28 Sep 2013 15:10:04 +0200
Message-ID: <20130928131004.GA3049@katana>
References: <1380066475-2119-1-git-send-email-james.d.ralston@intel.com>
 <20130926084032.GB3057@katana>
 <20130926144115.GB12301@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130926144115.GB12301-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2013 at 10:41:15AM -0400, Neil Horman wrote:
> On Thu, Sep 26, 2013 at 10:40:32AM +0200, Wolfram Sang wrote:
> > On Tue, Sep 24, 2013 at 04:47:55PM -0700, James Ralston wrote:
> > > This patch adds code to Initialize the DMA buffer to compensate for p=
ossible hardware data corruption.
> >=20
> > Take care of the line width here.
> >=20
> > > Signed-off-by: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  drivers/i2c/busses/i2c-ismt.c |    3 +++
> > >  1 files changed, 3 insertions(+), 0 deletions(-)
> > >=20
> > > diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-i=
smt.c
> > > index 8ed79a0..d3f30ea 100644
> > > --- a/drivers/i2c/busses/i2c-ismt.c
> > > +++ b/drivers/i2c/busses/i2c-ismt.c
> > > @@ -393,6 +393,9 @@ static int ismt_access(struct i2c_adapter *adap, =
u16 addr,
> > > =20
> > >  	desc =3D &priv->hw[priv->head];
> > > =20
> > > +	/* Initialize the DMA buffer */
> > > +	memset(priv->dma_buffer, 0, (I2C_SMBUS_BLOCK_MAX+1));
> >=20
> > sizeof()?
> >=20
> Agreed.

Fixed that myself so it can be in my pull-request to Linus today.


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSRtUsAAoJEBQN5MwUoCm2lTUQAInbRADI3C15To6jX3TM0wYt
krS584YDSCDOBqeqJfKjq6GRnq32e5PTCDZREOVqchbMnqNA/jVVwNL5PXKc4hXF
Iq0x98ALP9HzqbE/Rouebh+ak6703pMOHnNKmqfJn9kCHcjVtDv3YEHAI4QUTZl/
dMcr4V0F8J304fbK8oPIlhvsNpikk6iVWNtRe3/uXpdo50cuoQ4ITbJwnow3cNU5
R4gEWmP1zXj2PD6u4Bi385n77goIQ+VzXVA+ajAhUgmexoxn5L1w8WFnpN4R/ADj
9b6EAnipCqbU9+IkM4ZS9iAQrZ66guMnRSNK8Ny3Y39GPwFHqrFPpdNdf5m6td8q
vMTS1yIOSw06Na98pYNbyFYkIyNk0oxtfhvFSPTrrxrkmHOVKF/JjOgFO1bIFarl
2w5ZPdViotDeoNtYHT8Vk21nuQKrLKIXLslnCaaGt6/uXr8Qc7WfRWkpjCGHbenM
4PxSwSPiQa1l7GVsLT6qUxg0tZcyQ68IWX2h0sOJ5+HmRFw+mmj18mAe46urBn/f
m4ayQ4t2N+JvISnFkKeZdxCVYZEeABa99yRpz5ePJpFADTL8cG6FI6QrDMwWD4FU
aYmY+KutA5O3qyoVxJdrKdF+M824P5ksuC7dFaYuKxbkWZijmvoCUgNSHnfq4PP9
rCQze3AOeB+LlQ9Cl4Ok
=3KCm
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
