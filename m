From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3 4/5] i2c-piix4: Add support for multiplexed main
 adapter in SB800
Date: Fri, 22 Jan 2016 13:39:53 +0100
Message-ID: <20160122133953.1945e36e@endymion.delvare>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
	<1446896126-13369-5-git-send-email-fetzer.ch@gmail.com>
	<1447065942.31665.29.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43794 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbcAVMj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Jan 2016 07:39:56 -0500
In-Reply-To: <1447065942.31665.29.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

Sorry for the late reaction, but...

On Mon, 09 Nov 2015 12:45:42 +0200, Andy Shevchenko wrote:
> On Sat, 2015-11-07 at 12:35 +0100, Christian Fetzer wrote:
> (...)
> > @@ -129,10 +133,12 @@ static const struct dmi_system_id
> > piix4_dmi_ibm[] =3D {
> > =C2=A0};
> > =C2=A0
> > =C2=A0/* SB800 globals */
> > +DEFINE_MUTEX(piix4_mutex_sb800);
>=20
> Same question as for patch 3.

Noooooo!

The mutex is needed to ensure that only one of the 4 multiplexed SMBus
ports is used at any given time. i2c_piix4_adapdata is per i2c_adapter,
so if you move the mutex there you get one mutex per SMBus port, which
completely voids the point of having a mutex. A per-port mutex doesn't
protect anything, all it does is serialize the access to THAT port, but
i2c-core already takes care of this (thankfully.)

So moving this mutex to i2c_piix4_adapdata introduced a serious bug in
the driver, which needs to be fixed ASAP.

--=20
Jean Delvare
SUSE L3 Support
