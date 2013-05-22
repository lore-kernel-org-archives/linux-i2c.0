From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/9] I2C: mv64xxx: remove I2C_M_NOSTART code
Date: Wed, 22 May 2013 14:05:18 -0500
Message-ID: <20130522190518.GA1627@sirena.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4vH-0004Jz-F6@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ql8kEnBvSKutFqgK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1Ud4vH-0004Jz-F6-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Ql8kEnBvSKutFqgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2013 at 09:37:11PM +0100, Russell King wrote:

> As this driver does not advertise protocol mangling support
> (I2C_FUNC_PROTOCOL_MANGLING is not set), having code to act on
> I2C_M_NOSTART is illogical, and in any case isn't supportable on
> anything but the first message - which makes no sense.  Remove
> the I2C_M_NOSTART code.

There is I2C_FUNC_NOSTART, though if it's only possible to use it on the
first message that is pretty much useless as you say.

--Ql8kEnBvSKutFqgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRnRbrAAoJELSic+t+oim9ttMP/RkBX5IjKKly4JCGKipu8+3R
8N9RZnHJmOipsgUE0ym0hHwmlDPG3tld7TBcwK5xamdy9Q+E6RPiVjBwoztS2wTD
KPfbMRdXyTbCHPN/tocC4UY92rN46HGp7XZN+L1cc9wz8DupO5gaSjNfHXnJQLXW
uW/FkQPvk1GOvxDxom4XnJ+BTUyTvGTgPRRi7hwavVqz4PNGUTOJXYvrpDu77yeU
RAeCaRYXX0UgyMDV3k3RXEvXQxNXDJz3YBr+7KwsKhlxp0lwPlCHfOAiJCbeHnL0
F9RAkqzpZoAjL0zNpdV4ILFqJAbW7hxHtVPxzOvGubDy+rIzcn4JhrWdp8XE6PEv
NasGUaoGzbAHDE67Fk0HkkR6l9GMIE86ie3JjxC2ESlWTkdjzKqv/NlkZaIVZcvA
Ppu5lcTIwFh4gTY3Hc7b4Y/L/360hW8sa+yqKSbfHPCRqopo5h2cRL35Py9LrJmN
Ft7TBvNK5dytHc3k+QCxTNO3JRkMLwBpwChRi0JsnV7QkA4TnXB8myOQTCFr4ulA
wuOXsPiIQwdlg0A396Ho2NPk2cb/dHZF98OmKFf0qBKndt20zJPKnb3dQcO4puRA
zeY2bvjzVVlXTCbTpXov7f8YX0x3hJf6LsbEuufAVUquIxNpkueGQ9wPnvoaLGpS
IhYKSpg80nWYTx5nUouU
=zPby
-----END PGP SIGNATURE-----

--Ql8kEnBvSKutFqgK--
