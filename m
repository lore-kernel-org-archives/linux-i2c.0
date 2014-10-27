From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c:at91: add bound checking on SMBus block length
 bytes
Date: Mon, 27 Oct 2014 08:57:49 +0100
Message-ID: <20141027075749.GA1284@katana>
References: <1408585181-10131-1-git-send-email-mark.roszko@gmail.com>
 <20141021071434.GI7443@ldesroches-Latitude-E6320>
 <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg@mail.gmail.com>
 <20141023134927.GQ7443@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141023134927.GQ7443@ldesroches-Latitude-E6320>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org> mailing list" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Wolfram took in the patch quietly awhile back. It's in the 3.17 kernel
> > and backported to some of the older trees.
> > https://github.com/torvalds/linux/commit/75b81f339c6af43f6f4a1b3eabe060=
3321dade65
>=20
> Great, sorry for the noise so. It seems I have checked it from a wrong
> branch.

Yes, usually I send out mails when applying patches. Dunno why I missed
it here.


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUTfr9AAoJEBQN5MwUoCm2cD0P/2RoKSqXkQHCAdpwpSIwwk0Q
/aPCtd8uejXzuxwnU1V3NJ45y/vBMyGpWOFuaUYq3RnoS9sPD0+jtJ/nbHQDfPrb
hEVQUIYNtDtKKR9EaUnOXe+nxcgiBYTcveozeAY2f6fKohdtNZgMa0efNCrtYl0x
cFptZ9ojaWz0MhflIuy9tAOD6h9sLvSgDyT57m8CwlRF+RaogJEhaT2RVfiWXwxf
PdkiKLhUS2UiGr7Uo05gk2b/k+xoTcEf++7rIyF32qF5kiuoqr7uLn0I1ySvjI9/
5/v+3QcdRIhPF/Y/FmZrop8g0HvV2HcsLofBzbB2HBXrtba5+JQJRNx999Wjj6Hs
+LvWCqZu8woGYFW10mXE44+7TugsO6id36+6rx3ZnKucd+dPOcSaHoCcWbeOLxVK
zixI1Nsb0NYKXQ4fZEa1B7+aQVTH9WChOxxOGmRnPV4MBReaVj4lFR8ZSslBIeGh
lRJJ4tnIUDTtHMNlrEEQuW8hzZvBwmGsjPKNvyeQGWbuJC84LzFcZ13LxwCzBdlp
i+XwWwM4o6CBZIWSRLMTqz46U18KvlztnVXCU/03Hvie6Sw5qn6sVzcn1MvGfAgX
L6zp/Yw9oGU3OVi+pGtwsdP5655Dh4ddfLwGLpltF741Oog+qDUnGCx/O9vOuygH
BtIb1BK1L6diXUTFfWPE
=svmh
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
