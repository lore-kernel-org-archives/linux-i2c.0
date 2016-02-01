From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c/designware: enable i2c controller to
 suspend/resume asynchronously
Date: Mon, 1 Feb 2016 16:54:22 +0100
Message-ID: <20160201155422.GC10607@tetsubishi>
References: <569893D1.5050403@linux.intel.com>
 <56AF73E1.7080501@linux.intel.com>
 <1454339763.32507.26.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44758 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbcBAPy0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Feb 2016 10:54:26 -0500
Content-Disposition: inline
In-Reply-To: <1454339763.32507.26.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > > device may be completed in separate kernel thread. PM core ensures
> > > all power state transition dependency between devices. This patch

I'd like an Ack on that from a PM maintainer, because I think chips like
PMICs are special and might not be covered by the generic case...

> Besides that we have to be really aware about DMA power related fix
> introduced in v4.5-rc1 in acpi_lpss.c [1]. So, I would like to see a
> wide testing especially on Intel Baytrail / Braswell platforms before
> enabling it.

And this one, too.


--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWr3+uAAoJEBQN5MwUoCm2fa0P/jEODTIy2iv8lH0cifhgIk6h
JTQ9BlCP2PtfeCwfwIO1d3SWdMECghj1GTyNoAWjgKtfhuCQhDdTljHQUURcDtsN
rbIcc0Uh/cYVKMN12vWsK5GR2MeLs9UTSWDcUTkNVeyS/4ZoZcdHlJdllM8bZyut
qnvqa1LtEwe1F3tkeEdq+lhGvMOVu7khjL5hH7Hb0duhriTbP3ZzibzGW/cxvB6f
XBv/B8D/hdh1YDAjAvOL1xNwVXyqSx2+T97CeMisbj17XYhAsX/CTyl4sKBNUKKa
5o/sSknGB/MYUfrklCXoWcrLL01yPTlGdY/TLGA46OSYjiZi+/onO88GuRp5SPIA
fWuiECsWqOozmnijzMXYnOwrYm9SNnSiZx+rrItqlhaVvSBkw2seEzZOcGJyUc3R
dmqeBKFiKCsy5qQwCp3HJeiKLXZu3wehlGljV1UOgqbd8SEz21gRDxVjUQ0NY2aT
A5L8xY2jZr7TqYIvld8wX9Lv5qFCpR9+zx6rOC8t8+M9oQEIZQQqWfhG76KGdH1Q
dyRl4aCmDryA++15vHx2I9bZRDIDT/TTcsx2gXs+aPHaJYWdkAZ/Liz9gap97POh
TyprIzVT08c52+tLCMQNZ9Yvwr5dsSH8EBj3Jc7CKnFNMx6TafRgbZj8jF8WFoXV
HE/Bly+kwfb2qRG2JTxH
=rRmw
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
