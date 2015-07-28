From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 6/8] misc: eeprom: at24: clean up at24_bin_write()
Date: Tue, 28 Jul 2015 08:11:52 +0200
Message-ID: <20150728061152.GB1598@katana>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <1437945533-27996-6-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437945533-27996-6-git-send-email-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 12:18:51AM +0300, Vladimir Zapolskiy wrote:
> The change removes redundant sysfs binary file boundary check, since
> this task is already done on caller side in fs/sysfs/file.c
>=20
> Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-current, thanks!


--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVtx0oAAoJEBQN5MwUoCm2mIYP/RYL4JhTGhPfG+eV2jyj0A96
eq8tKJGMjNuyiCQqA/Ms7LzCb+AAT+aYQJCL6irY+j1OOLypIqiOVgneTXFs9SRh
unFx0jbksGGqgDGzDQsS5Im8JhOhVWMkA7W2cGxuzRZwoSNC0N3CbOCnf6GMMIly
/izXkZIXi9LkzWJiqg1ONsTPpgZP0ClxD2chvmDIH9JH6VY8iDtfhMdn44cg1SWB
WBhQD0EDSL523SCF6PBIH1rcupkLqhDcz6uq3kPbq5S5S8+StA0f9Ln2XPTB3AMg
y6aDPHieicBM8cm7E6dT1NQL3GPvR+RT+PTzHvW6ojR1CiPpf7xKaTdViOTeFGgR
a9323CRhhM6LIeODPOq6CvZiRyYLVSqoE9aFTIzaRIl1Hs7Yc5LP8rI9Tn/pSkgN
ZeY939wETDnv4xjmEZH6ecnD2HMn9liquHKRGU1sow2FJMFlOTcYcR+PcaZN9ibu
KPn0urVWlFdD3nxsjGxwfz71e7tFL10b/skuGO9MVHwv/bvNG7TAyWWdCQhquA4G
MdeRuMhjGkhKNPosOgCrPmvqm8xj1ZfVpVERC0dXr1DJ5E4GU0ozmoQr0ZRiPao1
F0m5+6E34O3bhxdIxVvGM+XU/SI7Bufbxpc/ja1ZkTJWoTW8hZyFUCzdsiPtVm9H
0U1KGqSh7EST7AlMXIyU
=QJ3v
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
