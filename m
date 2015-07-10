From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v3 02/11] i2c: pxa: No need to set slave addr for i2c
 master mode reset
Date: Fri, 10 Jul 2015 16:56:29 +0200
Message-ID: <20150710145628.GB6594@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150710081148.GB1528@katana>
 <559FBCD3.4050402@linaro.org>
 <20150710141440.GA6594@katana>
 <559FD5DB.9030308@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <559FD5DB.9030308-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 07:55:31PM +0530, Vaibhav Hiremath wrote:
>=20
>=20
> On Friday 10 July 2015 07:44 PM, Wolfram Sang wrote:
> >On Fri, Jul 10, 2015 at 06:08:43PM +0530, Vaibhav Hiremath wrote:
> >>
> >>
> >>On Friday 10 July 2015 01:41 PM, Wolfram Sang wrote:
> >>>On Tue, Jul 07, 2015 at 12:54:46AM +0530, Vaibhav Hiremath wrote:
> >>>>Normally i2c controller works as master, so slave addr is not needed,=
 or it
> >>>>will impact some slave device (eg. ST NFC chip) i2c accesses, because=
 it has
> >>>>the same i2c address with controller.
> >>>
> >>>Just to make sure: Does it? As I read the code, slave interrupts are
> >>>enabled later only when slave mode is selected? Is that a HW bug? And =
if
> >>>so, can't the code just be moved into this #ifdef block later?
> >>>
> >>
> >>Yes we could, infact I thought about it;
> >>but I would break recommended sequence here.
> >
> >And did you set the "own slave address" to a value which one of your
> >existing i2c slaves also has (without enabling slave mode)? Did it
> >disturb communication?
> >
>=20
> Since slave and master mode are mutual exclusive,
> I did not try this.

Ehrm, what I meant was. Did you see the issue mentioned in the above
commit message? Can you reproduce it? You don't need to enable slave
mode for that, no?


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn90cAAoJEBQN5MwUoCm29mwP/jfon/xa23N6I+doMJSpliqT
7E/p9PmSYGUJGqo9kjKEgjjvsJUNfAuO1l4Uy2CHCnEfsNxR3Ovxm8aDTvzU1+Qy
iHJT1NSWvJ/ayyFnZv4ILAT+IYsg6NNpqk65pA0sRc+wjof0vAG6MSLOGeVAfdyx
/Qi40qZvxDua/RsMmmaBRuB6MDdmQBAtMyszkOhL8w9haMohdHHUf4WFYX1s4J69
oVt+o3lhA1RdcgCb7ijk1ixdWBcYPAEI26e2gVHxjRiHnRtWH32Tp4In6abq2WYQ
7HdylauUyOugHTEO2MvHvOZ543KUunHTwEvDhxeZJ6RoClEIggs9nG/T33Bjhh3d
ysFGSshGIQEriAVS9Plu6NedamIZhqyg6n0SCODtGaRT8ozptGlasCu9Q/2r4egN
sD0fgttGZVlic8mpbhDoNxBBCFbCSIWdC8ZEdpMwCnlgqfIXeRBWDJIqNvgFMfy+
LkxQZNijFtafITIvghXFM7ZA1W2fYoD30JNTzYxZIYpVOZFC/9MNGXd0wRcPIEid
a7d+tcWcnqcwotJhh1Tjb/GbcfQBv5hbsllpll023f/jVThcz+0v6SA5pdkL090q
h8sxwhP1tI0gRgWgwnpiFJvCX9hlZ0/KrKABsagtSbFaeqxMP60jrJjkKjGLuXmq
b330GH8Pe0YBzhd//nVe
=d8H5
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
