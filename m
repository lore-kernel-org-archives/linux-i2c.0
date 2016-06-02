From: "Voon, Weifeng" <weifeng.voon@intel.com>
Subject: RE: [PATCH] i2c: designware: Enable ioctl I2C_TIMEOUT
Date: Thu, 2 Jun 2016 09:11:03 +0000
Message-ID: <D6759987A7968C4889FDA6FA91D5CBC801BFEAE0@PGSMSX103.gar.corp.intel.com>
References: <1464854250-6810-1-git-send-email-weifeng.voon@intel.com>
 <20160602083330.GY26768@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6978 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbcFBJLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Jun 2016 05:11:08 -0400
In-Reply-To: <20160602083330.GY26768@pengutronix.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Tan, Jui Nee" <jui.nee.tan@intel.com>

> From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> On Thu, Jun 02, 2016 at 03:57:30PM +0800, Weifeng Voon wrote:
> > This allows applications to set the transfer timeout in 10ms
> > increments via ioctl I2C_TIMEOUT.
>=20
> 10ms is only correct with HZ=3D100. With higher values of HZ you get =
a finer
> resolution. I'd write:
>=20
> 	Respect the transfer timeout set via the I2C_TIMEOUT ioctl.
>=20

10ms is correct and regardless of HZ.=20
=46rom i2c-dev.c:
client->adapter->timeout =3D msecs_to_jiffies(arg * 10);

The purpose of putting in the resolution of 10ms is just for the ease o=
f others when
they are using this patch. I am ok to take it out if it is not necessar=
y.

> and not mention the resolution at all. After all your patch doesn't "=
enable" that
> ioctl, just makes use of the value set by it.

Yes, you are right. I am just using the value set by it. Maybe this may=
 sounds more=20
relevant:
	Set transfer timeout via ioctl I2C_TIMEOUT=20

Or any other recommendation?

>=20
> Best regards
> Uwe
>=20
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig      =
      |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
