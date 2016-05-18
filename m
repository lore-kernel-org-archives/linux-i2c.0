From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c-i801 partially broken on Lynx Point PCH?
Date: Wed, 18 May 2016 15:02:53 +0200
Message-ID: <20160518130253.GA1637@katana>
References: <20160511093452.5bc2614c@endymion>
 <20160511104322.60521365@endymion>
 <20160518140508.7dfe192e@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56328 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbcERNDD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 18 May 2016 09:03:03 -0400
Content-Disposition: inline
In-Reply-To: <20160518140508.7dfe192e@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Seth Heasley <seth.heasley@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> 1* Remove I2C_FUNC_SMBUS_READ_I2C_BLOCK from the list of supported
>    transactions whenever SPD write protection is enabled. In practice I
>    think I2C Block Read is only useful for EEPROMs anyway, so I doubt
>    anyone else will miss it. This is clearly a hack, but it's quite
>    simple. Then the eeprom and at24 drivers will automatically fall
>    back to slower read methods.

Doesn't feel very hackish to me. We skip a functionality which is known
to not work in this configuration. IIUC we might be able to get it to
work if we throw more code at it, but I don't like the extra complexity
in the I2C core for such a rare case.

Summary: My preferred solution so far :)


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXPGf9AAoJEBQN5MwUoCm2OrQP/2RlGE0AzUgNXTxmyfJlJqr9
fHh83YWeuJN7Z26JgNmaIGc9k/u2ZAPY5mFBB2Cb4aGajm3d2oMjbq53tAVhuVF4
s45aYP59RqhsbsbNs1dX/teX6BYZc3ose++r0Dz4eOc4x+wg+wZAer/vwUX/6b1L
821hpvcN8hNc42Z0Aaz5uifpTujTcTRHmRTHPXv3m2xrKQJ7GVRpwU1rp4x2Cz3X
g8PJaKaXJ8YbMWXg/Y1oI45VBgE/jcPhYP9k0wSOAQxsKiI0u1MKKkn5c0bPWp4P
zsr0QPdRrfEG8JScOQW1jM8Xste56CKgLDwpkGnO6kagkAQrsjs89tMfMm4ebvsh
XkSbG43g9x2gcxyNzJlnxmF27od2orKm/hyW/476RLuvQVQYfEznpte9PLGOuh6b
aQJv/k6QwVUZghSeQdkhgM+m1IRwaK2zRbcCV0mCf+XGMSUhqAgPKwcF1qtdaz7+
LFlEFyvQf2dktg/pe8ZzwUTMVR+jMMDJDHom5k+SylkbtX00aqquMxyREqYJNQph
8/IJ9VkgMoobs11nuH1UU/BLWHqGH8c+xuOpuMfSV8if2DYAeQFbHB/rTHqMHTkl
QUirWut5SQ6ptLTdOnbEqQ8MxdmcyA7CIDbZdUZ4SwCq4sdLWKBIxyitJPJQfmKz
kdVgKmD7WhvK6NcVnOge
=C2UG
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
