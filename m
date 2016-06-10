From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC v2 2/2] i2c: Pass i2c_device_id to probe func when using DT
 ids through ACPI
Date: Fri, 10 Jun 2016 09:04:24 +0200
Message-ID: <20160610070424.GA1552@katana>
References: <cover.1465477193.git.leonard.crestez@intel.com>
 <f5d92224a005bc7b82e210957719b7be142c6388.1465477193.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37141 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbcFJHEe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 10 Jun 2016 03:04:34 -0400
Content-Disposition: inline
In-Reply-To: <f5d92224a005bc7b82e210957719b7be142c6388.1465477193.git.leonard.crestez@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 04:06:03PM +0300, Crestez Dan Leonard wrote:
> When devices are instatiated through devicetree the i2c_client->name is
> set to the compatible string with company name stripped out. This is
> then matched to the i2c_device_id table to pass the device_id to the
> probe function. This id parameter is used by some device drivers to
> differentiate between model numbers.
>=20
> When using ACPI this id parameter is NULL and the driver usually needs
> to do ACPI-specific differentiation.
>=20
> This patch attempts to find a valid i2c_device_id when using ACPI with
> DT-like compatible strings.

Note that this DT behaviour is about to be dropped to match I2C with
the "generic" behaviour".

https://lkml.org/lkml/2016/5/4/534


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWmZ4AAoJEBQN5MwUoCm2z+EP/Rf0AXiIN8ZV8KQNuP2MwZEO
y5ENw1RDquLkQ578Z7N5NPWT+wfk97xz4snyxF3aCxwGkvh9UbNhN+2AXKqgYEXX
82UEdReK38TgZkxgUW6H4lOtLwgJfk/7It2XPZjnu0/2OVGtEdZfsxjjhYALvVBM
7++NppbUDprUO9s+AdX7fQiVMOD6Zin2iGfrXbmdZ5PMVRg1CqyGKpk5vvISwLqR
gJ/biyAAf/c1Bz7DcWE99irH1SJNdyvefTXKVW+wwRkVCbgCjHLwDR3kRBCwd9qt
ZR4hNApPk1yFLQdbXxWfXyEtuH+5SQzVJszzDhXh+cIGZ+uUHo4UPhW4GMAmy7di
hfhLwGuxo1/eoMSSF7fJSSWTG9IhSgLewlHurWHTqlLMS9vRb/TmU7H9JMLfYpZa
DackKeJMsHEc9qQ8vpwobnKq7XaUxXuaoCpAczgc/VD7P1/xL4S342MDVc9B6Knn
0L+oFLHuWDrBGllWXTsbFVXNw71z9B3sSVy3UdZPHsbQpm1qz2TGsWyBlCQhHn+O
8DJ/1Xz50XHep9PW8UE5DiZYZT8XecGisQp4DVSL8lI6RPdv4YRcEmVs2LFDmd3o
ZSCeoL3AZyvvc4+2ggBjKyJOMeicCRd5zjjd6BpUWb6UwY/Jpwa8GbCOeVc/oN58
JJr3cvY4H+XvA+sUh/dW
=ohvP
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
