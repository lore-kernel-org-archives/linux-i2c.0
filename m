From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
Date: Tue, 7 Aug 2018 13:27:02 +0200
Message-ID: <20180807112701.5iukqa6m5atf22fw@ninjato>
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rjsufeh33ovopkb5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180807080539.17811-5-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rjsufeh33ovopkb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

> +I2C MULTI INSTANTIATE DRIVER
> +M:	Hans de Goede <hdegoede@redhat.com>
> +L:	linux-i2c@vger.kernel.org

Since this driver is about FW bugs, I wonder if
platform-driver-x86@vger.kernel.org isn't the better list here?

> +S:	Maintained
> +F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c

I2C parts of the rest looks good from a glimpse...


--rjsufeh33ovopkb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltpggIACgkQFA3kzBSg
Kba4jRAAon1GKq0XmtS0zG9XMo/h248W2ggHZqJyoYs0MskEWYOdp6hq7nAiez8e
p5BfOL6gahXCLg7inoputCpes+XDQ7TiWuChUDxgbcSH4WnTnSVI5kk28QTrOfPd
jebCKyHlcXecWWizRGPTydpHl1UuwWLUeogICpgjuTeqP0g38ahbPqhSa8lvUnzl
xnV9o/YWb7Z0gZy/HZWZhCTNfXqbUfaseK5x62bCYnxHXgjyZ/rwM2Gg4rPYMb6k
bk/agC6CWhU3CWpZ7Ja298sE2GSlzFRhE/Zc1VjpMEZWbAhyQqwxeQuliLY2EI0z
xl4FsFQ4uwGDdqk6Qm1SwnkhHWnhys4fo52B+o+8DkQs1Q24Rc6omLK42ctIA+7L
nyQuRQwDivpGOlg+jo5acpuN9XOsJd7TWZKuwuAU/CPEwwYPBIkm8S3JGAiEsBG0
aSha9nSWg+Uvkz5a+aCQ90rionXeQsOZ/ygovNZeymhu1TlnL27qSf3td2Zl+FvG
IBxJSoiGGJkiKl3CAKnRhFVUw5Cipixyts8LUHf9I5G6MBb5mi+RaNg3m99bxC4p
ZSGuhxWmCHrljxjBWep+ImlLR8LAJhMqrOivgF7H14bgq6qsbFH5q8VB+D+X4s4L
rT7pk507DF1MFWiJfZK6ltVL5/1uvwIIENTMTtUKjeKmQC/41Xw=
=W7HD
-----END PGP SIGNATURE-----

--rjsufeh33ovopkb5--
