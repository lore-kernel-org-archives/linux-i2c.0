From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] eeprom: at24: Add OF device ID table
Date: Thu, 16 Mar 2017 16:05:49 +0100
Message-ID: <20170316150549.GA3988@katana>
References: <20170314151638.23132-1-javier@osg.samsung.com>
 <20170314151638.23132-5-javier@osg.samsung.com>
 <CAHp75Vf5=E37Ccrc2zMo8xOWmA-A_FZL7d57q7Rxk07M-V5mhg@mail.gmail.com>
 <8e233f15-4f91-b495-5270-5a7f982b31be@osg.samsung.com>
 <20170315075835.GA1438@katana>
 <ed3caa80-2b73-752e-a13f-aa5d348abd18@osg.samsung.com>
 <20170316130714.n42zkjdei7pm7vgw@ninjato>
 <5da325d0-59d4-92e8-350f-43c25310dabb@osg.samsung.com>
 <20170316133645.3nlr75gjhx7io7mv@ninjato>
 <b4e993ce-4630-6d89-077b-e2f18fadef02@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b4e993ce-4630-6d89-077b-e2f18fadef02@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Rob into the boat if he is OK with updating all DTS files having such an
> > EEPROM.
> >
>=20
> Agreed, are you going to take care of that?

Nope, sorry, no bandwidth. You might ask Lee, he was very interested in
getting proper I2C OF support upstream.

> up on this task, it has been a big time sink and I had to explain over an=
d over
> to different people what the problem is with the I2C modalias uevent repo=
rting.

Next time, maybe do a wiki page and point people to it? That being said,
we should probably create a wiki page on the I2C wiki anyhow.
Documenting the current state of affairs. That I would do when I finally
get around to brush up I2C wiki.

> But it seems that for many maintainers this is just an unnecessary churn =
and they
> don't think there's an issue with the current behaviour. So it feels I'm =
causing
> more harm than good by keep pushing this.

I understand somehow. They probably were reluctant to change something
that is working, even if it is not pretty. I'm not saying it's not worth
it, yet one needs energy and motivation to push it through.


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYyqnNAAoJEBQN5MwUoCm2YA8P/3/eTN8TcKLkGFDupNMQY+sR
yMH9bemjlAUHgaGd2J6E8zyO6Ad+UPDhOGj6pVSwhKqbpH+MM72xLKl4FiK34ee6
H7e8BgAe2WdSRxO3W98hqw8z/za304KJPJc4Xymu75Mnc9REXro3yY15VnUx1VUB
QbBINJStbu/VcA/I0bRhBzCrWbcUHHRflyUjGiSMJX/zOvypjANzQEecLm6MwxIV
S/y8lzMFCop9bb627wQMY1oNEG3Jq90QrwMdsd0mm9J4xHdmFlWMtgwzlVcKZOqa
2gK+KN9AcRkusM60pWrj7qcKdnktF8wQy9At7DpstYZLOW+VHx/DwG3Fk8P5M7cn
76EOVHaYF3K6QE2Eg7R5LRRtI+zffLh6/dF7ObAU1K0SFGNQD8vhNPJ/iGQ9r7i3
kim3oqwjIXB3HW7Syc0ojD5eSXkoHqfCj7ZWXG72iozNJbzUs1ogj0HBU9mBB2LU
xecjctfZk75o3sugdkSXJLQuPSW/KUw6VyHO0/7WUeirpnZwMhM8iIVCb+WmmfDT
pAlYOKmBER7eslFMT0Zc+2GzjfAlO252GZ1Tf0OmjRRh7Si8KD27mV4kubnQwZ1M
IzUkTjlHnlSfqXFdXGOyNvi1Ad5UJQ1s7nzauK/sxjcuqhzg7BajJKBMeVf4vfVr
UTrT5zPuB9gprk2QxrJX
=zoij
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
