From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Tue, 8 May 2012 14:34:12 +0100
Message-ID: <20120508133411.GP15893@opensource.wolfsonmicro.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
 <20120507170832.GO17002@opensource.wolfsonmicro.com>
 <4FA90BE1.3050304@linaro.org>
 <20120508121940.GL15893@opensource.wolfsonmicro.com>
 <4FA913BA.30908@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B9BE8dkJ1pIKavwa"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FA913BA.30908-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--B9BE8dkJ1pIKavwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2012 at 01:38:18PM +0100, Lee Jones wrote:
> On 08/05/12 13:19, Mark Brown wrote:

> >It's been kicking around for review for a little while longer than that
> >(it was waiting for review while Rhyland was on holiday), and in any
> >case half the reason for adding infrastructure is to avoid adding
> >repeated code.

> I'm sorry Mark, but I just don't have the time to read all of the
> mailing lists in order to keep up with, and in-turn use all of the
> new features which might make it upstream. I only use what I see in
> the kernel at time of writing, as I have an entire platform to
> enable and very little time in which to do it.

If you're going to do this you really need to track -next rather than
-rc for actively developed subsystems - it's not just that you're not
using the latest APIs here you're submitting code that won't even
compile against the current subsystem.

> This piece of code plucks pre-defined initialisation values and from
> the Device Tree and uses them to set-up regulator related registers
> on the u8500. See 'struct ab8500_regulator_reg_init
> ab8500_regulator_reg_init' in
> arch/arm/mach-ux500/board-mop500-regulators.c for reference.

Oh, dear.  It's quite hard to associate this with the code especially
not without the binding document. =20

Looking at the usage here it looks like most of this stuff shouldn't be
there even with non-DT stuff, we probably don't want to add DT bindings
for those bits.  All the voltage setting is not at all device specific
and can be done using the generic regulator bindings, the forcing on or
off is similarly generic.  There looks to be a large chunk of mode
setting too.  We probably need to scrub the existing magic number stuff
prior to trying to do this.

While looking for the original patch I also noticed that you're not CCing
the mailing list either...  please always CC the subsystem mailing list
on patches.

--B9BE8dkJ1pIKavwa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqSDDAAoJEBus8iNuMP3dSSgP/iDDC8uJgjA1BCk7oFb1dNPZ
nMxuHz+0q+d6h445igHTTRqIWDW38jsfuQM9HSKjQxAVclZkxrPqXNccH1L6WzFg
K6iGttgIyhG7t8cA29aqLoPgLd6+7JZ5camSSF8kHik6dopRp3kdS7Db+xonGw36
pStXZveQYaui5/5U2u+aY1dyp+O6VL7GzjHHois7F7NZtQsREVRZlXHtlPigHCRj
R8Eaux/pXou7n2vBJP+tyYSLfveANl/x7qKXAeXthvtEiNVUrc5wUimNlSTLWBtt
1yu0CirTIeRvcmoVSAkC0k/4+BX4Cnk3kjAVTS3iyzoCw87B3FY0lSmzLitpaPy5
x8al2PQ/J1IRK68cKFJOu+QjvGtuGG3BYcEJryUiZ2Oke/lEi/WJAugr9MgMt9Mo
91VePDArihxb5rhJWOVwLTFPcKDt9ZKZFlu1geF6LcGRfFTm7ordEEiMeyZ7RN4f
Cb4HAvC+Y+xGRmrPdmZms5cqh13MLKt1DBYFYWvFMPxNpElKNURZVOQKccweC3WH
DIxBIE6tPRBNKzyE53kxNdr3TGqSKiw5nqc8HL3c22Z05oC/av88cSgGBn12Xc6X
pLoHmTrHI2gFXxk1g9NTcjEu3GrOMdffFnkeUtF9PC6pAmp5h2pC30i455J4X4m9
jzhmSnsW2Y1Bs0El+dJA
=SEsc
-----END PGP SIGNATURE-----

--B9BE8dkJ1pIKavwa--
