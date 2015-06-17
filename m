From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c-tools: add Android.mk
Date: Wed, 17 Jun 2015 12:46:55 +0200
Message-ID: <20150617104654.GD1517@katana>
References: <CA+TH9VkQzJaSa0okxK+s1ukpaqgiWegh3uumEb63LzZwBjV4nA@mail.gmail.com>
 <20150316101626.2c7a02be@endymion.delvare>
 <20150617102917.GB1517@katana>
 <CA+TH9Vm7oKH43S7j5G2_iQi7cF=y3G04V_nrswQ+6E1J6JNbOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+TH9Vm7oKH43S7j5G2_iQi7cF=y3G04V_nrswQ+6E1J6JNbOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think it's more a matter of a makefile approach. They use a non
> recursive one (recommended by several papers[1]) and it's up to
> external projects if embrace it or no. Honestly I think that a
> minuscule file with really low maintenance should be added.

Isn't there a central place where these android makefiles are collected?
It reminds me a bit to buildroot which has recipes for packages like
i2c-tools to include it into a rootfs for embedded systems. There,
buildroot is the central place.


--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgVAeAAoJEBQN5MwUoCm2gOEP/0Nb2o/DVevdHSeRebtF4N48
ZmZqBqsXmaKo0P3qdsdXohfBbzv7wiZvv1fc2z3Vju8F5HcQRBPAyiZSuTc+Llfe
/pqpnioYKlNHTqijJcWw3iu7oH7AJk9e0ZcKW9L33BU2UjnadNXLNAO+TMa7vY91
ZuSrmfacvMFPszk4BYyNEU5ZOpplD/k1dhPT5MgjMq7dK3XFkWRGvjFYRE1ApnVd
1tRnl2ZJZHW52WqlabUhmGQClWbZLcyVpL3MdFMeUcqGsKMNpTdL3NBkaPXh3uYY
J8Bm0dcDWxV2JrLbNn+tRFtifLLTm1vmPzpJGe2meR+dtxgqAuN6eHUpENlnOAXm
cRSppYtQ220OjTyBQqppkqa2EhEnbsk4jjHpHDRLQzk8wOXRvrXWLNnYNK5N5TLq
kpPk+Fccyp6Zk3VmnyRxu3vat9yEfQW8A86NSp1oOWYh3TUW9OpGc14qDSCRQ4n6
lzRcYqxHX9s/8eTp0aKNRqk7iNrPBaA92GFzAVeXuQaXV22bjpG7modW2QfK2BxL
DJajcYnufsek7Q9gEYReVNanf3NfBMfTzUrVlyVpMIlleBiMMpDX3xm3Kg0pQSoB
nJ6SolQQGRGpQ4HOMbqOV05+ATtkoz/rn3jh9RS4DNuvBgd3fSrfvBhzU5YPxDih
nRq3f/P0VqOw7NpydppX
=4aX3
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
