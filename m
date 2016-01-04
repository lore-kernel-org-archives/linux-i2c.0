From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: designware: Allow build Baytrail semaphore
 support when IOSF_MBI=m
Date: Mon, 4 Jan 2016 20:51:59 +0100
Message-ID: <20160104195159.GF1522@katana>
References: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
 <1449752378.30729.89.camel@linux.intel.com>
 <5669848B.2090502@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53026 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbcADTwC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 14:52:02 -0500
Content-Disposition: inline
In-Reply-To: <5669848B.2090502@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2015 at 03:56:27PM +0200, Jarkko Nikula wrote:
> On 12/10/2015 02:59 PM, Andy Shevchenko wrote:
> >On Thu, 2015-12-10 at 13:48 +0200, Jarkko Nikula wrote:
> >>I believe i2c-designware-baytrail.c doesn't have strict dependency
> >>that
> >>Intel SoC IOSF Sideband support must be always built-in in order to
> >>be
> >>able to compile support for Intel Baytrail I2C bus sharing HW
> >>semaphore.
> >>
> >>Redefine build dependencies so that CONFIG_IOSF_MBI=y is required
> >>only
> >>when CONFIG_I2C_DESIGNWARE_PLATFORM is built-in.
> >>
> >>Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> >>---
> >>Hi David. Can you ack/nak this patch as I'm not fully familiar with
> >>this
> >>HW semaphore can there be problems when IOSF_MBI is built as a
> >>module.
> >
> >
> >>At least I'm getting similar sensible looking "punit semaphore
> >>acquired/held for x ms" debug messages when I modprobe/rmmod
> >>i2c_designware_platform independently is the CONFIG_IOSF_MBI=y or =m.
> >>---
> >>  drivers/i2c/busses/Kconfig | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> >>index 69c46fe13777..76f4d024def0 100644
> >>--- a/drivers/i2c/busses/Kconfig
> >>+++ b/drivers/i2c/busses/Kconfig
> >>@@ -490,7 +490,9 @@ config I2C_DESIGNWARE_PCI
> >>
> >>  config I2C_DESIGNWARE_BAYTRAIL
> >>  	bool "Intel Baytrail I2C semaphore support"
> >>-	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI
> >>+	depends on ACPI
> >>+	depends on (I2C_DESIGNWARE_PLATFORM=m && IOSF_MBI) || \
> >>+		   (I2C_DESIGNWARE_PLATFORM=y && IOSF_MBI=y)
> >
> >Would it be more readable in the following way
> >
> >depends on ACPI
> >depends on I2C_DESIGNWARE_PLATFORM
> >depends on IOSF_MBI if I2C_DESIGNWARE_PLATFORM=m
> >depends on IOSF_MBI=y if I2C_DESIGNWARE_PLATFORM=y
> >
> For my eyes it looks a bit more complex but I think it's matter of taste.
> However, the syntax you are proposing is not supported for "depends on" like
> it is for "select" statements.

Any news? David?


--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWis1fAAoJEBQN5MwUoCm2oAIP/2lairKzijtOq/3SZ2h6QJ9l
6n4c12ac1msxUmAned3AzqMGee1EEpLnOTGp/7lXsDmdeQBWI9kJNJfmzt8IALt/
kH6zlIjfHYToDygK4hrJoq1IJgHeSbZsuh0RKHAFVKtDtzk0CLo/6jPmeOPz1kq1
uJ5Gssd4spKvAoM3dpRBZsj7DzJvw1qWf5sx0WSEV002NMflcE4YPvB3/s87HL9O
aRahYbWUr0EU6NTZR3vNkNltl6XRmPubqPkoRSdtI57+IyQwG9jUNoALbwcCrNGg
GWQOxsacXNTnbo+bC1f8Ve7JW2lN8RE42duxIj0m1g7jEgm4tKSvstU/HPQfY5XQ
vzqTtGYv5e8gJ5CdH69q71VCo4neZ1HxiExCkEJTZwDO3O5pniDdbWsqN3yWXiQP
n4JwKjy/NjfGGCqTHdpJclGa8icJDVlpCBH4leQjPMmuD4QEWexj1c4fCzZ3aJ2U
nUyvxhVOupxdqvQBmMk0jLY8wJ0x4aFhPuEFKoVTGpDLGtoJ3sFa9sZaXtCR0HA7
YVTVrpdnPle+JHBkfZD/PndSIiz3EnSMtmF3ZntA3oFjq3/Y7caje5JRb9+UWZGu
ADgLNGbRrDSYJLeFD1emXs8S8sHOcHkmOQpWML17j/sTJ9afPELlyojnNbr7IHI8
rcn1EjJ67xLe4327CEUn
=rYJo
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
