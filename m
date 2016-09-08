From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: designware: save the preset value of
 DW_IC_SDA_HOLD
Date: Thu, 8 Sep 2016 22:18:51 +0200
Message-ID: <20160908201850.GA3166@katana>
References: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50167 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754584AbcIHUTD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 8 Sep 2016 16:19:03 -0400
Content-Disposition: inline
In-Reply-To: <1472283570-31471-1-git-send-email-zhuo-hao.lee@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Zhuo-hao Lee <zhuo-hao.lee@intel.com>
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 27, 2016 at 03:39:30PM +0800, Zhuo-hao Lee wrote:
> There are several ways to set the SDA hold time for i2c controller,
> including: Device Tree, built-in device properties and ACPI. However,
> if the SDA hold time is not specified by above method, we should
> read the value, where it is preset by firmware, and save it to
> sda_hold_time. This is needed because when i2c controller enters
> runtime suspend, the DW_IC_SDA_HOLD value will be reset to chipset
> default value. And during runtime resume, i2c_dw_init will be called
> to reconfigure i2c controller. If sda_hold_time is zero, the chipset
> default hold time will be used, that will be too short for some
> platforms. Therefore, to have a better tolerance, the DW_IC_SDA_HOLD
> value should be kept by sda_hold_time.
>=20
> Signed-off-by: Zhuo-hao Lee <zhuo-hao.lee@intel.com>

Applied to for-current, thanks!


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0ceqAAoJEBQN5MwUoCm2fZMQAKSUpaWvPIiUlP4nmnh1or+c
w/YflOrnwovTgfoy3UxPao5RnxhTx9WCgF/JDzFQyQ5pzg7zwFA1sN4e6P2XQnDi
uhGpLEauJbWYweqlDb/l0+NUouP24+jLCoOokpK3fiuxutFAiXj9uTIDu7gn1ZAL
pu/IvLreb11/0n0uTa0LX3GkFAYermhLRJ6QaGOlyV/Oz62VTHaq3JID+T+Kan5P
6vekOK52SGG37e58j4v0MO8G0H1OMnXu2LP+nNou7DQHsuZi5UpjceC5rWwhPtVQ
1YMkbKnNybqXS2s8bhJsaXBgJx4BYwo2fKGnY/hJekWshOQZ13YKvFrMvKNIUucu
RrxLSPfoCDIs2fRwwUolNEu2nF/0wmH28Bmd+iN3Qa/vXHv39d86hCJ3JnGUGv20
R5AQooCJmQpFDcFI7S6NtI+Jl6bW6qghuREVSFBv6YKlxO1iKMUi6zqR2vVqUZz2
NoXgh+LVK61WY4Ivpj2OdentpfjqkvFVWGvCUPsxk9+Qt7M06HN5NlnxK74U4NSz
kOEfo2T7cvdYE+RqaoY85cnh9XB4URbdPezRaubMbhr9WJqKedMnI5t7VRwrV0ZO
qJXnmpKcw9xezJxPRt9vogUBZrMPRJ6buAX8MDon5FhboA7UsQUFjWgNud/vbn8o
EN7JqVp8xUHDJFL3nNPO
=UKOp
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
