From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: rcar: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 09:09:26 +0100
Message-ID: <20151112080926.GC24008@pengutronix.de>
References: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151112074447.GA24008@pengutronix.de>
 <20151112075238.GA1551@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57714 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbbKLIJ3 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 03:09:29 -0500
Content-Disposition: inline
In-Reply-To: <20151112075238.GA1551@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Wolfram,

On Thu, Nov 12, 2015 at 08:52:38AM +0100, Wolfram Sang wrote:
> On Thu, Nov 12, 2015 at 08:44:47AM +0100, Uwe Kleine-K=F6nig wrote:
> > Other than that, the NULL pointer dereference should only happen if=
 the
> > device was bound using the driver name. That might be worth to poin=
t out
> > in the commit log. So maybe make (in a separate patch) the probe
> > function fail when probed by name?
>=20
> RCar is a DT only platform.

Does this imply that no checking is needed? I'm not sure.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
