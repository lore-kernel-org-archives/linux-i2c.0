From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [wsa:i2c/quirks 7/11] drivers/i2c/busses/i2c-axxia.c:452:27:
 sparse: symbol 'axxia_i2c_quirks' was not declared. Should it be static?
Date: Fri, 9 Jan 2015 11:57:12 +0100
Message-ID: <20150109105712.GA1053@katana>
References: <201501090118.jHaamxHl%fengguang.wu@intel.com>
 <20150108182847.GA29629@katana>
 <20150108215137.GA11727@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150108215137.GA11727-q6ZYBFIlbFFi0tQiZxhdj1DQ4js95KgL@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fengguang,

> It's normally private emails, except for the ones that carry patches
> with them. In which case public mailing lists will also be CCed.

OK, thought so.

> > Is there a way to achieve this? I know that adding "experimental" to the
> > branch name will skip the testing. Is there another pattern to prevent
> > sending mails to everyone?
>=20
> I wonder if the occasional public emails are acceptable to you.

Not really. If I push out development code which is good enough to be
build tested but not ready to be sent upstream yet, I think other people
and mailing lists should not be bothered.

> not, it'd be trivial for me to add a list of "personal git trees"
> where all emails including the auto generated patches will be kept
> private (if commit author =3D=3D committer).

For my workflow, everything except "for-current" and "for-next" should
be private. I do appreciate the patches for those two, so thanks for
that in general!

All the best,

   Wolfram


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUr7QIAAoJEBQN5MwUoCm2J1wQAI83lHoFSqKHqm2hHu60s6Hk
HWfc8SVBrlQItOSmECVo2rZd/Ztn7BAwElcr1dfwJ96myE3+lkM8j797vqBbOQT4
UScs1j3QHugbveaMiHAFI3GxEZ+zutaO+Cu5h7PNFZ5/uhe4T8+tgQSH1Q3yA6QW
b9+cCa6ZoJb643zlzBryHSiHDJ2LSvFxgdQISzRY9pX2PaWK/Zu/zlxZZKGnKdB0
6VIbmZT2OTLUF45RXk4Lw+5mixsPiSsEWkDIA1nwuj73ZEj2+gBzCbFqS/1f+hs+
XeiQZvFCx7LFw4t7sY/yLj4XFMU5Ggl+UQ/xTm4xGRJDZTRVLxKHPIlxAeSeaMC2
2nInVB0cM8N5Eet0mXRC8wLYqsOwYbHR8rblKuaG9f5RicprKOFWjorT+qQe3/Th
lR8sGCwmJJ9oLUAwmXW/Ssk2xLMQ462+AXTVWvp+Lf2cqZtu0kslO1uzX760KoHt
v+IVwezMEar75FTr1zOPcdm4IEbYdrY+iBVvYOQuqCluTLNKLfX1D/SDpC7kkky2
xSvyiF9ePvzpzaL9UTbEqNgLAFXM0UrPmF4ALICPpS9PXvGgPuBnqvmCCbnxBDYw
yoc/F9ofxerwceGL06XAVFP5Iq64D/7xAiC9xyn9S9lvln78/S1al/9IxRLlIJ+r
fEbseomoJasHpIPbbzFo
=hxVw
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
