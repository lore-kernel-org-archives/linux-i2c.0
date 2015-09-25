From: Jean Delvare <jdelvare@suse.de>
Subject: Re: randconfig build error with next-20150812, in
 drivers/i2c/busses/i2c-i801.c
Date: Fri, 25 Sep 2015 16:06:04 +0200
Message-ID: <1443189964.4919.5.camel@chaos.site>
References: <CA+r1ZhjyBKcWbNB3hkPxoEKatojYk9=VPqSurZHPk9nfNp_gSQ@mail.gmail.com>
	 <20150925093610.64ed7f59@endymion.delvare>
	 <20150925133757.GA2857@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756355AbbIYOGH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 25 Sep 2015 10:06:07 -0400
In-Reply-To: <20150925133757.GA2857@codeblueprint.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Guenter Roeck <linux@roeck-us.net>

Le Friday 25 September 2015 =C3=A0 14:37 +0100, Matt Fleming a =C3=A9cr=
it :
> On Fri, 25 Sep, at 09:36:10AM, Jean Delvare wrote:
> > On Wed, 12 Aug 2015 08:42:18 -0700, Jim Davis wrote:
> > > Building with the attached random configuration file,
> > >=20
> > > drivers/built-in.o: In function `dmi_check_onboard_devices':
> > > i2c-i801.c:(.text+0x126b36): undefined reference to `i2c_new_devi=
ce'
> > > drivers/built-in.o: In function `i801_remove':
> > > i2c-i801.c:(.text+0x126b86): undefined reference to `i2c_del_adap=
ter'
> > > drivers/built-in.o: In function `i801_probe':
> > > i2c-i801.c:(.text+0x127d08): undefined reference to `i2c_add_adap=
ter'
> > > i2c-i801.c:(.text+0x127d6e): undefined reference to `i2c_new_devi=
ce'
> >=20
> > Sorry for the late reply. The error is caused by the following
> > combination of options:
> >=20
> > CONFIG_I2C=3Dm
> > CONFIG_I2C_I801=3Dy
> >=20
> > I can reproduce it even with mainline now. This is caused by
> > CONFIG_ITCO_WDT=3Dy, which selects CONFIG_I2C_I801=3Dy without sele=
cting
> > its dependencies (CONFIG_I2C.)
> >=20
> > Thanks for reporting, I'll post a fix shortly.
>=20
> Sorry that you got caught up in this build error Jean.

No big deal :)

> Guenter (Cc'd) posted a fix here,
>=20
>   https://lkml.kernel.org/r/1441978088-27288-1-git-send-email-linux@r=
oeck-us.net

Actually I prefer Guenter's approach. I am never comfortable with
drivers selecting subsystems. So you can add:

Acked-by: Jean Delvare <jdelvare@suse.de>

to Guenter's patch and drop mine.

Thanks,
--=20
Jean Delvare
SUSE L3 Support
