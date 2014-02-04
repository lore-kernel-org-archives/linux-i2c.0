From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] mfd: add bcm59056 pmu driver
Date: Tue, 4 Feb 2014 16:59:06 +0000
Message-ID: <20140204165906.GC22609@sirena.org.uk>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1>
 <20140204143119.GA4627@beef>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOm/PSfQoTjkIR/P"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140204143119.GA4627@beef>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XOm/PSfQoTjkIR/P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 09:31:19AM -0500, Matt Porter wrote:
> On Tue, Feb 04, 2014 at 01:29:51PM +0000, Lee Jones wrote:

> > > +static struct i2c_driver bcm59056_i2c_driver = {
> > > +	.driver = {
> > > +		   .name = "bcm59056",
> > > +		   .owner = THIS_MODULE,
> > > +		   .of_match_table = of_match_ptr(bcm59056_of_match),

> > No need to use of_match_ptr() here.

> Will remove.

What using of_match_ptr() should do is allow the compiler to figure out
that the table isn't used when DT is disabled and discard it without
ifdefs.  Not sure if that actually works yet but that's the idea.

--XOm/PSfQoTjkIR/P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8RxWAAoJELSic+t+oim94AgQAJv8M2BLpfEouIDGeCFeqsXl
TVdBev9aPbChqd+9ujjyPjmSfmLMrVGCNtiIoHv1TnGOSzrdm1Ffj8kQM9d/dgP9
RLxC16kcL/HtjTtLy5BAmGoqItnu/kN+6hpQ4b7xYRvRzIFxDvHo+RSo+NsbAC6S
e11FnZVuA/wzYGTbM9dLfTaeWbkfqKenvoTH3TDJXBzvdBaOMwvnSwLVroq2zrMv
o0lDqaIU4liyO2Tx7KtxLIkrtpJ6TJI6YwIwq987fEGw91AnjVty+k3canRtdYSG
Q70iSCyWcW8E9f0XOznnHFF7Bu7+vwdAI1Ta7yFVlQklfYszbs7RPLnBeWMTXlwt
p/HiAuJz7UWvPH4T8vo1U2NX0+1+72JAf58KK6d2FNa+6/2/JLM9avCXv88duEgG
/g4LZNxv82IBR/vcR1i7tJACuFlEcLZLSJcd8SqWY+cPQ5/jQfKYDM1LN9zJJmPO
FtLDxKe4qlE5AkIB8D0KNSHoTJqgm29UnWrV+awgfqunUXLChwFVUMDsn4VfWI0y
KRUJkmZkPdapDgTZoiG9IPeNegteXJMF18YYNUNBww6QzVXzOUV9UMO7M162vuYn
7uLYaYScdh5TgRpNBn8h+jb18RnBLv17lSwm/TsobBDMOznpaBCWFRRe//9fu3rT
18LVdyQdcCkV+NByZ1Fk
=z1QW
-----END PGP SIGNATURE-----

--XOm/PSfQoTjkIR/P--
