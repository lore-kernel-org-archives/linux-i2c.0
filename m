From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 0/2] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Mon, 24 Nov 2014 13:15:55 +0100
Message-ID: <20141124121555.GG3733@katana>
References: <1416821928-11453-1-git-send-email-xudong.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416821928-11453-1-git-send-email-xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

some very high level remarks:

On Mon, Nov 24, 2014 at 05:38:46PM +0800, Xudong Chen wrote:
> This series is the third version of Mediatek SoCs I2C controller common
> bus driver.
> Compared to the second version,
> 1. Add comments for clock in dt-bindings file i2c-mt6577.txt.
> 2. Remove mt8135.dtsi because of the dependency on pinctrl and clock.
> 3. Encode the feature have-dcm in i2c-mt65xx.c by checking the compatible.
>=20
> This driver is based on 3.18-rc1.
>=20
> MTK I2C HW has some limitation.
> 1. If the i2c_msg number is more than one, STOP will be issued instead of
> RS(Repeat Start) between each message.
> Such as: "START + ADDR + DATA_n + STOP + START + ADDR + DATA_n + STOP ..."
>=20
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver will
> combine 2 messages using Write-Read mode so the RS will be issued between
> the 2 messages.
> Ex: W/R/R, driver will combine first W/R and then R.
> The data series will be:
> "START + WriteADDR + DATA + RS + ReadADDR + DATA + STOP + START + ReadADD=
R +
> DATA + STOP".

I think there are now 3 drivers in my queue which are not fully I2C
compatible but more supporting the very minimum to, say, read an eeprom.
I am not feeling well to allow them to use I2C_FUNC_I2C. So, I want to
think about ways how to communicate deficiencies like "only 255 byte" or
"only WRRD messages" to users of that I2C controller. This is most
likely not happening before 3.19. But assistance is very welcome.

> 3. Due to HW limitation, in this version the max transfer data length is =
255
> in one message. If want to transfer more than 255 bytes, HW needs the SW
> driver to split the data. Take 600 bytes for example, the data need to be
> divided into 3 parts 255 + 255 + 90. The data series will be:
> "START + ADDR + DATA_255 + RS + ADDR + DATA_255 + RS + ADDR +  DATA_90 + =
STOP"
> instead of "START + ADDR + DATA_900 + STOP".
> We haven't implement this yet, we will do this in the separate patch.

I don't like this idea. If somebody wants to send 1 message with 600
bytes and we can't do this, we should simply say so. Sending 3 messages
is not the same.

> MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> registers in MT8135 side. In this case, driver should set OFFSET_PATH_DIR
> bit first, the operation on other registers are still the same.
> For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not support.
> For example, If want to use I2C4/5/6 pins on MT8135 just need to enable
> the pinmux, else if want to use I2C pins on PMIC(MT6397) need to add
> "mediatek,have-pmic" property in the .dts file of each platform.

What about Sascha's idea of using a pinctrl driver?

Thanks,

   Wolfram

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcyF7AAoJEBQN5MwUoCm2RP8P/i31DK9LQQBoMXSxgNZp+NjC
6Ko2BPCjQVOT9lhb7yjizST4HJeBYwFjwUWkdf4VbvyO254+Ei6Mf0jEU2/WphOv
GLKxB4Ruo45VH8beoII+s16NldOphyCa9PC4FiGs7nq9Kp/dGEcmBmURbPvNEAcX
c4Y9cNb1WAhO4fnDZSD3mPOusDsm8Ht4IJJr3u21P9AuIuMRTz2YLu55lMGGfPm8
mflV4DNi1Uur0AC98xE19DZwVE0MqWqXjkI1bG+e+A0e3fHrlPPBcAlsufZ5YWCo
piPEh5kEcUJ5Ld96/p9ePHWdtr/Owm9iwPurM+xlaRoZXSmy8zBiNDB/sLRaVmL5
86c4l+6+FOFxUZ+ut/S8KePHhUMTG6Ao/q+V4UBbLIRIVRzQlDWA3ni4kU+t7EdD
1g8ndpPfydTE3qf8PXNS6saXXU0cmwco8ZNMfk7KvDeDDnSrRQZbVy2NFm85CGRL
ywc74A4vONoyBf9gM58zUHJp8BZuh73RZ/jyOb7NGCaxNLOgtvTRXCD1woq+sLCK
IYJWOBLwTHtfWMD0qam5um/b7CqGACplfC3MiUbc0UfaUZnttoze+Sp900uH607P
UF+t3Q40txfKnosXUCt2d2p8NxrO69Sf4u7eRlbycwa++NxwlqYVOOgpihCDHlIs
/vY0NHRhDEUPpxaTygNJ
=M4Eq
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
