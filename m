From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-pca954x: Disable mux after 200ms timeout
Date: Tue, 26 Nov 2013 10:06:39 +0100
Message-ID: <20131126090639.GA2568@katana>
References: <1385447520-3306-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385447520-3306-1-git-send-email-mike.looijmans-Oq418RWZeHk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 07:32:00AM +0100, Mike Looijmans wrote:
> Leaving the mux enabled causes needless I2C traffic on the downstream
> bus. De-selecting after every request causes excess I2C traffic and
> switching.
>=20
> This patch implements a hybrid solution: After 200ms of inactivity,
> the mux is disabled.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>

You still haven't answered my initial question. Also, please don't
resend without saying what changed since the last version.


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlGSeAAoJEBQN5MwUoCm2+FsP/Ay72uYokHZl9LlYzQsua0fi
amxhg0hHx9aVV0JnK3mURp+T9725y/zYOXkijPiT/rMEvDpd5jYUPsWvdB/gbSL9
CyGyeYUr6G0gUFE/pjP7VFpEMfDo/6lsDWSWFc0grsiN8nJS1pMqGxp75J5i7d3U
53k4brLxkDKgq2LzeIJ4YaJ+6zlkC2Cuk6sC8LDAtABCjERPfxn8WZ5V5/Uq1Avh
7SDpKyDkoMygJF9hzHcWg5qa4pfRmIyqWIBqdmtZIpCQrExF1gSvqCZw1Bm4Vmab
vBPkD4tF5aTiiymj71mXQFFTCJqAP5pYgIAV2n8Hp1mSj04+vG8ruBbQtNqsKocJ
/3wSPQrRDP1diuPbf2RPSroMXDb/fUQ86cd0XMynJO7qeJIpwKwGeEkJ0bqY8A0h
91ytsulEhodkOyhNhKEdMJeoU7SUhVn6llN0n8xAVMCRRrO2eEIUmdu1TMErRPlI
fy+u05AS4IH8R+aBEWG8kUWEvx3YHDijtlB6qEvFVEMbR/9qrJF0jWc8y9HVR2OF
kJG2f9vdtfyDfqcY/ks+H7RVa79MdU5lEYJ69QQyyYVoxNZjUGO9mGWwv02n641T
1qB4Iw9Rzws2ub5XdVFSkGrU0GXyk+sCNBy95dw4x4koOArCQyVA8MFdpEB4N7LG
CC+yzaP4AyuTJoNkTgqT
=pQ6r
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
