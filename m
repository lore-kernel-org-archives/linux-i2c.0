From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: sirf: reset i2c controller early after we get a
 noack
Date: Mon, 19 Aug 2013 20:05:40 +0200
Message-ID: <20130819180540.GD8626@katana>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
 <1376385091-30597-2-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376385091-30597-2-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +		while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
> +			cpu_relax();

Are you sure you want no timeout here? Same for patch 2/5.


--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEl50AAoJEBQN5MwUoCm2X4gQAIyuh4fYno90xeSk5aDHbZd1
QB41qhI5O4dT4RHfOdmQIFhgygZFNNP5O0bavUA+9Xx3Uc3VRGSU1tOver/XPr0K
NTDhn4nxUby965UEkeCU85JgdeW/ydwoOYYWadvWFewCjiODhZr9/Uxby2X0cwLM
Q4G1zik9GtQwa6xnHISx+NBEmNlc+uZIOg/TeP/QwBKfkI9LdIqyyhbt47Kskawq
TfVmw7HRVQGlVEyEQ+ibe0HtyZXU8j/WyvKPUZugjGsx8fdA7hpDTzbHIRn3c0fS
SpI7E9e9vzKRMA17JzV1km1mbpVtoxal94K+fBR6IQG1WB57KQylLegNn7poVI0o
mUv0D9dU3CRF+U3TngjYaFsUog/F8g1S95fEjROuzbVSHBt7+66oI0qa2Z+VGa55
IbONVD6H3LwwyTSx6nCjFGPALCa3oOrZP6ku8invf0KmXwnXFsMhbMZ0WWPpzE1o
FUZXE8js+vhyjB5uy9kKGrvokfNDD/1vMeEUG1NffYXnUx2GH+J+DjzohrXdDNnH
D/2vBoL2t/GEGX94xn1Wyx4z/MAsTN+49wEnJcdjDyDv24XE+GRT9xZbGB6uiEdb
WpFiqlDXGSXXC/bSfypFsXsy4x05JdUXUDvlXD++ct2o+aSAWJ7jmLjIMHGHZf0q
vkDsK7LdY3HzilMsuzU5
=gb4M
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
