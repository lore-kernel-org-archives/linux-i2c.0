From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: Add driver for Cadence I2C controller
Date: Thu, 03 Apr 2014 09:25:47 +0200
Message-ID: <533D0CFB.7050707@monstr.eu>
References: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com> <533CF913.4020308@monstr.eu> <20140403071004.GA2571@katana>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uRFjPXGuh6ecXObbHBHLfOOWu4XTNMNbB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140403071004.GA2571@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uRFjPXGuh6ecXObbHBHLfOOWu4XTNMNbB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/03/2014 09:10 AM, Wolfram Sang wrote:
>=20
> Please don't quote large parts of the message f you are not referring t=
o
> it.

Normally I do it. Forgot sorry.

>>> +#ifdef CONFIG_PM_SLEEP
>>> +/**
>>> + * cdns_i2c_suspend - Suspend method for the driver
>>> + * @_dev:	Address of the platform_device structure
>>> + * Return: 0 always
>>> + *
>>> + * Put the driver into low power mode.
>>> + */
>>> +static int cdns_i2c_suspend(struct device *_dev)
>>> +{
>>> +	struct platform_device *pdev =3D container_of(_dev,
>>> +			struct platform_device, dev);
>>> +	struct cdns_i2c *xi2c =3D platform_get_drvdata(pdev);
>>> +
>>> +	clk_disable(xi2c->clk);
>>> +	xi2c->suspended =3D 1;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * cdns_i2c_resume - Resume from suspend
>>> + * @_dev:	Address of the platform_device structure
>>> + * Return: 0 on success and error value on error
>>> + *
>>> + * Resume operation after suspend.
>>> + */
>>> +static int cdns_i2c_resume(struct device *_dev)
>>> +{
>>> +	struct platform_device *pdev =3D container_of(_dev,
>>> +			struct platform_device, dev);
>>> +	struct cdns_i2c *xi2c =3D platform_get_drvdata(pdev);
>>> +	int ret;
>>> +
>>> +	ret =3D clk_enable(xi2c->clk);
>>> +	if (ret) {
>>> +		dev_err(_dev, "Cannot enable clock.\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	xi2c->suspended =3D 0;
>>> +
>>> +	return 0;
>>> +}
>>> +#endif
>>
>> Can you also please remove this #ifdef and use __maybe_used
>> instead? Better not to have any ifdef in the code.
>=20
> Is this a new pattern? For PM_SLEEP, #ifdef seems to be quite common.

The first suggestion to do it came from CAN maintainer.
It is valid in general for ifdef.
I have checked all our drivers and we are changing them to use __maybe_us=
ed
because then we can easily find out if there is any problem
when function prototype has changed.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--uRFjPXGuh6ecXObbHBHLfOOWu4XTNMNbB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM9DPsACgkQykllyylKDCEcfwCfQsLUeOED+rmyClPSDfDT/DKn
EgEAnjgSaJsz0mfHflcF8d2GEZwYhQGL
=hV/7
-----END PGP SIGNATURE-----

--uRFjPXGuh6ecXObbHBHLfOOWu4XTNMNbB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
