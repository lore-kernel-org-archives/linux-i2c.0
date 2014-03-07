From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: Fix circular dependencies warning and
 compilation breakage
Date: Fri, 7 Mar 2014 15:26:14 +0100
Message-ID: <20140307142614.GC28943@katana>
References: <20140307111858.GB12274@katana>
 <1394199795-5516-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140307142405.GB28943@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140307142405.GB28943@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Why don't you simply set rstc to some ERR_PTR above if not
> RESET_CONTROLLER?

I know why. Sorry for the noise.



--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGdcGAAoJEBQN5MwUoCm2sPcQAJw8eV5th8WRozVoBjQiDdKA
al3HTXFAu9VugGb2TtxzjKmhYSjQaBtfwfSNvuLzyEDK1gYSOFKndgkq27PCvNWe
Ze844w31j/b5XAW4R0v8g5E1cEB0RtXIlTXHc/eOl4k0Je+SVRSDWTWauXYt660c
/i+haEXpt2SaNLGzAKRddV/tTUTbW7Wa5Kt1GStZLTPF7oskg9nuUJeKqzR6zuk4
jP1eTLk5S+iWug1eFCNeOEq5IA3Kf69w1BUhLFRymOPBkG7RdrgR1301LLBnVjGH
CAs+6d65JCf1zGoGJk7DwFqS3E6qVLik2/S0PZ/faRxHj5myhGVDzjV07pkCrqJB
2yuOYgZwirTK8vvOiH1fbeWLc77jvmeV5wOPEnHMK3g2P27hl595dpHbRGPbS0Ys
8jhI9jTT5KpJpvuMySUZDsmyBcQZ2lb/B99USyqzH3T0MLEk5+Jkyr5+cmIhdgAu
z6dG41xRSFqo1fqr9P82h8di1/LrP9gFU6RX/6W2s1fChJhFEoF4QrYE/EzCrB6w
13yMJGMoGf+UjLJ5c22IDYz/YhVtSeW7ZcUOdi4SJtB0cR5OgbdUpVhfnuUIA1F6
E6WeNW2RG+kymveH6zoKstiPJ9ms+r95hCEOY/jkplKlNRfpWtSu5zMwBDIbE6H4
1JfHjR8OIJBMyk7zb9mz
=rs11
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
