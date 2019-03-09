From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Date: Sat, 9 Mar 2019 10:42:36 +0100
Message-ID: <20190309094236.GA1340@kunai>
References: <20190215090202.157100-1-hsinyi@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0587128818285975164=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190215090202.157100-1-hsinyi@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Jun Gao <jun.gao@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============0587128818285975164==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshol=
d is
> 0 and msg->len is also 0, function makes zero-length allocation, which re=
turns
> a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause la=
ter
> code to fail. Modify the threshold to > 0 so the function returns NULL po=
inter.
>=20
> Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transac=
tions")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reworded commit message to "HW doesn't support 0 length" and applied to
for-current, thanks!


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDioMACgkQFA3kzBSg
KbZAhw//VvjmWX2V1D7BqMoYtsWT9g6U9UWiy4+ovG8ttogdHVOKkDfaHp2IT58Y
sQced8n/GBZv4x9a7tK4zXazCOI0zNbUqXWfv4WPqqXCp15wNdG6MzokU1hnTGE8
WuTbXkgS5f/l+r18+bqwsuuk/0kMZ0NH+226y5BJQo9/f3mWefXNX5lgMumsN9P0
ple/6Oy6GS3bL7QyncE9aiMBJoJnjvpNnQBjVfvUt12yGtrDZvdQR5zQxwvDJMXw
oCtZtioGZndbsnBKqozPm5XtlKPrsCPeiHorrIZiOreccerL3ORkmMZgGJo1urRs
Uic7hyPiQ68SE5mbpzRer8GTZ19EhDNOyMEaoscYOQvlCiU3hcMijUJs/eKx0R04
SbU0Cwr1Bg1XD8pYvWOrf5rDeig1MEpknyZFguvcwJr14nB6d1ul05djL3K3ywJt
xUdrQgScWddJ8Rvj8MSNmxg52FzQHpXeSU1qXPsug7PIB3BCAXHS1gRpU66CZw9q
zlYsAIEAXCaeGuIPBvUvnHZyWUL+V/zgOfDvcIIQjdIueGMkTwnT/y2lSHzQRZI2
m0qabT7TEBC8QFAdwxoECWzOB7ImM6DS3xEh2h79lGVtvSU49Su23rU1pT18fUfb
Ca9kQqVfssz+3iD5SpkbD33LBBYedi9hV+665sC+DZeHmiXe3/8=
=KWi3
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--


--===============0587128818285975164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0587128818285975164==--
