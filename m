From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/5] i2c-piix4: Add support for multiplexed main
 adapter in SB800
Date: Fri, 22 Jan 2016 15:20:39 +0200
Message-ID: <1453468839.2521.193.camel@linux.intel.com>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
	 <1446896126-13369-5-git-send-email-fetzer.ch@gmail.com>
	 <1447065942.31665.29.camel@linux.intel.com>
	 <20160122133953.1945e36e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23752 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbcAVNUT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jan 2016 08:20:19 -0500
In-Reply-To: <20160122133953.1945e36e@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

On Fri, 2016-01-22 at 13:39 +0100, Jean Delvare wrote:
> Sorry for the late reaction, but...
>=20
> On Mon, 09 Nov 2015 12:45:42 +0200, Andy Shevchenko wrote:
> > On Sat, 2015-11-07 at 12:35 +0100, Christian Fetzer wrote:
> > (...)
> > > @@ -129,10 +133,12 @@ static const struct dmi_system_id
> > > piix4_dmi_ibm[] =3D {
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0/* SB800 globals */
> > > +DEFINE_MUTEX(piix4_mutex_sb800);
> >=20
> > Same question as for patch 3.
>=20
> Noooooo!

Calm down, it was only a question. I don't know why the author chose
the way that is in upstream.

Good you have explained this here.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
