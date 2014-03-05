From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: at24: writing with SMBUS and no I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
Date: Wed, 5 Mar 2014 21:15:53 +0100
Message-ID: <20140305201553.GA2571@katana>
References: <20140305183305.GS27140@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140305183305.GS27140-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The notion of "slow" seems a bit arbitrary to me.  Is there some other
> technical reason or gotcha hiding here that you know of?

$ git show 7aeb96642f70139a194d685b132605836f6f8dbb

commit 7aeb96642f70139a194d685b132605836f6f8dbb
Author: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date:   Fri May 21 18:40:57 2010 +0200

    at24: Fall back to byte or word reads if needed
   =20
    Increase the portability of the at24 driver by letting it read from
    EEPROM chips connected to cheap SMBus controllers that support neither
    raw I2C messages nor even I2C block reads. All SMBus controllers
    should support either word reads or byte reads, so read support
    becomes universal, much like with the legacy "eeprom" driver.
   =20
    Obviously, this only works with EEPROM chips up to AT24C16, that use
    8-bit offset addressing. 16-bit offset addressing is almost impossible
    to support on SMBus controllers.
   =20
    I did not add universal support for writes, as I had no immediate need
    for this, but it could be added later if needed (with the same
    performance issue as byte and word reads have, of course.)
   =20
    Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
    Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
    Cc: Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>

> Would a nicely written patch that adds write support for this case be
> acceptable?  I have not written it yet, but would like to.

Yes, it would.

All the best,

   Wolfram


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTF4X5AAoJEBQN5MwUoCm27BwQAKTHyEk67OYUI7CWmHw7uw+p
G8WcsDCvZfp12hT2ECdcv8dHKXNVhRxg8Bm5cgRuG3731XLoXJ5qgF5Wre22ZtLt
R0AdwjZbG4CH106XksxqejHd93WKfiSYUNQZ70l3mZKli9HAsZ5dy0bz/AjWSo1o
LdvgPBogDGUm9nL+IkUnpueGsZO/izDisL1f3Ouc7HlKVplQV83ug8f+FVRWv5ha
PSamF932nio7oGbvyTLv9phGEfT3GmOEuj5LO0TVfeTQY2SapW1MN08dw/OdzppI
C+Onz8EMOefqMnf0S8iu85k/l1Q5Apxl5mXjIm3QYKYtVCqoZVP7vI/1wwbUGEPR
s21fluZmf1z/PpRcWFkWyNe3yJSLuBtkOQWRCPbsUV+tvFfBhcH4KY6NfBbXJkAg
enTZvSYuapr/b1wEp6g8kyNGltmuCA9cPhFrdNYctqKWvLZoJR1oj1sV2ORvoSi1
ETlYNmSMxNWQckNpEtX4RqYabF6zwWSjCqeQplRwNaSvq8W8SYVq6OKiq3jVsvhZ
zWX5AEoxYuMdEYMfGHV+T9T7ybayHYGwZOhAGyJVq8U5VM2dLicZPm3W8RblMSbA
VT+NvZx8Aq6HEF/pLmyNAYWMEj6M6pq5E+LuCSNvVE8tBABZNetqsb7ZTJKCVFCZ
xDyYvTF69YZ4Y1FAD56E
=l5Fy
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
