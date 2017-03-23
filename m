From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Thu, 23 Mar 2017 21:58:25 +0100
Message-ID: <20170323205825.w26jcbv6gz7wu6zg@ninjato>
References: <1487051641-31927-1-git-send-email-chin.yew.tan@intel.com>
 <1487051641-31927-2-git-send-email-chin.yew.tan@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nyc3mjtuj6jjkdok"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41090 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932592AbdCWU6d (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:58:33 -0400
Content-Disposition: inline
In-Reply-To: <1487051641-31927-2-git-send-email-chin.yew.tan@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: chin.yew.tan@intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org


--nyc3mjtuj6jjkdok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 01:54:01PM +0800, chin.yew.tan@intel.com wrote:
> From: Tan Chin Yew <chin.yew.tan@intel.com>
>=20
> Sda-hold-time is an important parameter for tuning i2c to meet the
> electrical specification especially for high speed. I2C with incorrect
> sda-hold-time may cause lost arbitration error. Now, the driver is able to
> get sda-hold-time for all the speed supported.

This describes why you change NULL to dev->sda_hold_time. But it doesn't
say why you introduce the switch-block instead of populating all fields
like it was done before.

Furthermore, since now there is no NULL case for dw_i2c_acpi_params()
anymore, we can remove NULL handling in that function, or?


--nyc3mjtuj6jjkdok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUNvEACgkQFA3kzBSg
KbZp5RAArtOtdx8yNpKEvhB7T1TJxwsfk54+MBxc53IvqHmupOyopdOkwpecU0KN
Ybog1/yFvNp3SfpuOTDTOJ55+iwnmruUODXfHZgk4lMP6Fs+kWVyDvpwUeCSWDgd
/2HLt9cE7DaiBRAVexvCRXMyRkB3qwgAP3x58hAcB7C7MWpbShEif4+UTTZkOIi/
wF7+hSsj4hPrJZ1Uj3eclMrXe/89YSoNqLL2RQ6cXJfUTkLUxz5dcCc4oixGUY2z
V/dhztINLsLiPce3VKbZ7dXvF8NXuKYSm54oDukPOgBZ912UAiP+mM06ZFt+fFoS
STcgAK4bl6n3OCvpjgbWP7p9nvgq/iQFXSjGb/niSrr9N/8a11cDQyaHBY12h7V+
9vJKFUqiuygyo3c4wjNyEg1yJepwgSapuWFbbAuEiwtjrnslQOHqoBSOFGKFbWYQ
0JAq9bAReInQ5MZuf1C66HJGGmy5NWn1mLJZzx8o01kcr9JRlT3PkWDtXm9NFOOh
wUiAaYSZHMEgjoEoiHupAw+NTYj3yTkRMh41mML8oOkTw5CWd+q5asyS0WFKZD6Z
LW9wxyuYDsqS0jECEVqoQuz1DiTXKGrWvsjFXECuOaWPjmLBJ+4yTmY4I0Yv83A0
4l//mlTqyK6Xvc0LTi3JVMgky5yi47+2Jly8uWi4eKbUTvrWSuU=
=g/xc
-----END PGP SIGNATURE-----

--nyc3mjtuj6jjkdok--
