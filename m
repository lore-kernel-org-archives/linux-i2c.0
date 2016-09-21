From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs
 to another adapter
Date: Wed, 21 Sep 2016 07:48:35 +0200
Message-ID: <20160921054834.GC1484@katana>
References: <874m5ax3o4.fsf@gmail.com>
 <20160920135925.45450-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43973 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbcIUFsn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 01:48:43 -0400
Content-Disposition: inline
In-Reply-To: <20160920135925.45450-1-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 04:59:25PM +0300, Mika Westerberg wrote:
> When enumerating I2C devices connected to an I2C adapter we scan the whole
> namespace (as it is possible to have devices anywhere in that namespace,
> not just below the I2C adapter device) and add each found device to the I=
2C
> bus in question.
>=20
> Now after commit 525e6fabeae2 ("i2c / ACPI: add support for ACPI
> reconfigure notifications") checking of the adapter handle to the one fou=
nd
> in the I2cSerialBus() resource was moved to happen after resources of the
> I2C device has been parsed. This means that if the I2cSerialBus() resource
> points to an adapter that does not exists in the system we still parse
> those resources. This is problematic in particular because
> acpi_dev_resource_interrupt() tries to configure GSI if the device also h=
as
> an Interrupt() resource. Failing to do that results errrors like this to =
be
> printed on the console:
>=20
>   [   10.409490] ERROR: Unable to locate IOAPIC for GSI 37
>=20
> To fix this we pass the I2C adapter to i2c_acpi_get_info() and make sure
> the handle matches the one in the I2cSerialBus() resource before doing
> anything else to the device.
>=20
> Reported-and-tested-by: Nicolai Stange <nicstange@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Considering this for for-current. So shall we add:

Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure notifica=
tions")

?


--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4h8yAAoJEBQN5MwUoCm2lAYP/jWaWJdy6utifYyf+8GC4Gll
79v/TiE9YfpYsGxhzxKosHCsXM+5QzlWYSOxoux5iQ9CW1tU9mHzfA709oYtq0ci
KsLJjkzoYosf+m36Flb/aPe7lANfWAusXEOVfhOVXWPR6kaO/HMTahli4aISnER0
Oo9YGvI7HHuzvO4zZz2hWRnzhFT1RANqg9TIm6Fk5A2zIHkK2yJW+ab63OOQ1F83
5s/1CYhkuunC5cvu769tBLg3snaTkMKFVh6RkxnhSeZ1l4RK1tsCIKoa2Zr6VDtQ
HRLfeoxONqDr2DIaFDEXrG0TATKaWIIhQO8VApSL/qIM1hhJG7ZXd/bxp51+W6ZE
rJrlzEXbQchv+GDDywAvrExqXnmA7hDxZaxsxZh105u5o4fYc3wJNdDa/ynx9JC2
zgWo92CM5xuDRDRq50uuGV6zyr2WSdg5fhFw8xz24MQT2Wd6UZZc0vjdv7YxCcC2
FlWQt/OUovHgaXXW6bHFu6cUzPebGyUeMcD4x9ITZdc+7aTN8Y/c5vfZx3xo2od9
Ryh0+JTcAJEmV7M5qdHQHi79RYpFK3IjlFGxYZdT1ER/8s7stULWfRG9RSROtRFe
5s8w5QMwpGeAlxJ3RqbygjyQECOORqc6RryCByC7EBHjHaApyWPUrls/KF+PsO9B
STOHF7vYvUGMN/8rIRzt
=GHu/
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
