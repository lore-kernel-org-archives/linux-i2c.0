From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: fixup return type of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 11:01:47 +0100
Message-ID: <20150315100146.GB6770@katana>
References: <1423411927-32686-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423411927-32686-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 11:12:07AM -0500, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int. This
> patch adds a timeout variable of appropriate type and fixes up the assign=
ment.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Fixed variable name to 'time_left' and applied to for-next, thanks!


--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBViKAAoJEBQN5MwUoCm2rvUP/0QSfWWkcc4thlh0tIG+AC+X
BCb5KiyKJ4HY+lLl3yM372PzxYPvCVmln8HseTDxq/pnvvWt1LLSoIlXA1No4o9m
2tP+Q1fVPZdMdIKHZqGILZh9WGjeGunqnXpVVGTb4NVlpM0YFsiM2rsFAUkH89DB
OCpkv+wYnsBJG9FkEPyNFViKIEfX3g5RUw4eVUjVKBHRvz6hkMnkN80gChcJzWQp
dEP8N044hPA9Mb+EN04WosnPePJhveFD+0Ag8dNCEeZxdrfEKyulfYx7CQakaN3i
dSQTBcrDICOGn6UWC++TkCnno86D0V7Mxr6AZZesYB2RcHYe84XpUQxOTlM2zzaE
DZXpeq4KjCUQV6ZqXqQHSYgteocBXdUgll7+WfQw0bJhT434LouiuBGi68V9mRxb
2q8rRB8h5XHGu3QwyYPThCWwM5BNM7Jfo6mW2bzsEuK9sTE5Ufnm8qA5s80PU75b
QtsaDrrmG6KETp2l/0p27LR9anNhqSf2Z0xVa4aOBYBWRpwKXM4PfKlMW+fTJFnT
gYNy6dZfDI2QQl+nRUcji54LjsRoXawI0P/cR8uUU/a0QX8gyOKxnb7LI0JQavc9
dZ056dTusq9+BqCDILBBQtYz6BrMZh2hsNQUJHU6K/128mF1N3/vjfGGIiWi2NRb
P8l1YdE+f9cgV6OunMuQ
=TcbF
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
