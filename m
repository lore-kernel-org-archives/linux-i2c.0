From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Fix SMBus ENXIO on resume from suspend.
Date: Thu, 7 Dec 2017 11:57:45 +0100
Message-ID: <20171207105745.zg4bbhdf66gxh4m2@ninjato>
References: <20171115170156.21532-1-alban.browaeys@gmail.com>
 <1510777525.21208.4.camel@gmail.com>
 <20171120101514.62239b4f@endymion>
 <f43a23f8-31e1-8498-c3e9-cfd1ec425150@t-online.de>
 <20171121124928.63c271a2@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wlfymbevquxnrfly"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55669 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752457AbdLGK5r (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 05:57:47 -0500
Content-Disposition: inline
In-Reply-To: <20171121124928.63c271a2@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>, Alban Browaeys <alban.browaeys@gmail.com>, linux-i2c@vger.kernel.org


--wlfymbevquxnrfly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Volker, I think you had a fix for that one? But I can't find it in the
> > > list archive :-(
> > Yes, on 13 Jun 2017 I sent a patch to the linux-i2c mailing list. But
> > the mailing list server told me: Your address is not liked source for
> > email. At this point I gave up.
>=20
> I see, that's why it's in my mailbox but missing from the archive.
> =20
> > If you are still interested I can try to resend the patch with my
> > google email account.
>=20
> I'll review it, so it will become visible :-)

So, Volker's patch showed up on the ML meanwhile, nice :)

I don't get if we need this patch as well or if this gets covered with
Volker's patch as well?


--wlfymbevquxnrfly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopHqkACgkQFA3kzBSg
KbYP7g//ceUE3zDc089riHXgeFqiK4WUByhpco6VLR32G8HPEpdTYynllVUAsOOh
zx+m4idxroJUhOBlFgmXEPYfAEBgoq2WvAlHhGdibYmI1R+hpLNIhMO1LMmIg1ST
We5yjO7wY4yTVQiJGZcjBRjdGCI+GaH2/CKrVYiEZkV/GlI5LuuMa96ji9gDI2T9
RwDlSP+97DCiwhzOUNC6fl36RXR3KAl0raV28JrHEAVxmkw7/WkuQVPE4T9noQJq
OywAOgDfylfD6zg+rz7HgOG3fhBF/8KZSFArH8JJQUTB1OniYZ0z8Uic5I/ZKrjP
UZj/5B0lFAJ6AcMmPyk0Vpr78DspdYQPZMVZUYV2EAcGrVPt9incMRBEiRSVzhO0
evyjJUSweF7xHGbV4b/pQG+V+tpHQckYuB6Y+arCF9YxtVcP7L/76qY+fiZKnsGp
6YgxkA1LXE9HoDhMZ5JoG5LUReZ+CS6InnDofRDmo+CTOPnGD2ESgxZK6KXKa/F/
8kT7r5hw+RLJCq3HcVRiQupokN3kOmaPOfNP/AKT/G6TpWX5uW5kIagekbhA05vA
W3zfMJNOup2Aj/BYQzh1zylaWW7gcGoV4XUxEyeK+JmyOPeo9jRAmyEzOMhSybeK
RtpE3HOCDuRxauHTa45vQU2Fotk/JdzKAOJjTLhdxmcDEZTF+KQ=
=bXmx
-----END PGP SIGNATURE-----

--wlfymbevquxnrfly--
