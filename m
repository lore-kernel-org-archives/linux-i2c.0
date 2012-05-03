From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c/nomadik: runtime PM support
Date: Thu, 3 May 2012 14:39:07 +0100
Message-ID: <20120503133907.GG3955@opensource.wolfsonmicro.com>
References: <1331213407-10135-1-git-send-email-linus.walleij@stericsson.com>
 <CANqRtoTbW2ew9ZwYmdJAaiD5qujZ-43eCfT=myDQdeYScwiBzQ@mail.gmail.com>
 <CACRpkdbj+cF7d_=QmqtXTGS4s3Jrr7vxnrt5VbHMDO=an_cVow@mail.gmail.com>
 <201205031459.25262.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205031459.25262.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rickard ANDERSSON <rickard.andersson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Rabin VINCENT <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2012 at 02:59:25PM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 03, 2012, Linus Walleij wrote:

> > If *all* runtime_resume() hooks for *all* devices in the same power
> > domain are called at this time on the way up/down we get a major
> > overhead as our primary power domain is pretty big.

> FWIW, in the generic PM domains framework used on the sh7372 platform we have
> a need_restore flag whose meaning is whether or not to call .runtime_suspend()
> (or its domain-specific counterpart) when the domain is about to be powered
> off and .runtime_resume() when the device is resumed by the runtime PM
> framework.  Those two callbacks are meant to save and restore the device's
> state, respectively, and there are two more domain-specific callbacks,
> .stop() and .start() that (in the case of sh7372) manipiulate the devices'
> clocks.

> So, if pm_runtime_suspend() is called for a device, we first check if it's OK
> to call .stop() for it (according to PM QoS constraints), but we don't call
> .runtime_suspend() for it yet at this point.  Next, we check if it's OK to
> power off the domain containing the device (taking PM QoS constraints and
> subdomains into consideration) and if we decide to do that, we call
> .runtime_suspend() for the devices in the domain, but only those whose
> need_restore flags are unset.  Then, if pm_runtime_resume() is called for
> one of the devices, we check its need_restore flag and call .runtime_resume()
> for the device if the flag set and .start() is called subsequently.

This seems like a really useful idiom in general - might it be worth
supporting as a standard framework feature?

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPooppAAoJEBus8iNuMP3dsugP/1N8RxUGuVLq0VLv56JNaGIz
tDFXvORAztgJTX03U68/qDTkgxueVk0Q1NU2gGX3GXkYnkWnxja+o+CpSwIvZyY/
QL7ybKAGnnWaP5gO19d/uEQnI4upl3ijNV/IbSoujwxF8B3zCF9b87jUARMDr+Ir
AYaW6p10/Qp7/+zYZYNVvPJDmcoGRWX24eM6OvB6W3YAv9hUfPnBPnAEjjt8K6u/
YDPDM2sY7u6W0lNhihObIMeSKfagaHowv48aWRkBydYygWPK6ZiRCxvRaWIHKaKy
XYSibtpfFHX1o4JaLO9xQr/Lypyrs8TU9dDQ0vPDi7sgl53EaFxBVhHQ415SHrXG
hqB4y4deURCe/QEMK/752VDyJD74CMJh2HF84WV6ln9BuACDbPvHWO46j9LimD0Q
bYG4uh/bYp2rAF6vMpTLGSChfE4tlxv1Cyor918O6TxB42uuxaNJ+QvHmxxFGjpd
AglLXGuPjQNLE5tQQrn2Rt7gM0TDZQJTnubefSnG4EqyY8vM0QlZvSUwW6sH6lWe
SRs7vsTPW49Pj2IdVqVsvhde9Qi7E+vYir2qp6jbinCeEjDK0fRscJcRDshMTyC+
ZabYjWPWBydpUkKr5cSuN1doTl/EV+1EqcQ45Kt55qOOj3fzCfB/0w1vIyKOLEJJ
KSo0ciT9Y2rvPSF3AEl8
=bLrE
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
