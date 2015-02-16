From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Mon, 16 Feb 2015 13:09:51 +0100
Message-ID: <20150216120951.GA2840@katana>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
 <20150204190819.GA15467@roeck-us.net>
 <20150204233516.GA1677@katana>
 <20150205002630.GA396@roeck-us.net>
 <20150205144028.GA4865@katana>
 <20150205175326.GA26691@roeck-us.net>
 <20150212040126.GA1691@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150212040126.GA1691@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guenter,

> I wonder where we are with thisp patch; I don't recall a reply to my previous
> e-mail.

Sorry for the late reply. I needed to recover from a HDD headcrash :(

> Do you need some more time to think about it ? Otherwise I'll publish an
> out-of-tree version of the at24 driver with the patch applied on github,
> for those who might need the functionality provided by this patch.

Your last mail made me aware of why we were missing each other before. I
see your point now, but yes, still need to think about it. My plan is to
have a decision until the 3.21 merge window.

All the best,

   Wolfram

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU4d4PAAoJEBQN5MwUoCm2ZhUP/jtkPE8SVl2aEDilcGleGvjE
dIoM+DdxZ4GXUt9TXvnRBheRtQwgjWG3GZQb9DP4gSJzv1mDhU4Z1/XyUiqtQsxL
OQyFw5A+AeJ6wnArskKKZjX1hJODrBreCHDk5+iarZYS5a0E6cmO9e+SxL3eAL4D
5911NaC//SlvV7p+ke+FLiskI/5bs8kfdpIBjNcbJ1FoUAQk9ELHQKtyafODVQ4T
2TIJzj1+kcK/qQpM6lpHjxepTiOp0wqTcDeqp+hmuDFUgMzTIQyXCTpHkFSpQieQ
7mD0T4bDc/B7UUnr4YAwkGEMqLzUQxoOXeJ6pimc6xtc3yf/kXSdrPOJjhCUI/tM
OmQPbctrcIAkQjxtGI5bteudDv3fMYqQ6nBhxj+PfiW8cTfFtUQhL+oxPmGw15UT
Cs3dKv7ZddLaBw9loBRovPMq3NlTeqjEjXKqO3btv16zDbFFh53oPddaszMhylU/
WiAUhU5GVQpFbl65APSgSv0/Tgeo7ZOL8vGcK6GSry4u5tT/KWlgIBCduNUKLePo
A3YGdMMdk++i0ulwK0p745zI7xpHFSRRZFQZHpDxtIbStyJFds/q3P+veK2ofp6X
ntva7c88P6E113wLHhJO9zXdRhOvPMi6RW6TPGYZFPmXj+90ZI1Srsw0gsFAsxe0
noM81a7wnXXIZGGp+fRH
=fKjX
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
