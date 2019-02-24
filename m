From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client
 device.
Date: Sun, 24 Feb 2019 14:51:33 +0100
Message-ID: <20190224135133.GC1245@kunai>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219193027.13882-1-jbroadus@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Broadus <jbroadus@gmail.com>
Cc: ckeepax@opensource.cirrus.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-i2c@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 11:30:27AM -0800, Jim Broadus wrote:
> A previous change allowed I2C client devices to discover new IRQs upon
> reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
> assigned in i2c_new_device, that information is lost.
>=20
> For example, the touchscreen and trackpad devices on a Dell Inspiron lapt=
op
> are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> client device structures are initialized during an ACPI walk. After
> removing the i2c_hid device, modprobe fails.
>=20
> This change caches the initial IRQ value in i2c_new_device and then resets
> the client device IRQ to the initial value in i2c_device_remove.
>=20
> Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> Signed-off-by: Jim Broadus <jbroadus@gmail.com>

Applied to for-next, thanks!

I didn't want to apply to for-current because I didn't feel comfortable
changing the I2C core in this very last days before the release.

It will hit linus tree during next merge window and go back to older
releases via stable.

That all being said, I'd really love to see the proper fix (move irq
assignment from init to probe time) being worked on rather soonish
before we forget all the details we know at this moment. I'll be there
for it.


--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxyoWQACgkQFA3kzBSg
Kbazgg//bM6XAh0HokHCQRRLpv3rOJLsay9p6F2gRVw6scYR1QbpZG03nPtzOm/S
UAgXONZIHCaorIqpn/XLv5fFjzGtQExl0hR9iRd8hwnwflAVdkdAYbdTq1+J4hYx
Rs6nMmkUYZOpPbl9XonGz7rfm5kijmUt4A9Y4lY3J/mMQvBgKGsDz5ro4YQQQADv
KVJd+FggH7qr9bbRp97WDJGcS94H6po8nU9pvSRc1bMXzYjmusNO8dkAn90RQZb7
XKfCxaKrt077rAvYMJGYp7Q1rCbvuLvB007bOQ6D4R1lby6oDZtWwad0XWAmSp36
bMqFriFWKA0a1SbaAnBaSo6F7d196ASb8c70bPsyqyntf/Z7hvfjqwIBzEJowbzE
SNFLwGTmHQH0tAJFomXH1ampmwUZyiA9MRsGbEpOsjYBVhQu07x/YqrWQv+nTnoF
NEx9aQ/3d2297EA9eGPZFoFXNzeUuRVUswYhA6HnIwfBLJ8f6h7zus4wjQhFvR0H
l7M8ieAn+CrZNbgwErbmG5iFwdJumsJTB+zlwiaDSioxJEWj0pPNfX7Z5z/zIwjV
jlr+esoyUtwBX4nDCohWc/qhhRcIw+RVCIzQbNaVPlHTBmSzQ269Kw61nhPAcsIB
MJOx6YJP6A/xnko/XQuBYJPbn1mm1vzSout2wJq06SuwmJietKQ=
=cEYW
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
