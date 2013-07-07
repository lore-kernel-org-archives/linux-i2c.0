From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: MTD EEPROM support and driver integration
Date: Sun, 7 Jul 2013 09:15:01 +0200
Message-ID: <20130707071501.GD11243@lukather>
References: <20130705201118.GM2959@lukather>
 <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather>
 <8997501.Dchyii8uWX@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8997501.Dchyii8uWX@wuerfel>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Artem Bityutskiy <dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2013 at 09:06:49PM +0200, Arnd Bergmann wrote:
> On Saturday 06 July 2013 14:01:12 Maxime Ripard wrote:
> > What other option would we have?
> >=20
> > I also thought about writing an EEPROM framework of its own, but the
> > line is really thin between a large EEPROM and say a small SPI
> > dataflash, which would make it pretty hard to choose between such a
> > framework and MTD.
>=20
> Isn't flash by definition block based, while EEPROM can be written
> in byte or word units? I think that is a significant difference, although
> it doesn't necessarily mean that we can't use MTD for both.

Ah, right.

> We also have a bunch of OTP drivers spread around the kernel, it probably
> makes sense to consolidate them at the same time, at least on the DT bind=
ing
> side if not the device drivers.

=46rom a quick grep, the only one I've seen so far are:
  - imx6q, that has a hook at machine start to poke into its OCOTP to
    retrieve some frequency scaling parameters it seems. I'm not sure
    how the current solution could improve the situation for this
    use-case, but the DT bindings of the OCOTP is just a DT node, with
    no clients, so we have nothing to worry about here.
  - imx28, that has a hook at machine start to look up the MAC address
    values and patch the ethernet controller nodes to add the right
    local-mac-address property. This one could benefit from the new
    bindings, but we already mentionned it, and I intended to develop
    with an imx28 board anyway.
  - picoxcell-pc3x3 DTSI has a node for a OTP device, but they don't
    seem to be doing anything with it, nor do they seem to have a driver
    for it. So I guess we don't care about migrating for this one
    either.

Did you have other cases in mind?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2RV1AAoJEBx+YmzsjxAg3MgP/28+VaY/douvBkwP4UzPleKc
UKrWHu6PLr6C2IMnOP5b1w1JsGIdCuRRsyWuqxkjimtaglFHyYiLVxwRPjbddtVz
+pwTqOCkjsGvRSEEC6Dru9d+hQjA9oTci7UouGisKXwf2GY4cBm39SfGeAXh7TDS
ucj7v20gf26rtTt8ivIOko4LOWlBWrEZ/YwiIz2cIA8oXZn1peidVNdNzaQXm89x
xQ1JC5CrgVqTjVORBUpUmzv8hGNrnl+1pRTIRAKXkGhnkH9kZ4sywAGzxrRXwvAl
R+59C0CD3WhEncjFomXPB0aJlyPBPSJCHCOLdAYCmNJr0Gf4Nz6qkJagavXzqVHb
SFGjwLs6QAsNB1eURtglquOS412jbmUuno+EZCWhHTgAFOG0wQIpbdLgSeEPzQ2Y
TbOZVCNWy0HFDIgrPHRxrkx0De5dsMkY5QHNu/4tM1w3HQKUAqWY4ZXPFkMgmXo3
/l2WhhCYxSlDPov00rUnTVKWhORdo2nwv0lr3wdw63YI7Acng59bXZX+Hc6+FnOc
Y4kyA3p4g0+8XB72zgBBGB/QtV0CH8AqnNVD5MdTYWJm5KqLOk/ZJbYt9X/MNGns
ca1uzM3Ws9+9/jVtKMBNGXHfPAWdQZzM0BDvoBMLdsXchfeAyBgwXF/4nq8Qhy6d
bXEmpq86Y0S0fjipbyPC
=ZbQ5
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
