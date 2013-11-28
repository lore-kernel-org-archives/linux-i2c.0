From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
Date: Thu, 28 Nov 2013 09:50:17 +0100
Message-ID: <20131128085017.GC2626@katana>
References: <529303EE.4080606@koalo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <529303EE.4080606-oZ8rN/sblLk@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 09:01:50AM +0100, Florian Meier wrote:
> In order to find I2C devices in the device tree, the platform nodes
> have to be known by the I2C core. This requires setting the
> dev.of_node parameter of the adapter.
>=20
> Signed-off-by: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>

Fixed up for you and applied to for-current. But PLEASE fix your mailer!


--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlwPJAAoJEBQN5MwUoCm2J8QQAKCyUzykyZEV58gQoFIClmjH
dKB/IUlSwijhEwyC2uMi/a+M0/HgeM1/vgmkfzYBLtHQXz11MBx/PVBBHbHekH/U
IUYbvRZzKRqEJBqHmC6Dsh8cTtEn3ZhyAIWaiLuK0sDCJnZqUm+JeHWQ+622yi9E
uu8/AM6wLtge9xhH3Ri5ZNW8QrjF4UoWt14uyUdRFG2FoQZ1j7vI82gSobJJIXDy
EjVhq/iTNhQKRTN5MXkL9sjCxa1BjeRCbGQXGYZm8PqfRXCjzO/pKNnkX3+fFlzi
hW3lSZbs4ptoQ/nOH3PFIRU72mvaR/Lbz45bA0OvXLX8/l4f/FJQIwLSL60E720h
sEi2a8eisjL8XwyzzKtX3OlKHQ9nGMhHLQsk5ggJswSGGcPutzPQrgDzapx2bjIz
bbU65jTn+oJQlDl6eU9M3fpCbZatpY3i1JUJb9T9TRsNQ1/L8yKjwi/OwyNRBv7d
oxepaAZYqAMUSTX9OmnTYS2F43DL2dvViGeXgXw2ZAPHYret21tJFYtNdzyrcoNN
HbbWa0fw8hNwi85QjBAfcxFvimaDEhq75TQj9GJ0UKMZ+9oI+HeCpus1TUbiQLzI
EP4j3BU2VzBRk9IL9M2ZZZKOJz1+gKb9HIxy2HRcRj6M0ndnrki7eURIdRIiiEyk
OufzY8PvkfETw2bOLJZg
=yD/A
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
