From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 18 Mar 2015 14:27:07 +0100
Message-ID: <20150318132707.GD3580@katana>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
 <20150204190819.GA15467@roeck-us.net>
 <20150204233516.GA1677@katana>
 <20150205002630.GA396@roeck-us.net>
 <20150205144028.GA4865@katana>
 <20150205175326.GA26691@roeck-us.net>
 <20150212040126.GA1691@roeck-us.net>
 <20150216120951.GA2840@katana>
 <20150317042049.GA6765@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150317042049.GA6765@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 09:20:49PM -0700, Guenter Roeck wrote:
> On Mon, Feb 16, 2015 at 01:09:51PM +0100, Wolfram Sang wrote:
> > Hi Guenter,
> >=20
> > > I wonder where we are with thisp patch; I don't recall a reply to my =
previous
> > > e-mail.
> >=20
> > Sorry for the late reply. I needed to recover from a HDD headcrash :(
> >=20
> > > Do you need some more time to think about it ? Otherwise I'll publish=
 an
> > > out-of-tree version of the at24 driver with the patch applied on gith=
ub,
> > > for those who might need the functionality provided by this patch.
> >=20
> > Your last mail made me aware of why we were missing each other before. I
> > see your point now, but yes, still need to think about it. My plan is to
> > have a decision until the 3.21 merge window.
> >=20
> Hi Wolfram,
>=20
> any news ?

Yes :)

The main misunderstanding we had before was: You were talking about
multi-master safety between transfers, while I was thinking about
multi-master safety between messages. While we need to guarantee this
for the latter, you are right about the former, sadly. True multi-master
safety between transfers is probably like a can of worms currently.

Still, I think we have a race with your patch when having two read
processes. If b) kicks in after a) has just set the eeprom pointer, a)
will not read the data it wants. For that to prevent, we should take the
adapter_lock during those two transfers needed for the read you
implemented. My preferred solution would be to have __smbus_transfer
like we have __i2c_transfer and then using that. Some mux code could
also make use out of that. But if you are going to use
adapter->algo->smbus_xfer() directly, well, then be it.

Thanks,

   Wolfram


--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCX0rAAoJEBQN5MwUoCm2EL0P/A+67PthTSEFjft6OS/z5O3s
9cJYrbdMMaKrlPWqelPe7U4KXA8zbJD+tYFxsyAt0yA5WMz46SyxopABvhb6Q8i3
rzvxjb2TtUN1Rk5Mano98SP7fwvfQfWudyUtAmMOjxrSRmLaPUDyes+FuCSZ0ZM3
646+BlH5xhg2fKCsJfvhCw9E2WsLvfYv/4z/S53p1uxTJPmx+ig26VGNJxh9sBvX
PhjvOeFaQHkqXUXGOsKUJMJvBCt43RVrSLkSv+y/mWeukL7bJo02txoWepS4lyqC
s/JoBd2o0ovl87e3xi6brdAkK2AccMadEWnPJSMwNkrndIOMuVMVEVdw9i31IV0n
FeagK/QH7sJTpIUgjFIEpUZfVpFNbfK6DPvWhlrgpx1OV3tod/jtn7MkRjj84rJx
EWtDU25WyvyYtx/avyS0XHRN6nd7QfRA4i3jgEhXDO0nQ0zE/jIRZrYjp2epg1yN
jUJpfCTsM5jKIVLp3V6zk7Y332i1Tcu/nnjIsPK0Xx2NYuDSVjJRbC4SBP0feyKo
rpzbWf4aecIkqGNGMdpqq6Fgjk/Yh0qVpy7UKcSuVlGApVFg96n5jNQD/f0kHfw2
W+PP6lt+dLNcvULEdSg+iJ6OnR16Jgi5KPr/Osynnh0EU+AB/wCWz10S9yPrrYMr
026EoiDPvM1G8tqciyWO
=sOoE
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
