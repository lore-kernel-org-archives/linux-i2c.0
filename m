From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
Date: Fri, 28 Mar 2014 23:46:02 +0100
Message-ID: <20140328224602.GB29200@katana>
References: <1394762863-12154-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1394762863-12154-3-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394762863-12154-3-git-send-email-bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 07:07:43PM -0700, Bjorn Andersson wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm =
SOCs.
> The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data =
path
> engine with input/output FIFOs and an embedded i2c mini-core. The driver
> supports FIFO mode (for low bandwidth applications) and block mode (inter=
rupt
> generated for each block-size data transfer).
>=20
> Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>

spatch told me...

drivers/i2c/busses/i2c-qup.c:481:7-26: pm_runtime_get_sync returns < 0 as e=
rror. Unecessary IS_ERR_VALUE at line 482

Fixed that and Applied to for-next, thanks!


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTNfupAAoJEBQN5MwUoCm2vgAP/0sy+c7P05c47UXrpegR3r65
tt29KhDKh6iKzCEUVmmL1MnhY6R59LI2StK9rCusD2reXL9RdMMoA0koFLmBLIe3
uCKMS1tofy3KTLsDmEuik6eEwRgeMmZLkGt7EHrbWtJhrfQD7GNyP3Ptg5BUNKFZ
41cn4GhR9eF0yqQTKIM/ILffoCTyG4BNP4ZRzbV35UxUzjjjdVYGHnvFg9GMDoHV
3sxyc1l3O4Qz6B0io73fpbO7U74lD7FiTM9xg90qnJ/O9jFR2bI1uUxAoI9sU76v
XGsvOzs/Jsk0EcRgwo6ur/GI8xeekL3Tns4khObtKclE9hW9S5bxbfdPZ/i27wA6
O25FyORBTuwYPfuKP4O3bsrMgAdmGoXwcwSpEFyH2EWpN2iQ/1uY7jFof2+ODtX1
3+kWOcyPtIF8k6thVE3GZ1Be/2k7nifEWhMLQ3XAVqneaFT5u1MSF1IA1X0Eh757
tis+cdStqfG5JOWa/z2LrXc543MbZJP87MtXd+bWFoRkKCNu8SofPFpc6uq1t7gV
Dr8B8YwX1RDNkQ7VjF2GpQoVKICEbYCZuPhc1A5/Yjz7MqDuRQqHS/RKSR3OKxHV
+24HafNlhl43hC8i7/t0Pl/NBOTHXjZSqnd4eE/EYGtYxYr8YTeNljlEhhpjp6J6
rq+1N/B5P+0oyoo+035O
=nxQl
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
