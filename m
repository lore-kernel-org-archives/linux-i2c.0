From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Add generic support passing secondary devices
 addresses
Date: Thu, 14 Apr 2016 21:10:33 +0200
Message-ID: <20160414191033.GC2338@katana>
References: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43714 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbcDNTKm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 15:10:42 -0400
Content-Disposition: inline
In-Reply-To: <1454254380-9246-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, laurent.pinchart@ideasonboard.com, lars@metafoo.de, Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 31, 2016 at 04:33:00PM +0100, Jean-Michel Hautbois wrote:
> Some I2C devices have multiple addresses assigned, for example each addre=
ss
> corresponding to a different internal register map page of the device.
> So far drivers which need support for this have handled this with a driver
> specific and non-generic implementation, e.g. passing the additional addr=
ess
> via platform data.
>=20
> This patch provides a new helper function called i2c_new_secondary_device=
()
> which is intended to provide a generic way to get the secondary address
> as well as instantiate a struct i2c_client for the secondary address.
>=20
> The function expects a pointer to the primary i2c_client, a name
> for the secondary address and an optional default address. The name is us=
ed
> as a handle to specify which secondary address to get.
>=20
> The default address is used as a fallback in case no secondary address
> was explicitly specified. In case no secondary address and no default
> address were specified the function returns NULL.

With "no default address" you mean the function parameter is 0? Yeah,
you get a NULL pointer from i2c_new_device then, but also a dev_err
message, or?

> For now the function only supports look-up of the secondary address
> from devicetree, but it can be extended in the future
> to for example support board files and/or ACPI.

Ccing Mika. I think it can be 1:1 converted to device_property_*
functions already giving ACPI support for free?

Thanks,

   Wolfram


--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXD+spAAoJEBQN5MwUoCm2TiwP/0iUg3o9bE3B8ZisIBQNn22P
T6N8o3hLBkp33dd+XC+FXRUBzAao+dp8Vk24zWvs+G404KDXjRo+7p8V+q7Y/oZx
DQxG3AzCqlYMZS+Awi06P/sWy8ByHZMh/tc7MNXhBcNe3CdoNTLVwrJ3+lyfWDlK
kaMlpjYyAwMlmTb2eBzF19F9npD/dIN9ozRRtrIyGMm8Ai9+1Df/lY223S/1yHSp
hlgMAuklmjuwJulKDi+khXioIUgUWkmYJiDzptPkc4aVkSs3zRBjcVh2EH+vOD2U
QKUmFQLSrajOPplJABtp9jwme8Htkd6BP/1q9RJvTd/5JDNckbfSE5qdRUQezs5i
MNWdTAJXTlQGax3u+el1esm+AmBoxVGKyZg4BR5+ACFvBYpnpvJjFKkLRSJ+x+HC
3LiG0tkSlHXJN3xNtijA1goGly56Jncs3gs8j5ywvQzyZ+bzW4MTizs7sqDhpoUK
Vr/rqSba0Dovh/hWazPnNqsuJOBgtXBAOtvtO2t6tbiwE4RkXO8/CXeQJjCmxZrp
Y5/UWrNW3yxmkqNGQjB8HH5N06Ak1xVq4L8M5t8uvgzPgBxMzJOO2AeWSlvPYKtH
fa6Fokb4Z0f5xfaiEEaoPEdzl+I95kIUSE9cApRmuRT3C72Zta4caOA0GhLumOni
+m12WnfdgfyEzREl5mRZ
=4ehH
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
