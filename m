From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: ismt: Separate I2C block read from SMBus block read
Date: Thu, 5 Oct 2017 14:41:33 +0200
Message-ID: <20171005124133.7ue727bib2mlpnyy@ninjato>
References: <20171002124519.GA13496@leonis.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ywzzlrggxk3icg37"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39247 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbdJEMle (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Oct 2017 08:41:34 -0400
Content-Disposition: inline
In-Reply-To: <20171002124519.GA13496@leonis.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pontus Andersson <epontan@gmail.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ywzzlrggxk3icg37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 02:45:19PM +0200, Pontus Andersson wrote:
> Commit b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for
> block reads") broke I2C block reads. It aimed to fix normal SMBus block
> read, but changed the correct behavior of I2C block read in the process.
>=20
> According to Documentation/i2c/smbus-protocol, one vital difference
> between normal SMBus block read and I2C block read is that there is no
> byte count prefixed in the data sent on the wire:
>=20
>  SMBus Block Read:  i2c_smbus_read_block_data()
>  S Addr Wr [A] Comm [A]
>             S Addr Rd [A] [Count] A [Data] A [Data] A ... A [Data] NA P
>=20
>  I2C Block Read:  i2c_smbus_read_i2c_block_data()
>  S Addr Wr [A] Comm [A]
>             S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
>=20
> Therefore the two transaction types need to be processed differently in
> the driver by copying of the dma_buffer as done previously for the
> I2C_SMBUS_I2C_BLOCK_DATA case.
>=20
> Fixes: b6c159a9cb69 ("i2c: ismt: Don't duplicate the receive length for b=
lock reads")
> Signed-off-by: Pontus Andersson <epontan@gmail.com>
> Cc: stable@vger.kernel.org

Applied to for-current, thanks!

Might have been good to CC the patch author of the problematic commit,
too.


--ywzzlrggxk3icg37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWKHkACgkQFA3kzBSg
KbYzDQ//R/Rhz9GdgBsT9ma89BwuYPAk/sj7h8ZoCIdwovJbCvJD7+EqauJw1FTh
nJjZJWrEs2LicOoty2tC6qcV/3fb2MPPPGMNnvKwsQutfD5+nyh3EtmkbbeldizM
7jHbj3Cl6Z4HJWnh9A6iftpYgH2z/jXsE2HSZq3ksc5OjhWI9gjyURt7PSG4tbfl
jwTkRZHxczaqeHyLQPAqVnPkA4KZwgJn0gW0/94qaOXStG3mCVC/9R8D32IzBJnl
E7EZRLiCc3TliHXUHv1iiDLiyDKBqEBQhSlK/vKG/5uInzTpk74nYPuuZV6Poe5s
bWO7p2l8cTRfxABHEx7J5zyd+d+thckNtfwxROWirFX9UGTKWTokOWklVlI9vcLp
71wU3bK3wa+K/ltUHR0+bzyr3pJuRyByq1gy/u0iO9p5s7YQp6IrNDIz2sfeNisn
L8UpE1pmLGQRYTYa0xaYAf8o9PNONx8dEPaaYvxJLSOxw9OnOJcRqYcZ+zeZK8RS
SPUAcXGE+2p22r1fP2DbRpgjpxJWSzskcFC1WcWBctlaAYDAU5+72tj29zxozW+Y
cpP/uGQkQTNyHMnJRIfa1VIbYkhJGBM3O4IkU6YUiTkWPWFFRtkz7PltHFz0INQf
pOmRwJ7+Sr6Zfo8+9v8Tvrarx49zK3Jrrw1kqTM2kxlj7pYijDw=
=yCDI
-----END PGP SIGNATURE-----

--ywzzlrggxk3icg37--
