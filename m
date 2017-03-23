From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] i2c: designware: Never suspend i2c-busses used
 for accessing the system PMIC
Date: Thu, 23 Mar 2017 21:07:18 +0100
Message-ID: <20170323200718.jh7ytrbpemfwboll@ninjato>
References: <20170313222510.466-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7biec5v3pxq73pj6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40819 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbdCWUHW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:07:22 -0400
Content-Disposition: inline
In-Reply-To: <20170313222510.466-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org


--7biec5v3pxq73pj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 11:25:09PM +0100, Hans de Goede wrote:
> Currently we are already setting a pm_runtime_disabled flag and disabling
> runtime-pm for i2c-busses used for accessing the system PMIC on x86.
> But this is not enough, there are ACPI opregions which may want to access
> the PMIC during late-suspend and early-resume, so we need to completely
> disable pm to be safe.
>=20
> This commit renames the flag from pm_runtime_disabled to pm_disabled and
> adds the following new behavior if the flag is set:
>=20
> 1) Call dev_pm_syscore_device(dev, true) which disables normal suspend /
>    resume and remove the pm_runtime_disabled check from dw_i2c_plat_resume
>    since that will now never get called. This fixes suspend_late handlers
>    which use ACPI PMIC opregions causing errors like these:
>=20
>   PM: Suspending system (freeze)
>   PM: suspend of devices complete after 1127.751 msecs
>   i2c_designware 808622C1:06: timeout waiting for bus ready
>   ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>   acpi 80860F14:02: Failed to change power state to D3hot
>   PM: late suspend of devices failed
>=20
> 2) Set IRQF_NO_SUSPEND irq flag. This fixes resume_early handlers which
>    handlers which use ACPI PMIC opregions causing errors like these:
>=20
>   PM: resume from suspend-to-idle
>   i2c_designware 808622C1:06: controller timed out
>   ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--7biec5v3pxq73pj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUKvIACgkQFA3kzBSg
Kbb9IBAApUjQJ7mAc8fdyocN6PzD4424sL/K4k6qrQoOOe5IG2ABfkPLHXpASDNU
IqtYG0uRlKVj66OazyfDb9Up3gNzbe9KgY+dDfSm5X2Vl9DblnShZ3cYoAWzMEaU
pbswy7do+CSTwJ2iefcTDKcbNxt92LKas4oW34e8w8fxEQIWb44pdQolGFtyTxrX
ndM2o00LRJsyJ7qAMCToidRvYlKH5JHWkQWJYa9/Bx54af3c9/KLVKQ0kKjG+WVG
tUo8hEpZa9etrozdKsuSHISH/xNY3NgeJCDGgoXTj/+DlA47myBAmXEzCiIORv+A
Q97YyhcrANKiSFSM7fkcGH9tFQJ2zPpMuNs6Zb54do4kABXiLGaC0si3thQVnS9Q
PpDwajQgNbOHvRedVMQHpPIxxzKY/AYyJmSrleFjcQX6nsVLPdkZQIInrjNNFWBY
8PFy7uL+XxLwjFocBUXR3RH4+9FDufoyqTTqSw6kgFAwNMyC3SN1wFI0KVT7LuGG
eP38Ey85A2oPZ3HUpLD8S8Yiq5Su6rPKWNpc4AuosNKEQAEYHTf5xlV1lF7I6c4f
ENlNtTRKXucXmwt359ZS48fElqgFdESPl4T8s3lWEr9wSijfj7jUC5q2FHtcwOAp
yfLlfYaIRaGzq/F9eFMNUbrJJGuvfGcV4DLcWuH0Pn6fhKrBqeM=
=D8Hd
-----END PGP SIGNATURE-----

--7biec5v3pxq73pj6--
