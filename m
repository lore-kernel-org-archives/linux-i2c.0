From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c designware make SCL and SDA falling time
 configurable
Date: Sun, 9 Mar 2014 09:20:32 +0100
Message-ID: <20140309082032.GD2575@katana>
References: <20140116194303.GC4127@katana>
 <1390236223-22584-1-git-send-email-romainba@abilis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390236223-22584-1-git-send-email-romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 05:43:43PM +0100, Romain Baeriswyl wrote:
> This patch allows to set independantly SCL and SDA falling times.
> The tLOW period is computed by taking into account the SCL falling time.
> The tHIGH period is computed by taking into account the SDA falling time.
>=20
> For instance in case the margin on tLOW is considered too small, it can
> be increased by increasing the SCL falling time which is by default set
> at 300ns.
>=20
> The same applies for tHIGH period with the help of SDA falling time.
>=20
> Signed-off-by: Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHCRQAAoJEBQN5MwUoCm2FJUP/17E0J+WUwcZkB4MWPXkGE/e
rs4EgmrjtGNIm52Xfvu/UYXe79t4i7ySxrPW5gz1VoBzGXg937i4BG8Piva+b7Z9
OFE59Nh4KpCEdBLyi8Wu/FfoCmDAwULK4qIk6fo1ofrAlA2KuAgSdSSXjY+y5MWL
S2tmBGmXcsBERbIYobcY9fAapbzE6f8TNutG5zARJOliievWjB21AW8lK2mxFKla
isoHEJQMPu/EnqvhCcDK2RfjmelrJyAZvulOkIicYeVY113vIn0QA+UBRiSQ0It0
I2bdlhGvuIzDlPRZAfcesCFQxPs1eXN7BzbsY2dFNJgJSf+CUB7EMQ7sx/OJ6GuW
ynU+mkwfLV8nNCOyVar5IH2VNMY4L+IBbmoE7ULKtLig4UNheFnZ8AKxEiIEYD5c
5OnlCCfxC8F9iKRrKGM8ttgM/V2tuP4GQWhMUttrLxh5KbS0jnpF4VJnPK7mXDUa
uF4Mcs+Bz09lj3FGl8MWAXyF/o4NdFHpZftwzL1i2yil5/jMFjILSA/UtL19JQWQ
Ka+dLf+yhEkY5zwUZ2kQU6vVekO4Zk1YVcKFc4tfIEQWznz35MnVAgo7vmjc2Y7K
89R2MM9b9C9waWgGNFZA+Dn3CiqHDV6ceYF6plp9DY7cD3fzKU7orE3oBqMFlyp0
omYfG2va9Sb1GM4sL3Xi
=iloF
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
