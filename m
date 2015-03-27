From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Fri, 27 Mar 2015 16:27:28 +0100
Message-ID: <20150327152727.GA27238@katana>
References: <20150318132707.GD3580@katana>
 <550A4162.8000009@roeck-us.net>
 <20150319081612.GA900@katana>
 <20150319174314.GA17329@roeck-us.net>
 <20150319213937.GA899@katana>
 <5512C213.7030705@roeck-us.net>
 <20150327080947.GA900@katana>
 <5515523F.9010609@roeck-us.net>
 <20150327130108.GA19151@katana>
 <551557B4.5000504@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <551557B4.5000504@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 06:14:28AM -0700, Guenter Roeck wrote:
> On 03/27/2015 06:01 AM, Wolfram Sang wrote:
> >On Fri, Mar 27, 2015 at 05:51:11AM -0700, Guenter Roeck wrote:
> >>On 03/27/2015 01:09 AM, Wolfram Sang wrote:
> >>>
> >>>>just to give you an update: I do have some code, but it is a bit mess=
y,
> >>>>and it doesn't work well for ds2482 (the chip behind it still hangs up
> >>>>if I access it in parallel through i2c-dev). On top of that, it causes
> >>>>pretty significant slow-downs when accessing other devices on the same
> >>>>bus at the same time. Not surprising, I guess, since it expands the s=
cope
> >>>>of the bus lock significantly.
> >>>
> >>>Just to get a better idea: Did you try taking the adapter_lock before
> >>>the two SMBus command which needed to be concatenated (and use
> >>>smbus_xfer directly)?
> >>>
> >>I did. I didn't use smbus_xfer directly, though, but introduced lockless
> >>versions of the various smbus commands, and kept using those.
> >
> >And then the chip still hangs? Or was that the performance penalty here?
> >
> Parallel access to a second eeprom chip on the same bus was much slower
> than before.

Interesting. I wonder what is the reason, I would have expected just a
small delay. Would you mind sending the patches for the non-locked smbus
routines? Would be nice to have that around in case I or someone else
find some time to try as well.

> Also, the new code did not solve the problem for ds2482 (completely unrel=
ated
> to the at24 driver of course). Even with proper locking, the chip ended up
> hanging after some parallel accesses through i2c-dev. Granted, ds2482 is
> a difficult beast, but it is still annoying how access through i2c-dev
> can mess it up.

I assume you basically replaced the access_lock with the adapter_lock
with this one?

>=20
> The latter is what bothered me more: What is the point of all this if we
> still can not ensure correct operation ?

Yeah, this is not good at all.

How do you use i2c-dev BTW? i2c_rdwr_msgs? What about iterating over all
msgs in that and check for busy addresses?

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFXbfAAoJEBQN5MwUoCm2yHsP/RbnlGOfSoWzdk6tUN8uUN2H
1abKglp0+2hcXamcVyNfcFgslAHY97dn+ZmrppRyWBiCoXoWn6lLjXMLGjbADZqH
GLN1uLTguUZ2h1tR85c4buECIWcdGozC/TDF9t5jPdMEVCPyzjzTXAqUL1OqAeq5
APwpipxKT8NSuSpvMwBCNUYtjGw8UnjfQdJGOhxcKnSBi9yDz4EKgqCtsFokIaW7
K4iL+PfDDiNT7GyZER2gaeX2O+yI0v3QMG6kiFfC3WS7KC+IxUnj87RLEQTtO0eL
odTSyX9iFVKwHRUKL/Pa3PEYrUEqSIUYKjEX3Ip6pI1ZEwptzZaetwzhanKmjzH6
nEtGrswNO/1Fume65Qz/o4hE2H3DmBY60/eWoIw7TDraikqSnYbkEkGMRHbQFAUL
UC5DUOS38cy9iyAPIaX4CMgX6GJBcsd+Y+f+cQF8z+nA3dGE/dFe5M5HN33pL2uR
lJ6Md3XQxJcHPp+RZdaFXF64Q1Ad5v3B335k9xPkN0uvYT4dkrtx8p7n6grgaCdx
7BoaeTStPCgzorSttDJqGI1PrWLcdhsUcVLVpHSjZp7eKNGSZamAqBHxmfrobX5P
LSe3fs4ZROaqgQL2TNR4k1bXgu9y65tJFXi6L8yOwzrCfqZEoHsUk0x6UqE2nOrD
UJUw6gTwiaTxeZpzwuEx
=4GV0
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
