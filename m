From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] mfd: add bcm59056 pmu driver
Date: Tue, 4 Feb 2014 17:11:23 +0000
Message-ID: <20140204171123.GE22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1> <20140204143119.GA4627@beef>
 <20140204165906.GC22609@sirena.org.uk>
 <20140204170832.GA5196@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2538897853512396489=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140204170832.GA5196@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Devicetree List <devicetree@vger.kernel.org>, Christian Daudt <bcm@fixthebug.org>, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Tim Kryger <tim.kryger@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Matt Porter <mporter@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linux I2C List <linux-i2c@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--===============2538897853512396489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CQL2Jiu9fsaVZZPj"
Content-Disposition: inline


--CQL2Jiu9fsaVZZPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 05:08:32PM +0000, Lee Jones wrote:

> > What using of_match_ptr() should do is allow the compiler to figure out
> > that the table isn't used when DT is disabled and discard it without
> > ifdefs.  Not sure if that actually works yet but that's the idea.

> Right, but I'm guessing that as there is no support for platform data
> then this device(s) is going to be DT only? If that's the case perhaps
> a 'depends OF' might be in order. If that's not the case then I'm more
> than happy to leave the of_match_ptr() in.

Hey, we'll all be using ACPI soon!  :P

--CQL2Jiu9fsaVZZPj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8R84AAoJELSic+t+oim973cP/2Uc/Z3YyzkxqCeoburvzFCP
z5c6+YK4bTojchdvKgzo5NVjvlnzQE8KlFLKOsTnApPmMRc+HghsHdbOOS4lKDA0
36kdOUTb1o2vxWq2iAvaJjKASNE48N29NTo5PmgcM/Z0rwUvg12tt1fPonBzmDbL
mSV7tEyDXBN2vFa3gTNgAPISg0sAfolIhN/ZxNHj2BRA12tYTEXO8AeQ5uocw6d4
UrJ4VrFV6Wt/FiTY7lXIIsaD2SA2557g6SQOxwbOfZDLySRDUtNSI/6sYdVVQd/o
KFGwq7F2daKsEPoH3agg1gsQhZgrCMFw2G/1xVtJ7JkR+yyPoh/m2MYxG5Ewfwfi
WAiaCF/ks3IE0lO9LzIWHIltVzwUrRl04OZQL+8c1NvETw+qPbJA3PQXfoYil5WG
l5XVWLVL46eHKfsbt3FeMtNp3OFwtTlffQ0cWxv+BZr8EPLhYGM8ZKLdJoykPJil
ZISXj+y3KXDWWOKHVAL4aa/W+ULcjn1V5irw/a24W01roVDyYVrd3IZFC4polLeJ
YW9OLVZsGtx1h/RB76bXWAe7z/1Lgi27WmMruTCpZF8sWnNuaK/IXctdLm8nzwHO
7B8OsHJs4vlggEtzxqJmIeAgwIBOdN2Sg/cj9WEF7YG6i8Gz9w/MPv0HHvjFxE0O
xStEuhAGKuhsm6snSEGl
=ScuA
-----END PGP SIGNATURE-----

--CQL2Jiu9fsaVZZPj--


--===============2538897853512396489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2538897853512396489==--
