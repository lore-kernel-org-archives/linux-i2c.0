From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V2 0/5] i2c:ocores: improvements
Date: Tue, 27 Nov 2018 12:38:22 +0100
Message-ID: <20181127113821.GB1107@kunai>
References: <20181029145051.31984-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181029145051.31984-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This patch set provides improvements to the i2c-ocore driver.
>=20
> [V1 -> V2]
> - replaced usleep_range() with udelay() so that the polling version can be
>   used in atomic context.
> - added dedicated patch for minor style issues
> - fixed delay computation
> - use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is alw=
ays
>   necessary and a trylock would generate an extra interrupt for nothing
> - make the driver ready for an eventual master_xfer_irqless()

Peter, do you have a time slot to review this?


--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9LK0ACgkQFA3kzBSg
KbZpVg//Ys16rW3F1UCl9U1nMvkuhOP/F+yTVZJUgObOPYYh2kbw/V2M1RysAEW/
gcYbHiC9Q7S+MDvn9457S5PkVmJwdEQZ0lbSKHdibFvJh6TxCNNpze7KzO+IAfVf
KUh81g8NOjNQRPfsZEFMOlgOzFXOazfV1HHoj74JQD9rnHYBnZf6FNCq4gVJaOT6
HcYsGPtLk35r1l4H3XKqBrkIXi0c1eTLXKOSd4mSbxbKvM1GKhiIKOfaXt5Kbqjq
CO3PMaGl1PIYBNMWF1xvI2VOKRVv+sVwF4qOOidV7UySeRB/nYvlVLWOyWoLMlD8
jtq4UY33tJ+gWOfo7cDYJaleHca3TMemoSsE4tPM+E/vrDRf8Erhscmd3soxbAwt
RnM43/J1BTIJltlY4l7dvIMxTN8DvQBwqgV6Klmfvt0PMTd87oH62zmOR9ati3fX
mZAVkyBlFKqtfcwkKl3hSW7FRzKX5vsA2fIJOLIVgfnSL29bx6LKLNhgN03UYCww
hlfijx9iYVbwZ7qw/B8sOiDm10X8tlIeY4ixZun27caRltWxXT4/FVSd66wOP4OS
9DTi0A9yCDavEa87a7n9uoQiBowTwRMQMW5sUnB2d8j8WVYtL+HZp7vQzGeGcASo
IcrF+R0l92d/lSMVexIz1Ge0ksip/jYQnCdSblCgptDDZ27towU=
=EItn
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
