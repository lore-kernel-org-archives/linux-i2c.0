From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: core: Map OF IRQ at probe time
Date: Fri, 7 Nov 2014 19:05:12 +0100
Message-ID: <20141107180512.GI3656@katana>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414677578-27412-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414677578-27412-4-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 03:59:38PM +0200, Laurent Pinchart wrote:
> I2C clients instantiated from OF get their IRQ mapped at device
> registration time. This leads to the IRQ being silently ignored if the
> related irqchip hasn't been proved yet.
>=20
> Fix this by moving IRQ mapping at probe time using of_get_irq(). The
> function operates as irq_of_parse_and_map() but additionally returns
> -EPROBE_DEFER if the irqchip isn't available, allowing us to defer I2C
> client probing.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnhk3lzF8UVTdg@public.gmane.org=
m>

Applied to for-next, thanks!


--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXQnYAAoJEBQN5MwUoCm2g2cP/jW/N5+nMiPXmicY8QfSBbGy
XKM5710nnjfAcSiJ/L6ZglTp5T+15MC6XTmUpsgOq+R4L976jeXbNqu4YLYftf+O
NOf3eigmV6f15RDcSAxs7SgDmVMGAAIiYZBYmsJgkm4N5LoOtuQUUlDdZ5uQ//8M
h238/QnZUy12F8n6RNaXJO1P7bszeugEABGtOVMkLX9pCRfj4zmiKYJEX8bwwS5b
/WZz4uZxP3kRjEyuSLuJMYRPMTFeKyOjCmVrnKgV81OjpsjdYaPWi1fTb8tLEjBI
G10K10kaWIsCgcNdwDzcJVEoxf417OqfWfaw7ejCCP2vQrwEPCHMNxhcQ9hVlt0t
F8bLxtNM1CM4mhzCTjL+XoPcaDX5XPWbkgmLPUqjmJLtmyKjZ2jOZeoWX6KaFab8
Dv5S7TVu5ojrTVcL45CMxi4eu/nQo1d4ZzdYSd1jUJTfUzNW7HYD47YmYS2R2YWM
hqwXpHhBsgh3PzXAgcR5qyjEnxPZbjtZ2wX8zKtIV78tu6qhi+NXWnogS3x1L7ti
VVzZvHn/fHRfRhR6nelR/zWdupQPyHNyy5IPsYWqEb5+pM14uKO8eWmQLQzygkl4
jeOQ5mwvE86rM2pbSZnVG0u031vVfNgk5GxBR59ucKcWPEh51M7ygsT8o0Bzdz1q
M0972iRYTlB7Ud97XLYB
=xCTs
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--
