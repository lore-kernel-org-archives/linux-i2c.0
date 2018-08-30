From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: designware: Re-init controllers with
 pm_disabled set on resume
Date: Thu, 30 Aug 2018 23:03:43 +0200
Message-ID: <20180830210343.3lpvf2mjh5irnlai@ninjato>
References: <20180829130632.31111-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bm3bdhgwp5yxvn2n"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829130632.31111-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, "4 . 15+" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--bm3bdhgwp5yxvn2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 03:06:31PM +0200, Hans de Goede wrote:
> On Bay Trail and Cherry Trail devices we set the pm_disabled flag for I2C
> busses which the OS shares with the PUNIT as these need special handling.
> Until now we called dev_pm_syscore_device(dev, true) for I2C controllers
> with this flag set to keep these I2C controllers always on.
>=20
> After commit 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and
> resume from hibernation"), this no longer works. This commit modifies
> lpss_iosf_exit_d3_state() to only run if lpss_iosf_enter_d3_state() has r=
an
> before it, so that it does not run on a resume from hibernate (or from S3=
).
>=20
> On these systems the conditions for lpss_iosf_enter_d3_state() to run
> never become true, so lpss_iosf_exit_d3_state() never gets called and
> the 2 LPSS DMA controllers never get forced into D0 mode, instead they
> are left in their default automatic power-on when needed mode.
>=20
> The not forcing of D0 mode for the DMA controllers enables these systems
> to properly enter S0ix modes, which is a good thing.
>=20
> But after entering S0ix modes the I2C controller connected to the PMIC
> no longer works, leading to e.g. broken battery monitoring.
>=20
> The _PS3 method for this I2C controller looks like this:
>=20
>             Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
>             {
>                 If ((((PMID =3D=3D 0x04) || (PMID =3D=3D 0x05)) || (PMID =
=3D=3D 0x06)))
>                 {
>                     Return (Zero)
>                 }
>=20
>                 PSAT |=3D 0x03
>                 Local0 =3D PSAT /* \_SB_.I2C5.PSAT */
>             }
>=20
> Where PMID =3D 0x05, so we enter the Return (Zero) path on these systems.
>=20
> So even if we were to not call dev_pm_syscore_device(dev, true) the
> I2C controller will be left in D0 rather then be switched to D3.
>=20
> Yet on other Bay and Cherry Trail devices S0ix is not entered unless *all*
> I2C controllers are in D3 mode. This combined with the I2C controller no
> longer working now that we reach S0ix states on these systems leads to me
> believing that the PUNIT itself puts the I2C controller in D3 when all
> other conditions for entering S0ix states are true.
>=20
> Since now the I2C controller is put in D3 over a suspend/resume we must
> re-initialize it afterwards and that does indeed fix it no longer working.
>=20
> This commit implements this fix by:
>=20
> 1) Making the suspend_late callback a no-op if pm_disabled is set and
> making the resume_early callback skip the clock re-enable (since it now w=
as
> not disabled) while still doing the necessary I2C controller re-init.
>=20
> 2) Removing the dev_pm_syscore_device(dev, true) call, so that the suspend
> and resume callbacks are actually called. Normally this would cause the
> ACPI pm code to call _PS3 putting the I2C controller in D3, wreaking havoc
> since it is shared with the PUNIT, but in this special case the _PS3 meth=
od
> is a no-op so we can safely allow a "fake" suspend / resume.
>=20
> Fixes: 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and resume =
=2E..")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D200861
> Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-current, thanks!


--bm3bdhgwp5yxvn2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluIW68ACgkQFA3kzBSg
KbbsHg/+Kvhg63/Hq4TXs6GlusK9KtO0EoUgYS2w/mOTA551DJz5zyXcDoAulKog
iSrjTWGpIPJdX6HV41ZWQheMkMfYavdDdHWRg86Y2coodXU+EOs/bQk3X+LeWbqo
LTefAFu9nL5do7ODkfpNVk1tNxFRXoYWfoLeV9UUYX8Ug0daqlTJv7zEIiiqyaT2
opWEqXTjOI4imTsdBEZewuPa78jUoRcQYY/dmdlfkwNkUFaa9+i7Q4mESo8NzLk8
oglUDejJfFm5lC/26exD7kJmHjlfWmifxJ8uChK6k8us8ydDzTP5lUlBf3bcP3e0
1mPNnOoqt0b70FAkJ5P8Lr0WfzPAyOgln+BYm04pHVwUch8lvsNaTMQkl5Ov17d9
H7qGRdfOJM1cOKdqMMMB0fgL4Wg1Li3J8E70UqO07wDR0G0jwETu/1VOVysCYhGv
wKanIZPlQB1hBHL3XMMVaksxXYZucCXjMaMFW55c1hFN1WateVqAdqSPjCdKBfpT
9Blo1lznZZNFTHORbj3CQDCsTxryAUlqeHkd5FiSnFIo+sZgdHvUnic2cDakdNLI
gxmhURpa0CcaVRf8cN/6DaRCTZup03iN2MCRMqpJEPL5GzpFdAM5XFgqtXlsNCt1
2Xs0HHhwsYJW820Ao5Q6mCqpTTP+UFw4H5dtlOc2DL4CygJ38dQ=
=jEKk
-----END PGP SIGNATURE-----

--bm3bdhgwp5yxvn2n--
