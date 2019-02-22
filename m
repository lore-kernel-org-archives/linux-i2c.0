From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client
 device.
Date: Fri, 22 Feb 2019 12:31:59 +0100
Message-ID: <20190222113159.GB1771@kunai>
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
 <20190221232609.d4vxl3osj6mwooey@katana>
 <CAO-hwJ+4-sxwbdpzjTKyZ10SBv743JUF0sTFPJ4YRXURuR_CNQ@mail.gmail.com>
 <20190222102335.GA1771@kunai>
 <20190222103019.GD130153@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222103019.GD130153@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jim Broadus <jbroadus@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > But I still have the feeling that the problem is not solved at the
> > > right place. In i2c_new_device() we are storing parts of the fields of
> > > struct i2c_board_info, and when resetting the irq we are losing
> > > information. This patch solves that, but I wonder if the IRQ should
> > > not be 'simply' set in i2c_device_probe(). This means we also need to
> > > store the .resources of info, but I have a feeling this will be less
> > > error prone in the future.
> > >=20
> > > But this is just my guts telling me something is not right. I would
> > > perfectly understand if we want to get this merged ASAP.
> > >=20
> > > So given that the code is correct, this is my:
> > > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >=20
> > > But at least I have expressed my feelings :)
> >=20
> > Which I can relate to very much. I see the code solves the issue but my
> > feeling is that we are patching around something which should be handled
> > differently in general.
> >=20
> > Is somebody willing to research this further?
> >=20
> > Thanks for your input.
> >=20
>=20
> I would be willing to have more of a look at it but am slightly
> nervous I am not right person as all the systems I currently work
> with are DT based so don't really exemplify the issue at all.

Thank you! Well, I'll be there, too. Discussing, reviewing, testing. And
if we have Benjamin for that on board as well, then I think we have a
good start for that task :) Others are more than welcome to join, too,
of course.


--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxv3asACgkQFA3kzBSg
Kbatew/+I8Kal9hvYRAu3wYJbW7Fpxjvnz7kloIiOb9wCli1oKEgOXy2ahg59Fq4
Cht2UljMlNDRzOhvmCiQsrb37ZfVRtXj9opXSJP/IRFFz11x5cUEl9y4nUf8EzIR
LaCE9WcHRfq0S/RjwxAekEM4fWlwSiYlrw0n6tEZ63rPZkqHtNZ6b/Q0bZBzd6pC
bion7WcG7pKJ3uOwEvfytZ1ouFr0NZbTKLs3ncxPy+kbTW9nqwFG6cmf9fZAErcv
d8CT/1Z3z22OHJpJ3/ys99Tv7obvtcmFDspZeNKtH+QFXQ+YqfSc5S5+UlgNZ/iu
/v3t5acY+QwnKmc8rc4C83htiVIGc8g91VR+tM4i+2nOiZ4CZPyOE0u7XuQwSd8c
TxFB7PRqBLMAYJ+rUzcMqCYndatDEN3JCr12OPgK8hzTo7rh+YS2Nh803CQV2nHO
AxjIi47sHIelMkHrQnXt300CPMe3A4AiJGbxKGaD0YNPXgJtvIRl+23JhJJlBiuW
42tjdALn3gG+iLmVSi1fbVn63vkA5jHa6wA/wChL4Nx0elnvle4a6WfcwTarbZJa
wCqKWpVUFh5iPiuK1cr7/TbtzzNSn34//cxgmUyisty2JDWvIhT0c9wREAC1UqW4
3NULn8vAgNhncb+VZcQCmQHZF/iKIo8CzMOXrqrof1YEaUsdJYo=
=3CRi
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
