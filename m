From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C adapters protocol deviation
Date: Sun, 6 Apr 2014 17:37:29 +0200
Message-ID: <20140406153728.GB2609@katana>
References: <20140403145528.GA6199@lukather>
 <533D7E81.4050900@redhat.com>
 <20140404122632.GA3686@katana>
 <53415E50.9000402@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53415E50.9000402-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, boris-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06, 2014 at 04:01:52PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 04/04/2014 02:26 PM, Wolfram Sang wrote:
> >=20
> >> So what we really have is a single slave i2c host sort of. At least
> >> we could model it like that. The host could be told which address to
> >> listen to (and which single i2c write to do to init the pmic) through
> >> devicetree and then all the differences would be hidden in the host
> >> driver, ie we would check the slave-address and if it is not the single
> >> one we support, we just return the appropriate error for a device not
> >> acking, and everything should work as a regular i2c host which
> >> only supports i2c_smbus_read_byte and i2c_smbus_write_byte.
> >=20
> > I'd think we need a new message flag like I2C_M_PUSHPULL which says that
> > this message has only the direction bit instead of the address and needs
> > a parity bit afterwards. In addition to that, we need a new
> > functionality flag I2C_FUNC_PUSHPULL which means the host driver can
> > handle those messages. So, the PMIC driver could query support for
> > I2C_FUNC_SMBUS_BYTE | I2C_FUNC_PUSHPULL and if successful send messages
> > using smbus functions with the new flag set.
>=20
> Thanks for the input this sounds good, I guess we'll give this a shot
> when we get around to coding up support for the p2wi block in the A31.

On a second thought, maybe more granularity is better. Like using
I2C_M_DROP_ADDRESS and I2C_M_ADD_PARITY and then make
I2C_CLIENT_PUSHPULL involve I2C_M_DROP_ADDRESS | I2C_M_ADD_PARITY.

> > Not sure about the I2C-to-PushPull switch: Is it 100% host configuration
> > or does it also depend on the one slave attached?=20
>=20
> The datasheet we've suggests that it actually influences the one slave
> attached. Note that u-boot on this machines will likely already have made
> the switch, but I guess we don't want to count on that.

Can we detect if this switching was already made?

> > Are there some datasheets available?
>=20
> The AXP221 is documented here:
> http://linux-sunxi.org/AXP221
> This is translated by one of our community members from a Chinese datashe=
et.
>=20
> The P2WI interface is (somewhat) documented in the A31 datasheet, but we =
cannot
> share that in public.

Any chance for me to get it if I sign something?

Regards,

   Wolfram


--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTQXS4AAoJEBQN5MwUoCm2VN0P/1PKG5HF5NmnHX07UqNfUxVd
kZxH3E7hWhUHkP3cVFy40TYCDaDmd4+zgpFMLaF8taz/xGbCNu13tBIvhabg3iGB
NvLa8xZWKWIAn5OcxkAr5+kayGJ4m/yqG8P0ZhmPlKfL20REFgYYV25n3il5Ej94
KOLN0eShbo1+wdVCgfGQGQsIM2YQvr3gZJiHX3HVWhmMiYjqd8MrIRGUW7iFhLCN
yh449djbs0BE7q4cww3UTXzmbhdXExnhQ8cQQgSIkTVar0bhG8QhyAi/DMHG8rYk
u+BRUDgrbK6ZlZe6RtvkYEjiUMw5A/Qbst3TFpNmZYSV8aG2ww/G0EUh19ZKncqy
T6VnY4BNOGo2msc45rrYnZvUlbYLRnarVMoIoNGC5mJWE1cO0OQns1pt7y3+1oq/
2YnVqYIhsK9vd2oh0vT8n4w308hNYEY4+gfdmwkNvhFwjuu413hYclq9+iWdmKHH
SG9KPhhjpkQTdZrXqSKe1k3qsyxV9JuVQn6l8HG46SCAjgTeohvzYXYLLpqh666y
7ge5qHPFf0PzdnHbBxXJjEVZCHxcHwtbv7kQxv3VlGpGAiIxvWdoGqMgZeBBNv6G
pYX7SR8U+RRpTfUUOoI6WbtE/QU+8xGYHCBPUyt0yCXL6I7vcdOZ4jMdwb7jUvrD
2JYt2/k1tEFpWtA36qiC
=C1os
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
