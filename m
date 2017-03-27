From: "Tan, Chin Yew" <chin.yew.tan@intel.com>
Subject: RE: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Mon, 27 Mar 2017 09:43:20 +0000
Message-ID: <1E48613D81AD0745B344B23C7C5E26B00100E44A@PGSMSX103.gar.corp.intel.com>
References: <1487051641-31927-1-git-send-email-chin.yew.tan@intel.com>
 <1487051641-31927-2-git-send-email-chin.yew.tan@intel.com>
 <20170323205825.w26jcbv6gz7wu6zg@ninjato>
 <20170323210048.c45uiolhdpgqfk5o@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1317 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752428AbdC0Jqo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Mar 2017 05:46:44 -0400
In-Reply-To: <20170323210048.c45uiolhdpgqfk5o@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Friday, March 24, 2017 5:01 AM
> To: Tan, Chin Yew <chin.yew.tan@intel.com>
> Cc: jarkko.nikula@linux.intel.com; andriy.shevchenko@linux.intel.com;
> mika.westerberg@linux.intel.com; linux-i2c@vger.kernel.org
> Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-ti=
me
> via ACPI
>=20
>=20
> > This describes why you change NULL to dev->sda_hold_time. But it
> > doesn't say why you introduce the switch-block instead of populating
> > all fields like it was done before.
Instead of loading all speed mode settings, switch block is used to load th=
e=20
required settings for selected speed mode.=20
Furthermore, using switch block re-use existing variable,
Whereas, populating all fields introduce new variables.=20

> >
> > Furthermore, since now there is no NULL case for dw_i2c_acpi_params()
> > anymore, we can remove NULL handling in that function, or?
Ok, I will remove the null handling.

>=20
> And since designware driver had a few changes meanwhile, can you base the
> next version on top of i2c/for-next?
>=20
Ok, I will base it to i2c/for-next.
