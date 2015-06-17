From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-parport: start using pr_fmt
Date: Wed, 17 Jun 2015 13:46:17 +0200
Message-ID: <20150617114617.GB4604@schokonusskuchen.bad>
References: <1434093434-30834-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434093434-30834-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 12:47:14PM +0530, Sudip Mukherjee wrote:
> Start using pr_fmt and convert all remaining printk to use
> pr_* family of macros.

I heard you introduced the driver model to parport. So, isn't there a
struct device we could use for dev_err() and friends?

Thanks,

   Wolfram

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVgV4JAAoJEBQN5MwUoCm25SoP/RN/WfjwZ12kplDPSD6vNAmN
S7uCs0rIQrMEiFo6yoAP9sl2n391tYC6WlOb4GGtYIOsN2a70AR14xu9fYKKx/wy
ZXtff1t7Gd2H2GAw6pVABvUT/589QdVL8ISl2A3tnwIItT0vcathxdoRU8IrCWqW
wK68xDBaJQ6NwH3goBEFpiP/t3ZHg/gZAZl/ZqT+cB01kcoYVw4Nebwa4LQJEvPa
J+cWL21CxAb8474r9WEqBB0YqaycTM/uDAHfQ9p2bEJ0XJMIG2s7aKAN2uhQynMR
BHKKbr7r/gd4cPa2USxW0iznR0b15TFnguWzN/DqhVbkCGBrrBqNCRUEzyzEuqVP
ElhmFS1VJvMiMPgKL3K2GkFngGWpRg/brpeKr+bkwWljAnVpV4QubsbGFQ3040Jc
yez5PVzcJahU7pnXIRm63NoY2ussz0B/uUoXn9S4ptOtmrX/Li1UxB7r7DYWHidg
bejxay/Ihnk7UbpRySGYKaTl8mtibRWlxSBGtG6vBqj/GQiw3rAjXYB3pg0T7pLt
XqWktTcLcsSaVsMRlf72DIxcJVjVelXiX5R5MwIdU9Lpz01++KAyWoNm7QGML3+T
G34BuktlVpt+zwsTilmZTl4MVyovc592W32iHXpJ9ftZjZd8B7ldlnX1oKVBCCtH
GwkUt16Nu3ca36GmnpEg
=0Ull
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
