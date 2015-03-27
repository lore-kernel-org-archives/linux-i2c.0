From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Fri, 27 Mar 2015 09:09:47 +0100
Message-ID: <20150327080947.GA900@katana>
References: <20150205175326.GA26691@roeck-us.net>
 <20150212040126.GA1691@roeck-us.net>
 <20150216120951.GA2840@katana>
 <20150317042049.GA6765@roeck-us.net>
 <20150318132707.GD3580@katana>
 <550A4162.8000009@roeck-us.net>
 <20150319081612.GA900@katana>
 <20150319174314.GA17329@roeck-us.net>
 <20150319213937.GA899@katana>
 <5512C213.7030705@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5512C213.7030705@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> just to give you an update: I do have some code, but it is a bit messy,
> and it doesn't work well for ds2482 (the chip behind it still hangs up
> if I access it in parallel through i2c-dev). On top of that, it causes
> pretty significant slow-downs when accessing other devices on the same
> bus at the same time. Not surprising, I guess, since it expands the scope
> of the bus lock significantly.

Just to get a better idea: Did you try taking the adapter_lock before
the two SMBus command which needed to be concatenated (and use
smbus_xfer directly)?


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFRBLAAoJEBQN5MwUoCm2kwYP/jzPAOPXlWVWBDud5m6//C/H
OlUOAaoYkIQMWQqAAJSm+dLT0sv73mCy2UTusMQ/YkdZymv6bjgulEpXQrk7cNTW
XLViBtHA1d4Apxe3ZW6Bcmcjh81h9NWnLQ2ePdMIbfUGZvqb+aCQXFNczW9dIrly
x4gnvghvRpL/xu4v07jJs909FqTy21w7rjQjGIuDvd5AkkqmG3IHB1wKj2TAPHp8
WIGq0Ygji90I9aQ6hJwDXy12/7+lT8kHADD/QEYzkhbLn8xfFWxTM01yLl2zhil1
C7y9GhFNTJVeL6t/Kpm1ukdfdfogItajEm8xDqeEI4wZ+rsg/01Dum9dRNBay/S6
KpYlXKrukIUp3FuveuFYTNUfEk6j23Q27QBgTyhJ1P8e2cdsbsWr4d4SDSXeJOnh
nj6NMtSqKRkvssIZqwqdnYDuW8DVk4cN+hSzwb6uWlzUMcmc7PmepjBl1suxiZvP
wh9CAXKP/bgnj4OzZm/4wEMbmXMAWIRo64GbCMK/8Ay5AywpcVVFcNZw4pYTlfNL
akTcnVDxelvx+kroRoYKuRiipw4P6/7xxcbpk90C/MN9AKqXlP+nauHxnrYO4fN5
5m/K+hEUC+pe7ar7acqV1B27cWHLV82K8juruQpd2McMG+ugjoqeHf4XRdbBDfkl
3W1/N0ULvUoyhT+Ihy7H
=05KJ
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
