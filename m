From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCHv5 3/3] i2c: altera: Add Altera I2C Controller driver
Date: Mon, 31 Jul 2017 22:16:29 +0200
Message-ID: <20170731201629.GC1542@katana>
References: <1500309314-18464-1-git-send-email-thor.thayer@linux.intel.com>
 <1500309314-18464-4-git-send-email-thor.thayer@linux.intel.com>
 <20170731133124.smwztpkul2qjy26p@ninjato>
 <305220e7-4ae2-ed44-e4ec-2abf9b3c38f0@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <305220e7-4ae2-ed44-e4ec-2abf9b3c38f0-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >>+	writel(ALTR_I2C_TFR_CMD_STA | ALTR_I2C_TFR_CMD_STO,
> >>+	       idev->base + ALTR_I2C_TFR_CMD);
> >>+	altr_i2c_reset(idev);
> >
> >Why the second reset?
> >
>=20
> I wanted to start from a known clean condition. The first reset would res=
et
> the hardware. The 2nd would ensure the hardware is ready after clearing t=
he
> bus. Maybe I'm being overly cautious but I don't have a way to check the
> status of the SDA line.

Well, it looks like the function will go for now anyhow...

> >>+		altr_i2c_recover(idev);
> >
> >And no need to reset the bus! Only if SDA is stuck low.
> >
>=20
> OK. Unfortunately, we can't check the state of the SDA line so I was being
> extra cautious. I will remove it.

Thanks. Bus recovery really needs a testcase to be checked against.

> >>+static u32 altr_i2c_func(struct i2c_adapter *adap)
> >>+{
> >>+	return I2C_FUNC_I2C;
> >>+}
> >
> >No emulated SMBUS?
> >
>=20
> I was focusing on I2C and wasn't sure about SMBus (particularly the minim=
um
> clock speed). SMBus could be added later but would require some IP change=
s.

I meant you can add I2C_FUNC_SMBUS_EMUL which makes the I2C core emulate
SMBus-style transactions via I2C messages for you. A lot of drivers
won't work if you don't have this.


--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/kBgACgkQFA3kzBSg
KbbRtA//VpurhfrQRG8nAXdn70iperOPJ4rO5zKKpiNWcekxb/gpNKtp3aEPIj2x
Tp3skhb9s32fmHrVbVby5iVuXVWuUCx8yKPBi3yv/EulqPZzMiKf02GVymLSfE1y
/ZgzRYu0xQ3J7NlyirZzOvTJXePSd9RZT32HrcOfRFAQeRhWIEBN9G9DFkD/Bh1d
i/OQFpJ0J5jHBDzE8Gliu4++SCbsUf9qTpRwyBnrMHzlqtwgpfpplG9Hl1or7ank
25eyyCeacBE4GO9hoE596ditrY7lhWicbJiWlHJH37NtTjqN/1KeQepN9K9m4BMs
uyImirNf+ZVQW2GpafwWa7MXv98n83O6tvBpmB1XJIe6Uq2T09xsYIWiB62Nnadj
cGMGyXuwloUC42Fhd5fp91rlvTRY4EMcdVCKWcFi4ulCOxARTQ7kAuf3G+E1lj9T
tj/aBlWjSlhcKVHRx8+cTaztQmQia6tHQh3GChIa7nZnJ356mrJkD+zRvzO5gDr8
dVr+mwkADkpyKdBEQkpGNsp6NPtOjuVONyomE57/uJ4warYfBe7t4j1DZkyT8TW/
CzdW6pNe5qH8wVhYgirKC7SFeh5LLMzjYiVWqOBqbH1NfFq2ndxjb8GbbtvkcpXV
Qk0UKRnRxltqhXWwX5pXh0gs2GrJxTm1w1e3WGo6/4KqiVclUj0=
=vnDY
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
