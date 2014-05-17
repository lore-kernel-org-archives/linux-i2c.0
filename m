From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V2 5/9] I2C: Add smbus quick read/write helper function
Date: Sat, 17 May 2014 19:15:56 +0200
Message-ID: <20140517171555.GA2597@katana>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398695268-28645-1-git-send-email-tianyu.lan@intel.com>
 <1398695268-28645-6-git-send-email-tianyu.lan@intel.com>
 <20140517094120.GA2602@katana>
 <5377607F.9010800@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5377607F.9010800@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@rjwysocki.net, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >2) It uses a parameter for the r/w bit. Make sense to me, since this bit
> >is the information we send to the device. quick_read doesn't make sense
> >to me. We don't receive a bit from the device.
> >
>=20
> Hi Wolfram:
> 	Great thanks for your review. Ok. I will follow commit 67c2e665 to
> bring i2c_smbus_write_quick(struct i2c_client *client, u8 value)
> back.
>=20
> BTW, how about i2c_probe_func_quick_read()? Should we replace it
> with the original i2c_smbus_write_quick()?

As said above "quick_read doesn't make sense to me. We don't receive a
bit from the device."

Start implementing and you will see why we don't need it :)


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTd5lLAAoJEBQN5MwUoCm29ocP/0n3kCnsZhboHNy58x9TY6oM
yHYu7WtSUGREecAOE04gVdSaM2K2/ttfuBujdj2HPzLDAPZV9md4X1mO2VHRJdBJ
xKhRxpJbfxnh9XqcjNe+jN6ila22zV1Iigp8VMHKNPDzjIhu/upUSomrVvFN80B7
VHgWQDk8ReySiF2/zwlVlAI5QOPyhEb8GuS1ke0aM5IJKdOAPS5QlcfBVJAH3nbJ
pvtWcL1PngHuqlYd2OWCUezWe46LpU3jyHslCZuEml+fuXa58cqXHffFR4aufvPa
nYD5kFFxiC5AEwU5DW+bySXmTWEzOxwNg58tzsf12OLLf3/LvXLipYJBOFdi1/+O
BsanvqM+qscs1x0w/NcB8p2Ab1g6dcr7dwxRPlw91mTdjPPOXbGMUDtEzhzhavqH
Y8c78zsSA95AJdNp3XA69aEhutwk2lWh4VX7ra9Hk7Sr64Mk3AaRqO6nJ7vqWw1o
ABMihCy2uCAn1W3opHno3CWeBVxvGugMuV168mMSO9KH+myYT/0dfQZvybSG63sf
qjo2NE2hflvMXctoQflEqJtt5fntHn+ckFcz1zE8RmypU+4Y/KwnthQ0XumQy/wK
Xl2GexRtvMpEkpUzIc/eTw41t8vXZuf2NsEshiNdvBbYMuN2j9fRNlLDZDzS4gVf
sPIKhACEM5qfTrF74Qss
=qtS1
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
