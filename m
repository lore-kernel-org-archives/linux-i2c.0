From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: designware: Never suspend i2c-busses used for
 accessing the system PMIC
Date: Mon, 27 Feb 2017 11:30:38 +0100
Message-ID: <20170227103038.GA1432@katana>
References: <20170227093830.3416-1-hdegoede@redhat.com>
 <20170227093830.3416-2-hdegoede@redhat.com>
 <s5hshn03p8i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:46370 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdB0Kam (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Feb 2017 05:30:42 -0500
Content-Disposition: inline
In-Reply-To: <s5hshn03p8i.wl-tiwai@suse.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 11:25:01AM +0100, Takashi Iwai wrote:
> On Mon, 27 Feb 2017 10:38:29 +0100,
> Hans de Goede wrote:
> >=20
> > index a8e74ca..a4ac473 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.h
> > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > @@ -79,7 +79,7 @@
> >   * @pm_qos: pm_qos_request used while holding a hardware lock on the b=
us
> >   * @acquire_lock: function to acquire a hardware lock on the bus
> >   * @release_lock: function to release a hardware lock on the bus
> > - * @pm_runtime_disabled: true if pm runtime is disabled
> > + * @pm_disabled: true if power-management should be disabled for this =
i2c-bus
> >   *
> >   * HCNT and LCNT parameters can be used if the platform knows more acc=
urate
> >   * values than the one computed based only on the input clock frequenc=
y.
> > @@ -127,7 +127,7 @@ struct dw_i2c_dev {
> >  	struct pm_qos_request	pm_qos;
> >  	int			(*acquire_lock)(struct dw_i2c_dev *dev);
> >  	void			(*release_lock)(struct dw_i2c_dev *dev);
> > -	bool			pm_runtime_disabled;
> > +	bool			pm_disabled;
> >  	bool			dynamic_tar_update_enabled;
>=20
> I couldn't find this dynamic_tar_update_enabled field in your previous
> patchset.  What am I missing?

It got reverted with 12688dc21f71f4 ("Revert "i2c: designware: detect
when dynamic tar update is possible"") around 4.10-rc7 time.

I also wondered that Hans didn't get a merge conflict somewhere.


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYs//OAAoJEBQN5MwUoCm2lawP/RZ+C1ceebOYHdd4hLvRlxBG
kwvsYNuX4yuSb8p/Uhp0zVrgN3eqZFAQGS7Mkx8GS3eHSgrebKHS6tT1TTvs8cMJ
RAQZAUv4bI9YaMek7SWdPurcuxX4TOKHWun3xsJhxviVhlUXtA+6jj5O3zyx762H
dp4DayRHx+A8LAiyEVqvoQNsJrbXSL4tK8mPfJqGcqgqt84UiFcbgiPbZ8qgX+ya
0w58LJtXTsbGcpa6BmkC2TILV22kTrKe899uMygpacauCybwf1nb2HhNZkDrP5V1
Ju/eQptofkHdtILmWfkBM2hefF5ZDVN402kzw1Y7xumC3VQzTg+Lllq1rOsrR9IY
6DeLhXCZBvXxIH3PLr0EGCMNhzQu/lrzpifHqMCkjKnViLVdRmeNHM+Axxm4FB78
iU3//bbHVL3tdg94IGhMxpRK6qmm7e/2UD9OK0rk/zj2D2nfj+abQk/hEMKb8zcG
8wV/rXlEyxIFAbhD+dhfJte0WbbiYk5tV/kl46fngxxPsdhh/jean9CcSHlnkKWe
t40UtPJ4jPPP6R17Ex5Me5K6iJdx8OQMCGwtN2kBiJBdKT2ZTmsfrsGRhFmJVCMd
bv4kIlo8fh+NPo/5qWOkzcjLh5c3PCb9KC2gNY3nT4GdgYk9pCnEx0q14fDecgVk
qRCU6bBI5VxLqTfYUG4j
=mMsO
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
