From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] i2c-tools: add new tool 'i2ctransfer'
Date: Sun, 19 Jun 2016 21:56:41 +0200
Message-ID: <20160619195641.GD26875@pengutronix.de>
References: <1434710432-4182-1-git-send-email-wsa@the-dreams.de>
 <1434710432-4182-2-git-send-email-wsa@the-dreams.de>
 <20160427173308.GN7946@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50192 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751501AbcFSUd1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 19 Jun 2016 16:33:27 -0400
Content-Disposition: inline
In-Reply-To: <20160427173308.GN7946@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>

Hello,

On Wed, Apr 27, 2016 at 07:33:09PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Jun 19, 2015 at 12:40:31PM +0200, Wolfram Sang wrote:
> > This tool allows to construct and concat multiple I2C messages into=
 one
> > single transfer. Its aim is to test I2C master controllers, and so =
there
> > is no SMBus fallback.
> > [...]
>=20
> I didn't look at the patch, but it would be great to get this
> functionality into i2c-tools.

In the meantime I tested i2ctransfer, I really like it and it helped me
debugging a problem with an i2c rtc device that isn't usable with
i2cget/i2cset.
=20
> Note, I didn't check if this patch got applied in the meantime, my
> excuse is that http://lm-sensors.org where AFAIK the i2c-tools repo i=
s
> located isn't reachable for me.

This still stands. Where is the upstream repository of i2c-tools?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
