From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: MIPS: adds ralink I2C driver
Date: Sat, 11 Oct 2014 06:24:23 +0200
Message-ID: <20141011042423.GA1267@katana>
References: <1412970186-16030-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412970186-16030-1-git-send-email-blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi John,

> +#define REG_CONFIG_REG		0x00
> +#define REG_CLKDIV_REG		0x04
> +#define REG_DEVADDR_REG		0x08
> +#define REG_ADDR_REG		0x0C
> +#define REG_DATAOUT_REG		0x10
> +#define REG_DATAIN_REG		0x14
> +#define REG_STATUS_REG		0x18
> +#define REG_STARTXFR_REG	0x1C
> +#define REG_BYTECNT_REG		0x20

The register set looks like the one from i2c-xlr.c, only that they are
32 bit apart instead of 8. Can you check if you can reuse that driver?

Thanks,

   Wolfram


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUOLD3AAoJEBQN5MwUoCm2R2EP+weNRIVGvyFHgVujVGa7Qpgo
VX9J1aunrlV+xl7prYwpcppWWX0cznSBPD6ipAMUW9SmTOBnxLmjB+mOXeMCzfgf
RoKK/zS8ijMT1/4Varelduy4ToNRAVtVpgp6UdSOPGn0KU8REtiA7sMS7eg1TLKy
TRs8ka1QHXzKQ+C50Z25ol0S457H/n0WhwzVCfx4yI5O9DARA+rOWwA3dTUPdCPy
/lKyva4L+tsMZKqXDpG97AB+NXeS5f4NfKmgdcWM8KNiqz4OlJDSOSQk8m5CJuhl
kHq9g2Yt3w+bzhclxSI1GWAaqcTH0+/LARhqoOYDBlCAqMsxWcFTP/B19scpIgDq
4znnMiw5mxFQ3IZFd/v4TCCxTjwH7IQV6ncQRe+s2L90ApNHmDvJzgIP6ohWwCM9
t0oUdHyTZQra7YJPmYquqoinNSniS2M7g9Ldj2APW7xfkl+3djwzNztcPT+mGVEI
xmc2RA0HIrbqI1UTW4pvJaMgdoQF0GxYAdJO59ANy/RA1KfWWEM1Pn1sNoY8Kodr
7Sy0LF2HmNmlAtL1vh7f6FQgemAo530OXtvlpbztNevY+5YdtZSoD4z2VxzvJyXW
k8KomxOECJJ5PGUoXmxkNSAAnXE/IkrjLgZnM1nhXYf4hIAispWCiIzfcgxzvAow
xDuUJaCLT/+uvg83J/AN
=bOw3
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
