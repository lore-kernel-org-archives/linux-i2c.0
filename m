From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Tue, 30 Sep 2014 12:35:53 +0200
Message-ID: <20140930103553.GK1325@katana>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
 <20140819151604.GU1660@lahna.fi.intel.com>
 <20140819153808.GE15371@katana>
 <20140819154555.GW1660@lahna.fi.intel.com>
 <53F4638F.5070704@intel.com>
 <20140820101814.GC1660@lahna.fi.intel.com>
 <20140930091949.GI1325@katana>
 <20140930094008.GP1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG5hGh9V5E9QzVHS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140930094008.GP1786-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ZG5hGh9V5E9QzVHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> So the only caller of acpi_i2c_space_handler() is ACPICA and we sure can
> require it to validate the parameters it passes.

Fine, I'd say. Thanks!


--ZG5hGh9V5E9QzVHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKoeIAAoJEBQN5MwUoCm22IAQAKsi1iYZYTUpeWpqnl1IUpuH
FOxEvL8xhU6s5bT2r4LwwMxwhBStYEmzuMP2sP3wwCFcEwwvBrRBsRB9K6YV3S3B
Ja+eQ7V4i/gaUMNBlSjbfNevdpBVxRwl/m2Cax5O/EscFaFGZCPVC0x2FLcu9FxW
h7FVgm+cs0meNhKYCTCgSuRFMghcBFYxTuinancdZkTWer50ysdhRzgyKcGLyN+a
PZwjUXcZIAaPTuj8JllsT8NlBf1U3Qii0cGqDmZvwXZEh0g06hGOKn29ASZ1Tlb7
fxMyPgBjxo8UNbaNv2oiMrJEROJwTJLO6lyBMGR8Q/TYhhSKqWcj51YGg7F6TbEg
+bm+y46P7sdqIWW4MKBQLMg7Ugyp9ghNWpvbRbjEUxV4WH+8OzJp0OHnMGhSed5b
n6vjCy+Di1fdmQYd5lt8rhAv8cUQXng/wRP4C1jH4Bqp9X22YsaGaj9iWsBR9K2j
P9bCmn9iDdq3ZnGJummnSnRP62gi7mS2KJaUN+aY/1rZct4wlt+SN+vbJ9jpjxDw
+p3wvEvJo9UmBN+vlR2ei+Z6tqGNmWMOts9htROXtI50/Pb1BM3jnSzZzGG8wI63
9NckKviVe08Ssuyi0C+yCtCNvwbkCtHghbb1WkhznDrReU4T4atPLexzbPEY4e5r
PtQVEClNhUg+2xfHXAi7
=Lhf+
-----END PGP SIGNATURE-----

--ZG5hGh9V5E9QzVHS--
