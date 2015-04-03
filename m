From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
Date: Fri, 3 Apr 2015 20:17:46 +0200
Message-ID: <20150403181746.GA1298@katana>
References: <550A05E5.3050100@gmail.com>
 <20150319100944.GA914@katana>
 <550AEF9D.6090307@wwwdotorg.org>
 <20150319160208.GF7657@katana>
 <550B3725.10209@gmail.com>
 <20150320101925.GC2071@katana>
 <20150321210028.GA1078@katana>
 <550EBDBC.9000903@gmail.com>
 <20150323183211.GB1128@katana>
 <5515C6B6.7080903@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5515C6B6.7080903-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gabriel Dobato <dobatog-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> While thinking about it (and I still think of it as a 'big issue'
> compared to the intention of the initial patch) I came to the
> conclusion that I should maybe just go for a board-specific
> i2c-mux-pinctrl node instead of adding it to the SoC dtsi. That will
> also avoid doubled i2c busses on boards with just the default i2c
> option.

Ehrm, then please let me know what you decided on. If you chose the
above road, then I don't need to think about the other questions :)


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHtlKAAoJEBQN5MwUoCm2wm4QAIiTxWw6Zkn/iHvPbPMHwGKF
08BtWeP2dHAdBGtilPsYi9Ef90T1Svj4/y+jkVvz4oaP8UGlAiNjCjDt0prcejMg
Wo2q7x3fGVPfperUh6W+mvlPf1uE6uL23/+SrcBqQmJAVXo2N8tX2BPn08fet60B
o/JVhrgue/S38yEtTax6osRdb9jKnHIensjrwczwQvtf/ybYONLnD23WaBDaeswM
Ck1RDc4w9Vbx66i3ZLX4AI6Bl+p5SGXZ2S++Gju515d1TWWFEUCrCaYAPksh0K0a
toDvWqfbsbrCJ26SHAsa8PohEAgp19w8SwURv6XjGJK/xVGrEFGbbHAusjD50Kg+
X5a7PvDEV9Py5QMF5k6rL3OL2/1cdU8DFUJUFU2P94EFgu5U8twvG5Hu+xSFs3z/
03cOBlCF/JlBsgDSpmZz9VRzr5BfUe/sVXZi0v4aM03KR+DZAyF14EN8gtKBhICE
FtPkGhrjerVCFWdLh0Lnh2C79/6tTMnpXQEaWklCLtvSpcBpXlh/XG79QUg1FaPQ
z0YxUbK3q5LbHWfIbq1xQad/fQrqE4h8lmSWI0UfhDN13vVEzuPIGhiw5C3WkKwy
LTOsw0WWLBvp/AbkB/zahsDn6pW7klVwGs7IJvBJQ1YncXrxi/Gbsw8WzR3rn2QT
rGvhUUTHwDFWI3LzztBq
=JacI
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
