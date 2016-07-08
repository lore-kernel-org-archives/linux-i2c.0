From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c-dev: don't get i2c adapter via i2c_dev
Date: Fri, 8 Jul 2016 10:31:54 +0900
Message-ID: <20160708013152.GA10192@tetsubishi>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <c2ac0349b818d3f3787b939d5eb83e3c80fc205d.1467772840.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c2ac0349b818d3f3787b939d5eb83e3c80fc205d.1467772840.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>
List-Id: linux-i2c@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 07:57:06PM -0700, Viresh Kumar wrote:
> There is no code protecting i2c_dev to be freed after it is returned
> from i2c_dev_get_by_minor() and using it to access the value which we
> already have (minor) isn't safe really.
>=20
> Avoid using it and get the adapter directly from 'minor'.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to for-next, thanks!

Jean, thanks for providing the background information! That was exactly
the missing piece for me.

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfwKIAAoJEBQN5MwUoCm2Bv4P/jSV7My2kcAEtWeoh6GhWP9Y
Hh8HaTMSAHQVM2DTCPuce4bPuv9jDIWI6ETTU/zcEGI6SZhNjqPGrJdagAslza/d
1g/5Ag5hMqeGPe0KAFvzi3xhQqZ2XDZD3mf3jtrEcOQofQirmBthNfJanrU7bb2Q
7smfxTRDsDnA9fk1HkgGEtsk+z53PK7fU8n3PqgvvvU7tbwLT4+AL3mFmSWYTGTq
1A1y+RRb2OYC99oaHEOhDJohZYCfT2QuX+UXdsiQusgaQQMy5O8+b9MT6soxm5EU
4qwR062QTVdexBcK7koScp8mMWuj+OI95BUt8yxtEeHv9vYpo26YADV25nVwMpFw
JpOwSDy/3NsFxg0qcEGmoaXLCv1ctViZxeig2Cs4TiBh7psbarTVeaVRt7w0dclw
b++av2b4HsMs9gKT73mRu/9nF/UhMjywQuuNP9F+nkJzUDWolAjQdu5rGvNolZ/J
6PNZo3q15bzHkFCW3jUeV8oaqfeY+FUHoeVIe6fepakX+vWjUItM5OO+RQp4l/0r
NI88c5r40UJ0TFUqDaOxtQEa9EFNMPlFvqTPHSaK3Aa0c5BJ+S0rbjWWlB5/EJ5Y
I/NW5bR8UieoUDJTuquZUIEWtNb8POQkbxfH1eMGX0EKBf0UU3TTcsLHXcfw9/6y
YFvRrH/xx21uoNBEXCIh
=mpcC
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
