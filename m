From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] Documentation: i2c: Remove obsolete example
Date: Thu, 9 Jan 2014 23:00:27 +0100
Message-ID: <20140109220027.GD3866@katana>
References: <52975B11.2090006@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52975B11.2090006-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Helia Correia <helia.correia-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jerome.blin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "Correia, Helia" <helia.correia-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2013 at 04:02:41PM +0100, Helia Correia wrote:
> Documentation/i2c/fault-codes illustrates EINVAL error code
> as follows:
>=20
> "One example would be a driver trying an SMBus Block Write
> with block size outside the range of 1-32 bytes."
>=20
> However, the actual implementation of i2c subsystem truncates
> data length to be 32 bytes.
> Hence this example cannot happen anymore, and since it's obsolete,
> let's simply remove it from Documentation/i2c/fault-codes.
>=20
> Signed-off-by: Helia Correia <helia.correia-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---

Applied to for-next, thanks! Although, it can still happen that length
is 0... we should probably check for this in the core, too. Anyway, the
example is not the best, so it can go.


--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzxv6AAoJEBQN5MwUoCm2xlMP/2/2xd498TEkqeMNNqezsbO8
ieJdFcXDkZi/dMQBIw4QydywiHgZhCBbTC2U36oLkB3NlClIJKaLhn1isUyqkP9p
R+nHMSOgKD/CwbKt21+kD96Q6JFPdh4Wk1b+TDjswPITfR6MtGKuKUonkrVK7D2/
/0seHSku21rNuKZPW91vHHXellCtYMGHs3T4mxCzNfyqWF04v4j8g3wE/Zg3cJZh
CVrvzbNMjBlySdAJvTZ3Ff4N3Lcwns1HA5uv4LcpP2lg1mTubOzgN2ko0nDkJs3P
wubFgU3uAuxphQpyWsyHx47lEzJ/FMW0sWE5rXdUxDF2cnA6pJC9d8ayXmFwxDdg
mxsuVaKU0vy1A28mldDGylqEb5QINKr7ahDZvPEesO1RnMJGdRyoztw91Y4CH5t/
lBlTal9LaSYB6zcJlCC+Jd01Xy/eLUnhKhOGzCJ+JlGYQQSC5u2iVLdoKL46Frui
KrCsTNZgQ+IdVDKn51otNvj2NswuY88NgGOkYqUKFRhy5JMc8K8ZbvYo3HvvOQP5
g2RMlsolqxmYI0W1UW0zQXPR1w8dGZ6CAkPFfKPqBpcSRlvtyqZIFYhvkBN0y1yJ
3TpwjO3iWvgvF3Nyh40+mgo024Hl47uh2DPOs+62jI9u+ZcDzrHj1kZQG+gOf23r
ognWtcjyEcLrOGCSh4vG
=EbfL
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
