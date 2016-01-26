From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/1] i2c: core: replace boolean variable by integer
Date: Tue, 26 Jan 2016 09:56:36 +0100
Message-ID: <20160126085636.GW3338@pengutronix.de>
References: <1447949516-107966-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41001 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932511AbcAZI4j (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jan 2016 03:56:39 -0500
Content-Disposition: inline
In-Reply-To: <1447949516-107966-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nokia.com>

Hello,

On Thu, Nov 19, 2015 at 06:11:56PM +0200, Andy Shevchenko wrote:
> There is a warning when compiling i2c-core.c
> drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y
>=20
> Replace boolean exdpression by a plain bitwise AND since I2C_M_RD is =
a bit 0

s/exdpression/expression/

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
