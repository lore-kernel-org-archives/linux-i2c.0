From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/3] i2c: core/designware: Find bus speed from ACPI
Date: Mon, 06 Jun 2016 16:24:09 +0300
Message-ID: <1465219449.1767.103.camel@linux.intel.com>
References: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64124 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbcFFNWz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 6 Jun 2016 09:22:55 -0400
In-Reply-To: <1465212383-24639-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Weifeng Voon <weifeng.voon@intel.com>

On Mon, 2016-06-06 at 14:26 +0300, Jarkko Nikula wrote:
> These patches add support to i2c-core for finding the bus speed from
> ACPI by looking at slowest connection from ACPI I2cSerialBus resource=
s
> that are associated to I2C controller and use it in i2c-designware.
>=20
> i2c-core patches apply on top of v4.7-rc1 and i2c-designware change i=
s
> on top of Weifeng's fast mode + and high speed set:
>=20
> http://www.spinics.net/lists/linux-i2c/msg24699.html

Looks good to me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>=20
> Jarkko Nikula (3):
> =C2=A0 i2c: core: Cleanup I2C ACPI namespace
> =C2=A0 i2c: core: Add function for finding the bus speed from ACPI
> =C2=A0 i2c: designware: Find bus speed from ACPI
>=20
> =C2=A0drivers/i2c/busses/i2c-designware-platdrv.c |=C2=A0=C2=A0=C2=A0=
6 +-
> =C2=A0drivers/i2c/i2c-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0| 116
> +++++++++++++++++++---------
> =C2=A0include/linux/i2c.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A09 +++
> =C2=A03 files changed, 94 insertions(+), 37 deletions(-)
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
