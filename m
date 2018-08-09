From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
Date: Thu, 9 Aug 2018 12:00:43 +0200
Message-ID: <20180809100043.2twv3qma22ptkddq@katana>
References: <20180809091558.4317-1-hdegoede@redhat.com>
 <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mq743r4htrqmczbp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--mq743r4htrqmczbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As for the rest of the series I'll wait from comments from Wolfram and
> the other reviewers.

Well, I acked patch 4 now because I like the general approach. I can't
say much about the rest since this is mostly ACPI/FW related.

Thanks Hans, for keeping at it.


--mq743r4htrqmczbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltsEMoACgkQFA3kzBSg
KbZODg/7BfBqQDftu3X3jlS1Tp8Te05gl1KEVu60oaLRzmn2Gnlr2xTlMKO21L2R
W4Pze2A5p2/YlCMco2Xcfdc/UqV0hFxVkJTn0LkTxcub2akTwjt6jWmtO78iNmv1
eIbG6DY+3fwdogXhtgkqitgNvz37hoBYZN5CFlbHHXJDcdwb80hAf3BkyYSqNHc5
EBT54KKe8b/vVWuzC9eyvncwizbZBy/7jSVoEWwDqnSgj6azxeeYqELBBB5jhzsA
+SYKTtM3kMdKcJoI9X+60vgIua9LSFbsF0jimphF5n5pRd3uptIp5uZN9OQuDtXL
+DvBDr8vFGdgAL+7Niscrc/ATPwItpJhOEmQVkGJ4xMlMVZQArY/tCvvm7h97tuw
p284Lid71WmRnSnem+upzAfy646ZBGozBarijoN9vjqVGjAu/YUNIeT4ZQdQ1C3z
Q+2105Tl6OffuZK+m6yM6w2/sFmTQRzxY0pR/zwcA2fKBYXayMl8QCZIUTpk2d07
rBw4NUTInoRQTy7oVXUUgkwtnWVm0BnfuSWRaUVRHektJ4Y5KmKsR1nBCwL24jyt
9WAiyfu/nncBMQIGrFMeMp8+yfD9WCwJSyX5h0yZTmPNzOQLWEZs2BuQNkEGSuzQ
KdVTrQGdnMEuSgx6Nxs+8hDR5ZK31CVprtK/R52XEv9GVkTOC8M=
=UUWI
-----END PGP SIGNATURE-----

--mq743r4htrqmczbp--
