From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Date: Wed, 27 Apr 2016 19:33:09 +0200
Message-ID: <20160427173308.GN7946@pengutronix.de>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
 <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52937 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752287AbcD0RdM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Apr 2016 13:33:12 -0400
Content-Disposition: inline
In-Reply-To: <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

Hello,

On Fri, Jun 19, 2015 at 12:40:31PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This tool allows to construct and concat multiple I2C messages into o=
ne
> single transfer. Its aim is to test I2C master controllers, and so th=
ere
> is no SMBus fallback.
>=20
> I've been missing such a tool a number of times now, so I finally got
> around to writing it myself. As with all I2C tools, it can be dangero=
us,
> but it can also be very useful when developing. I am not sure if dist=
ros
> should supply it, I'll leave that to Jean's experience. For embedded
> build systems, I think this should be selectable.
>=20
> Tested with various Renesas I2C IP cores as well as Tegra and AT91.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I didn't look at the patch, but it would be great to get this
functionality into i2c-tools.

Note, I didn't check if this patch got applied in the meantime, my
excuse is that http://lm-sensors.org where AFAIK the i2c-tools repo is
located isn't reachable for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
