From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [Patch V2] i2c: imx: init bus recovery info before adding i2c
 adapter
Date: Wed, 9 Dec 2015 08:00:37 +0100
Message-ID: <20151209070037.GV5072@pengutronix.de>
References: <1449630502-14835-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59771 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbbLIHAp (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 9 Dec 2015 02:00:45 -0500
Content-Disposition: inline
In-Reply-To: <1449630502-14835-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: wsa@the-dreams.de, B20596@freescale.com, b38611@freescale.com, r49496@freescale.com, linux-i2c@vger.kernel.org, kernel@pengutronix.de

Hello,

On Wed, Dec 09, 2015 at 11:08:22AM +0800, Gao Pan wrote:
> During driver probe, i2c_imx_init_recovery_info() must come before
> i2c_add_numbered_adapter(), because the get/set_scl() functions
> are assigned in i2c_register_adapter() under the conditon that bus
> recover_info are initialized. Otherwise, get/set_scl() function
> pointers never get assigned.
>=20
> In such case, when i2c_generic_gpio_recovery() is used for bus recove=
ry,
> there will be kernel crash because bri->set_scl is NULL.
>=20
> The solution to this bug is moving i2c_imx_init_recovery_info() befor=
e
> i2c_register_adapter().
>=20
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I wonder why your S-o-b line isn't below Fugang Duan's. These lines are
supposed to show the order of people that touched the patch. So usually
the Author is the first person to sign off and the person who sends the
patch is the last.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
