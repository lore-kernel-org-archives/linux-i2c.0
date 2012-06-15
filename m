From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
Date: Fri, 15 Jun 2012 10:32:32 +0100
Message-ID: <20120615093231.GB3898@opensource.wolfsonmicro.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD6F0E8.5040606@linaro.org>
 <CACRpkdYxiT-0x4aetMxB2x8SkB+Mmy8rk8uSzgU_anemSayhMw@mail.gmail.com>
 <4FD83AAD.2010701@linaro.org>
 <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw@mail.gmail.com>
 <4FD88761.9050703@linaro.org>
 <20120614183636.GB30185@sirena.org.uk>
 <4FDA341C.8010501@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FDA341C.8010501-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2012 at 07:57:32PM +0100, Lee Jones wrote:
> On 14/06/12 19:36, Mark Brown wrote:

> >You're not understanding Linus' point.  The compatible string isn't
> >useful here because properties like the maximum clock rate of the bus
> >depend on the board design, not the silicon.  The controller may be
> >perfectly happy to run at a given rate but other devices on the bus or
> >the electrical engineering of the PCB itself may restrict this further.

> And you're not understanding mine. ;)

I think we are (or at least I do)...

> You can have multiple compatible strings for a single driver. Which
> one you reference from the Device Tree will dictate which group of
> settings are used, including variation of clock rates.

I'm certainly well aware of that.  The problem is that the compatible
strings should identify a particular IP or piece of silicon and be
unchanging properties of that hardware - for example, working out how
big a FIFO in a device is from the compatible information is totally
sensible and reasonable.  Things like the I2C bus clock speed on the
other hand depend not on the individual device but on how it's been
integrated into the system so you'd end up saying things like
"nomadik-i2c-100khz-bus" in the compatible string which isn't great. =20

If there's something like variation in the maximum speed that can be
supported by the different silicon the driver handles then working that
out from compatible and using it as the default is sensible but that's
not the same thing as providing customisation of the system bus
frequency to the user and if there's only one of those two that's
configurable it should be the system bus frequency.

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2v++AAoJEBus8iNuMP3dQ38P/iw7ozGv7O+9QsaPbqtNx3b2
i8HIfKoBL7a+O/isyBEJq/07+9+zUy0HvsLd/6GBupgY7LVG9tuMeeA6sg8+Vfpl
iX2J2L4mPJQPY/jQZn+tYlc9uy/M2lhssVItOzlSMl32j0sViKgwQj2aSW9bk4RA
jf80bmggzz3/oewHuhbVQff5zb0Wt7e67N5nrnTzBfGOnin3JCRLLkxsqa5vWVgG
cIFvQncVX3+C8NygUKUI7qizBy3YlTQs4307qeqA2vworgahpHiD/VAQmo74C6oW
/SuKq135aexotrdUQ3Ii7UbPO4uslTRdbAVQNuN1WMiSbiC/Xx5EDCPgTFbe6OqH
6KjgskFWh77Bc/vVplkNaTSRzfNiuTYlxTr2+8+KuuushnHXk0pPmjXY1TPKOlUT
TpNrHwC823vivfe9j4Jbi5E6Lrkc887CEtd/THVPT72pTVK8E51a09v6OiN1nPwD
EfsCW6W7ID7srZEg+IC52LYZX8P++wnpkoVvuqSopKszqOHm2SwjMNMxFlJY1hdM
MWknQQ5gqJIWHpQA1nqSAv9PTrP8Uw5vY7G316ioLrkOWrLtAMT2m2K/qb30toRq
tDKstmJJDS1ntbrmU3D5U2cn1UwmWqRLxjYDQSVCraQYiQtKxW6B2ofqpUvsNIR/
FPVhJQzJDYZi32IgIByY
=U0/B
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
