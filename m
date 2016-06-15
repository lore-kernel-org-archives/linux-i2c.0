From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] i2c: designware-pci: Make bus number allocation
 robust
Date: Wed, 15 Jun 2016 17:15:46 +0300
Message-ID: <1466000146.30123.126.camel@linux.intel.com>
References: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <f2466d99-ca2d-127c-ae90-54ec8a1ae25c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54793 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbcFOOOv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 10:14:51 -0400
In-Reply-To: <f2466d99-ca2d-127c-ae90-54ec8a1ae25c@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Wed, 2016-06-15 at 16:42 +0300, Jarkko Nikula wrote:
> On 06/15/2016 01:55 AM, Andy Shevchenko wrote:
> > On some platforms, such as Intel Medfield, the I2C slave devices ar=
e
> > enumerated
> > through SFI tables where bus numbering is expected to be defined in
> > the OS.
> > Make the bus number allocation robust for such platforms.

> > ...
> > -	[medfield_3] =3D {
> > -		.bus_num=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 3,
> > -		.bus_cfg=C2=A0=C2=A0=C2=A0=3D INTEL_MID_STD_CFG |
> > DW_IC_CON_SPEED_STD,

> > +	[medfield] =3D {
> > +		.bus_num =3D -1,
> > =C2=A0		.bus_cfg=C2=A0=C2=A0=C2=A0=3D INTEL_MID_STD_CFG |
> > DW_IC_CON_SPEED_FAST,

> Now bus 3 speed is pumped up to fast speed. Can it cause problems?

Oh, I have no idea, so, I would leave it at lower speed.

While we are here, what are your recommendations to put ->setup() call
in the ->probe()? Currently it is located somewhere in the middle of
assignments. I think the workflow has to be the following:
1. Take static controller data from platform based on ID's
2. Call controller->setup() if defined
3. Re-assign i2c device parameters with data in controller

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
