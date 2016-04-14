From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 13:40:41 +0200
Message-ID: <20160414114041.GS10108@pengutronix.de>
References: <1460627375.17638.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39848 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752097AbcDNLkp (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 07:40:45 -0400
Content-Disposition: inline
In-Reply-To: <1460627375.17638.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>

Hello Axel,

On Thu, Apr 14, 2016 at 05:49:35PM +0800, Axel Lin wrote:
> Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. =
The
> variable set here is later used as a divisor.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> If my understand is correct, you prefer to make it return error rathe=
r
> than using default frequency setting if DT setting is wrong.

No, I'd say it doesn't matter that the driver crashes if something
invalid is specified in the device tree. This is not a driver bug, but =
a
dt bug. So if it happens, fix the device tree, no need to modify the
driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
