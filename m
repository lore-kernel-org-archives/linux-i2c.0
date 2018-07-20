From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/3] i2c: at91: slave mode support
Date: Sat, 21 Jul 2018 00:41:41 +0200
Message-ID: <20180720224141.lawanibd7v4hmbym@ninjato>
References: <20180716094037.1843-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r4l6to62zx5hf5wb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716094037.1843-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--r4l6to62zx5hf5wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> [Ludovic Desroches]
> Changes in v3:
>  - rebase (cherry-pick was enough)

Thanks for the rebase. I wonder, though, I recall to had more
complicated issues. However...

>  - fix checkpatch errors
>  - tests:
>    - hangs with a SAMA5D4 (master and slave on different busses) after about
>    100 transfers. It's the firs time I do this test.
>    - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
>    I don't know if it's a regression. I don't remember having seen this
>    behavior previously.
>    I think it's worth taking those patches even if there are some possible
>    bugs. It'll allow to get more people using it and so to consolidate the
>    slave mode support.

I really want to see those patches go upstream, too. But I am also not a
big fan of delivering the user something with known issues. Especially
not when they affect the main feature to be added. My rationale here is
that someone who is able to fix the issues remaining will also be able
to pick up and apply patches.

Maybe, maybe if it was to be enabled by a special
I2C_AT91_SLAVE_EXPERIMANTEL symbol with lots of explanations. I need to
think twice about that, though.

Speaking of Kconfig, I think this series needs to place a

	select I2C_SLAVE

somewhere.


--r4l6to62zx5hf5wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSZSUACgkQFA3kzBSg
KbYQPQ/9HBYWfbQzHSdXfcRkRjy6FyE1lPHwEY6WDryvg68TJpSa7Yk3m7WoSl8B
HdsRDvc2kZuOzLQbeo6Fq6c4NnwfXunqvzUt6Ljtoccnr+ZkLTQ9B7+VjgrE2YhU
5F9GBxPaj2UcyisdbFs8sUhseE9oJHgP8GwO7GmNLfEZhsJ4xICk2phiDbI+eIY0
QWphEdUoAGRS4UKo+pZxIzmAJFurPeDOSNSFrJb19EmKH4gjsR8SilVIsCoImTR2
TFJhos0JC0CCmey6zgdttNRPpd44p+uzpUm7lrfa9s0VUWY6ucZrXW8Mu+6WBUM0
WK74KCok/dq/6xzMz2y/bS1JKI/v/7DudyF3UY+6+8jLiUnX5j6oUGiy7AAf8szX
gDnXR8e9kD/iiipKvW/Kl+h3AshGsmLEl7aKAfuaeY9BXCa6AegFyA/dXxhssdhl
mvfp4pIFacZPyXYiCMq/O7cms9izLifXLc97Htn/OulVgV0uudvj9UUqTOdG6yx2
CVg8B1RWk5PiQZRBmLcRpW3aFue05nR1FlO3duObimE8aNswYsbavRNjy3qrTmW6
RriOEnoPpyb1LgGyEOWvi+J/LaPuoN/3BwebyF/E/uMByFssuBaU1PAl4nX648os
T6HggT+HuFF1L6FA4M68Am9Az9cjXD6JgjETTTsxQD3AGP+uVxA=
=QE0L
-----END PGP SIGNATURE-----

--r4l6to62zx5hf5wb--
