From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 2/5] i2c-designware-baytrail: fix typo in error path
Date: Wed, 11 Feb 2015 17:46:11 +0100
Message-ID: <20150211164611.GA2712@katana>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1423587970-19136-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423587970-19136-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +				PUNIT_SEMAPHORE, &sem);
> +	if (ret)
>  		dev_err(dev->dev, "iosf failed to read punit semaphore\n");
>  	else
>  		dev_err(dev->dev, "PUNIT SEM: %d\n", sem);

Shouldn't the latter be a dev_dbg?


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU24dTAAoJEBQN5MwUoCm2LaMP/Ro9AO+ER2v1sPnaSjE4WmE9
XX/xaqjXaKuivAB2p/uK+ctGkX+DOiTkCm9e9eP3ZMDntDnCACNF2bGrkLDZOh/c
zwSp+0ahgXE1DbAcTnE2amEW9xRLVApVhUkrQIO3msdwJuhx3yoCkADf1Vm5ILHO
16qI8TRegm98z905jkxTngEUsT9zwG0jpPcMY+5LQ9N+lUisWTqFW5tBdu8DkB5f
2qrlnGe0URLqnD4UgLl00p4630F80ITKIoYwWHY57iRNt4kwC6JBdF4ZxUdMxGcg
B1wwSi2EsXn5rYNlVTOooQrw3VvuQbIHANL7zHxq8WcfYfmETAk3NH5+WiEAFnUb
xZ83gMMyUkL+4ze/+CJ641hz/X4PQzUJQd8FMLxxBpv5ip4J58mPi7j+e3ibxyKS
1veuGbLRk3vV6t0QDYkzVxkwF6aMhik6VVL/7EdSz7yvT93OrwikPtp+HJm53jDX
RoSDxB+sbJIbbdPr8ZK4xjzHh4CEJb2lLLU5s980yCrhSeajHyzRstFeONz5NDQ5
ZcLPNPs31hbNQG1aJNIy42F40TXsUTQaQxyxAo5/wYKSjFKOEMKdxzy1gmOzuPmw
XaP1Rd6cQpKS/JSwvzE16tzSwgR33ErBTdQ0yfpMlNtgYhBdLyMH5yn+CI23d7xT
NBhy/Diq/Uiueb0PyWT4
=o5Q/
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
