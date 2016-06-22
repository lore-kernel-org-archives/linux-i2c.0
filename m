From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Date: Wed, 22 Jun 2016 13:40:34 -0700
Message-ID: <20160622204034.GA29485@roeck-us.net>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
 <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
 <20160427173308.GN7946@pengutronix.de>
 <20160619195641.GD26875@pengutronix.de>
 <20160621111255.1a27363e@endymion>
 <20160622185252.5ecfdf1d@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34272 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbcFVUkw (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Jun 2016 16:40:52 -0400
Content-Disposition: inline
In-Reply-To: <20160622185252.5ecfdf1d@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hi Jean,

On Wed, Jun 22, 2016 at 06:52:52PM +0200, Jean Delvare wrote:
> Hi all,
>=20
> On Tue, 21 Jun 2016 11:12:55 +0200, Jean Delvare wrote:
> > On Sun, 19 Jun 2016 21:56:41 +0200, Uwe Kleine-K=F6nig wrote:
> > > > Note, I didn't check if this patch got applied in the meantime,=
 my
> > > > excuse is that http://lm-sensors.org where AFAIK the i2c-tools =
repo is
> > > > located isn't reachable for me.
> > >=20
> > > This still stands. Where is the upstream repository of i2c-tools?
> >=20
> > lm-sensors.org is dead, I am in the process of creating an i2c-tool=
s
> > repository at kernel.org. In the meantime you can use Guenter's git
> > tree as a reference:
> >=20
> > https://github.com/groeck/i2c-tools
> >=20
> > (This is what I will use as a base for the kernel.org repository.)
>=20
> This is (almost) done now. The new home of the i2c-tools repository i=
s:
>=20
> http://git.kernel.org/cgit/utils/i2c-tools/i2c-tools.git/
>=20
Thanks a lot!

Wonder if we should do the same with the lm-sensors repository,
such as utils/lm-sensors/lm-sensors.git. What do you think ?

Thanks,
Guenter
