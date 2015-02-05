From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: i2c-ocores: add common clock support
Date: Thu, 5 Feb 2015 20:43:44 +0100
Message-ID: <20150205194344.GJ15307@katana>
References: <1423165223-7625-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423165223-7625-1-git-send-email-jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +#ifdef CONFIG_HAVE_CLK
> +	if (!IS_ERR(i2c->clk))
> +		clk_disable_unprepare(i2c->clk);
> +#endif

Ehrm, you can leave out all the #ifdeffery :) The functions are all
empty in the !HAVE_CLK scenario. The only one which might be left is the
pointer in the struct. I'll leave it to you if you want to save the
bytes or the lines of code.


--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08fwAAoJEBQN5MwUoCm2Ss0P/iWFjQhxFdSBzuhNCzxky3Pw
4gwRzxrjsJpUcS525d9mT8RGw6ppskDj8W4SYs33JJCF+kncUFRwuABT2QE9KdpH
SrZqpB/pzgKTzSirxpg31DARKKXHRjbORa75YSD6NjSvpwgawHycoHzJmOarxKv+
sgcC+8PYSpKebDgUGNBL72F9uvE2vTrOJ/nLY+or/DV1U99m3ul4Xe9XdCGJw6UE
pc/Lwrq44n+ngg5Gwx0Xw7JHVYr/MwQEPdYBge+AIOjuRA0DKTJiX+9+1M6n4I4d
P/pq5LCzIUhfGto3wmJeGMIf34BmfsCW+kQ+ir/hhR+1cwk7gWJ/l1d4G9ZgWZBE
byfx5zDATSQUcD3oxblk5dtmBBEZdCti/AuwAF/diqjqvmdGhd7x28wATnCi4ujA
3EOjFyGYwQXIbmukc0SGtsEQS8+G62QMN+OWRzoYtikggWPUqmHPpMi7SHbXra86
2SJ+LO+TRuPakAkJaF40QnMd36edkZExqgde3CcD4kunhxw9lFTEvrD5+qxFdVdf
JDqKkwVne4Fli53s2Glcv9yTKC6fJBfPiUoud8lq89aN1L76JL+NvmQ8GD4dAcj/
PFNOcFtrL5oI+mqZzO+Ou6KlYXdpLaBQtgfnBYD1Ho+10RipZsc0YHA0R26Ay7Od
YZT7MSEghVecV52wApI9
=OP2P
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--
