From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: efm32: fix a failure path in efm32_i2c_probe()
Date: Sat, 16 Jul 2016 10:55:53 +0200
Message-ID: <20160716085553.GI6040@pengutronix.de>
References: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40136 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751424AbcGPIz7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 16 Jul 2016 04:55:59 -0400
Content-Disposition: inline
In-Reply-To: <1468625798-6767-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Wolfram Sang <wsa@the-dreams.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, ldv-project@linuxtesting.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jul 16, 2016 at 02:36:38AM +0300, Alexey Khoroshilov wrote:
> There is the only failure path in efm32_i2c_probe(),
> where clk_disable_unprepare() is missed.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

oops, this is wrong since the beginning.

=46ixes: 1b5b23718b84 ("i2c: efm32: new bus driver")
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
