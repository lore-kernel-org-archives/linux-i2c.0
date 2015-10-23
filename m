From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: designware: enable High-speed mode for pcidrv
Date: Fri, 23 Oct 2015 22:04:07 +0200
Message-ID: <20151023200407.GC1520@katana>
References: <1444380426-17953-1-git-send-email-wangxfdu@gmail.com>
 <1444380426-17953-2-git-send-email-wangxfdu@gmail.com>
 <1444383067.8361.517.camel@linux.intel.com>
 <CACDNBm3wkxAXbgQ4Z15uBFKUrsy9ngYKx3dGY20eV4RbSoJ5mg@mail.gmail.com>
 <1444638708.8361.564.camel@linux.intel.com>
 <CACDNBm38bC+tP2S3WgUJJVRUppYF3=aUXvRtWfqfpM=BHapN9A@mail.gmail.com>
 <561F64A1.8030805@linux.intel.com>
 <1444902023.8361.629.camel@linux.intel.com>
 <CACDNBm2BkrjFHV2tcZmC+xH4kLQ724diEucRN53xEPaMrV6Jxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACDNBm2BkrjFHV2tcZmC+xH4kLQ724diEucRN53xEPaMrV6Jxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiang Wang <wangxfdu@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, xiang.a.wang@intel.com, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Should it (ACPI walk) be done in PCI case as well? If so, then it needs
> > to be done up to i2c-core. There you may adjust the bus speed whenever
> > slave device is enumerated.
> >
> I think the "ACPI walk for bus speed" also works for PCI case. It'll
> be good to do this in i2c-core.
> By doing this we can get a minimum device speed for this bus. I2C bus
> drivers can use this speed to set corresponding mode into i2c
> controller.
> Waiting for comments from others.
>=20
> > For PCI case you have still to have hardcoded values and it should be
> > maximum supported by the bus I think. When you have implemented above
> > algorithm you may do this safely. Am I missing something?
> Agree. It'll be safer to set a hardcoded maximum supported speed of
> the bus for PCI case.
> I2C bus driver can use MIN(speed_get_by_ACPI_walk,
> hardcoded_max_supported_speed) for bus speed.

Do I read this correctly that you agreed on an alternative path so this
series can be discarded?


--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKpK3AAoJEBQN5MwUoCm2CAYP/1aFyD3gxxNJPyDHQpuGAIio
8Lcpo14XgsXSy0WDswSHaCPwQzUxIhhArtoZkWyQx2n4WC86K2uY0Dh2LngQe5sI
MbbdvTRD+AFNq9TDg9s0JwFGFz5sTE/TWh5EkkAobQpCg4Kwlgu0jxFG4737nKvo
Keok5gbBqBuSoss7dbEHWj1uidb3J/6oc7m9nQN5sG6j1v9WTZTT998+ZurvVfA2
fNSrj9Qa7ibW4BAeQoNzzlKo/t+FV53ulcbjkG7cx69Xun0GmxDjWPJBYj92eYLy
SAXlx33RKbth6McBUkBG2jvd/cfz1jGRNAh7YzHt+/tx2BUbdbGepSFLAEhgMhmE
us4DKtyzfQr97YGso8HHAPk/uOmGybI/z2HM976pjZT0JV3t4gLrQiFHgwqgu1Jl
2iXNcd/wPs4ZabeHGkrQDVO5lIaf1STGYgjlSXPyV2DD9aNjlkZmEF2RFyI3Xler
UxgNI+UXx3lDcdscyP4t66wQIkjBj9jHxJmKhHLZDLxdmTRjar0lTQc/80aQDjji
pPvDIFLVREDnkHXaXX0nuKmxfgDGYvBOAkSD+JA914s+0N00isb5bZEM5PfXMn59
c1V9uftPSGl5wtQ9lQHXgpx/7U1GqL8XCe0rvgtr3AZ8n3NCDK2JY4Iy6PkAXvWc
9LtcY1lqBLDORj8b2SH+
=L3/H
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
