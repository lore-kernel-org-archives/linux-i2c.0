From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/2] i2c: designware: Disable pm for PMIC i2c-bus even
 if there is no _SEM method
Date: Thu, 23 Mar 2017 21:07:23 +0100
Message-ID: <20170323200723.6i2n6p4bmctzcqor@ninjato>
References: <20170313222510.466-1-hdegoede@redhat.com>
 <20170313222510.466-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v4kosqm37cj4ki2t"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40826 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbdCWUH0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:07:26 -0400
Content-Disposition: inline
In-Reply-To: <20170313222510.466-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org


--v4kosqm37cj4ki2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 11:25:10PM +0100, Hans de Goede wrote:
> Cherrytrail devices use the dw i2c-bus with uid 7 to access their PMIC.
> Even if the i2c-bus to the PMIC is not shared with the SoC's P-Unit
> and i2c-designware-baytrail.c thus does not set the pm_disabled flag,
> we still need to disable pm so that ACPI PMIC opregions can access the
> PMIC during late-suspend and early-resume.
>=20
> This fixes errors like these blocking suspend:
>=20
>   i2c_designware 808622C1:06: timeout waiting for bus ready
>   ACPI Exception: AE_ERROR, Returned by Handler for [UserDefinedRegion]
>   acpi 80860F14:02: Failed to change power state to D3hot
>   PM: late suspend of devices failed
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-next, thanks!


--v4kosqm37cj4ki2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUKvsACgkQFA3kzBSg
KbY33A/9FNvKfpCeC4ftsQlkTQeO4Jbz069jbSakruItzWyzp88gwX0TNcKTH7M+
+l7TtncSkd/dlChIr1jmziXyUhQ50shf8XGfDj89yXxRoIT79JbNnyJahjtvNvuJ
mAG1sPHmMvyyjx4HT3A7jGJTHMCCimJBzBe/YbHN0dIu4d+uzWe6ljt0eoDecUwF
tjVYJ46WA/6Q2y+dRIKQvAALZYDR0nyIz49t7s5U+dSx/z+hQn8n2xOZZm5kbduE
n79mkbcylQnxs3xu/9TrmWIvdT+EjdxpsQKXAx9xaqe+uLsibDxqN+HhfCkjq15r
lTWQl8fk8HEIthQhjXSWYAnvUHN1b911RjYCIvVUJHpUp0Uv71VWYhQ56i5eplZ2
oCYgh0Dy4kSaHczese5SKOgTphtFkRwxx3je5hWCN1W/1ns1fc32m0TFHpo7G4Gf
ZXvlwT8z0HANQlQmP2TknFyca9Hbdu8Pe5wUD3aKokqTd00naBCWu3fzooWUEwBZ
zzf6KtebLPv/lVHF81wCRr7Kjq+93Sr2dq+3z0KFHkFTmiptB9Sbwb2uoO1P25Cu
QyyG3CSSCbnFiM9WVbIJ3/P/2LGIDa6ekgJlMfhAekZdVWmV2vPwMLo2Zv7Ekc77
0pOYs8dQ8J4EN3ei44XZ0VGL8YuXfS4wv8HpBYP3sKn97Py11xk=
=7tgf
-----END PGP SIGNATURE-----

--v4kosqm37cj4ki2t--
