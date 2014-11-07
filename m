From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: core: Dispose OF IRQ mapping at client removal
 time
Date: Fri, 7 Nov 2014 19:03:37 +0100
Message-ID: <20141107180337.GG3656@katana>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414677578-27412-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414677578-27412-3-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 03:59:37PM +0200, Laurent Pinchart wrote:
> Clients instantiated from OF get an IRQ mapping created at device
> registration time. Dispose the mapping when the client is removed.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnhk3lzF8UVTdg@public.gmane.org=
m>

Added stable and applied to for-current, thanks!


--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXQl5AAoJEBQN5MwUoCm2Ui0P/jSzEwsDjCsMoeeOatPTqFGX
9wkRsWtpCpOKNTObyhbr3Tdq1SxA375h7IG5Uf7tgyTPzcuj5rjIDuDByaiHuGiC
hJrgk3QmGkJpsAllrrZrsVANlHDgDobFS50MIRV3UaJ3s/SjVPQWDvJgsOtiBrE2
J5loKiVvbltKNCh2D2EXlxLDHNS+5F7SQ3uDl517TbMd6nAsXmGVF2/v/DJtAKIz
sp/5AS+jpyQ5FmXvrfkwYqWAcGgdJ9VpBi5EF2VU6stARcnmVtDuoh4tB5UGEjzW
47HZZ48QKQ6psiunkIO2SDvZ5kBZJQLeAPqBcFeLXIMNcLKyt/StSOoq1rXQpenU
BiRGczTKBJcT+iEGgyinI0XfxUp03t1bY3Vtp6K35qj+m6RF8Zr7iSVIkVT7LO4+
b4K0UYL8ccxP/MP5lTeulThq9hrWdJY81Md7DIUrZWieIcP7tVMmbn1qhB4W8KWO
3ykW5p4t2n+OKd+mIm5pROrfoRSEUUp3pMg0l5szddMRz3zYrbynbikqMVeKHeVN
Pzxt4znsIF0r/JQqd7bVzJu4MuAHW+sc38nX6bcAmd+vqy4al6SWK0F6S7cDT2Vj
pG1ZvDHFP90Crf8V1uIxFObrC/k/FqhxsTzcVTWYlbwHqqa2zxlggDl88q20tOEH
rSl21MsQrwFHptOpBwpG
=tdaS
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
