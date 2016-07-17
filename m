From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH 05/14] eeprom: at24: hide the read/write loop
 behind a macro
Date: Sun, 17 Jul 2016 20:00:41 +0200
Message-ID: <20160717180041.GA1814@katana>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
 <1465202936-16832-6-git-send-email-bgolaszewski@baylibre.com>
 <20160715122429.GA2620@tetsubishi>
 <CAMpxmJU+HDvUb__Q6UvuaVC70+GdSU312uVuXuicqsn6_v2uKQ@mail.gmail.com>
 <20160715150352.GB5136@tetsubishi>
 <20160716045651.GB1677@tetsubishi>
 <CAMpxmJWniibfkoQCFgpwH8D23t8V1+3g=NBY2tmNZsGN=6Ufvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49747 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbcGQSAu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 17 Jul 2016 14:00:50 -0400
Content-Disposition: inline
In-Reply-To: <CAMpxmJWniibfkoQCFgpwH8D23t8V1+3g=NBY2tmNZsGN=6Ufvg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> thanks for the suggestion, it looks good. I'm not at home right now
> and don't have access to any device with which I could test it. I'll
> try to send the patch tomorrow evening or Monday morning.

Thanks. Please make it an incremental patch because I am going to apply
the base patches right now.


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXi8fJAAoJEBQN5MwUoCm2TVAQAJpWKrwDrmMiFPL92xEe2LXR
cZ4S7Kc6PYWdx0cog6s0KYUTMPJOBkcsOv137U41Es4WWVvXY2eqrjKaOq0IvcMa
oLtrj+VBSY2KnytHAh4nUohImcoeNjWuRBXciazrXnqRoxPsj+UDmNFEN76jDCuE
N+5SINLpS0lHqYAM2/14YMRdVu470AuVf1W/WGA+1UP+Morqk5nFj6Or8dQ+pbc3
TxUS0GpblgMpY2xIPgTy9dYDs9/NyMGwvhJrsWY5vJtWIhePiFRgD+LqG045TPqc
rwT6j+3OWBcOzzZSxPjI5Uxm51hhxVOEdo8xvmyqUE6oZCPXOVqJOLw6Cn55A1eU
E7EHuxnutNoFTd21R0UmPAe+C0yC3BnSZwg96IHlUK07AqFnFBFEz1FDmhsyVOgK
8ILcTTIv6zWB84I11p8BAtoy41VUNjc0s5JAamg+RHX/5Tuwilx9jUJe06DuwDnp
Rw3f1+wcVm7TJ3eLg9JSo7sffmaVtEhTfqGwzOmiJWXxMdBkPTeBFf5PZt9QJaYu
MgkJBhI91AyaN9kSk0MBg84EkL/k2CLaIM+otSEndkenmolOS11eGEDl/S1sE+Hn
H3+I+JUrUIDSNulSiHWobXnPXLu7COTrbW0nQI2XlDre2Mna9PyVqA+zGqRH5gBd
FNweF7Wd46GvVlWnuLHG
=c6gY
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
