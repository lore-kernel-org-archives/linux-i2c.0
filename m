From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 00/16] i2c: remove unnecessary OOM messages
Date: Sun, 11 May 2014 13:22:10 +0200
Message-ID: <20140511112210.GB6400@katana>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <018301cf69aa$cb7987d0$626c9770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 01:14:09PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().

Yup. Yet, this is trivial stuff, please make it one patch for the
whole subsystem.


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTb11hAAoJEBQN5MwUoCm2pEUP/REbEFID2XwAGv2PKFIxpY0E
hjO/OC/JB8p/zpqugLVifkUXM/AlXHX0DqEWnhSrurtavZgF6jSXgyYeH2hYfqqD
qX5DENBcV8RlGDDsJWfgTkoGMBf5MdowzxYn6YMPW9dqrFmt4ZJlcMtTkW8xrTLr
cDZm76mrOJfFVdDrLfw+ijzSR82+gyOlE5ZSrrkWQ6DXfWTz5jpe7OiRRJKQMAxP
b3Ho8ZxaKnldFe4I63r/21TlpQHBIiWy+83nHDagvth9hxTOinPgtmN8tbO8KxsY
f+6A6Bw7q0vwv1OA1Fzzo5BqfSyyfjG2LFUUXaVQ8qlqjgAJpB6GGxpofIx639dq
v2CsDOwx3/UrTCfJX0tvh0bs8YMlJ5lduhUkGIreKEzi1HlbgTCFAQjYDdvd7QkX
mayX0IDksd5RkZUxngvPx7/e7dyy/IsQ5pp8ldiBL+PVceXFmbEn8HmrfiE53DSm
Avj2yqaE1QfJVE7o94k8fmECuQ3Bqueq2G7piglg1LIsM4itcZO6V9mXjMuYepF7
jVJGeAbLFfPt3JQgI+CBkta7twstQk2LCuAllKFuqWaXOOytOrgJMpWEKyZol2Ij
TXMRozJ9loYrgwGNQEAYE7frzUeLfptWtKRu2Skt/jM9go/+XrwzHRfdcfGIIqjr
dMG/Uy5UjUQW6CDGYnsI
=NC+j
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
