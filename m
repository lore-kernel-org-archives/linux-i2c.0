From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Tue, 20 Jun 2017 10:28:35 +0200
Message-ID: <20170620082835.melqahq7lwyb2hfl@pengutronix.de>
References: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
 <20170619144601.vhswaa27f5mcxcxs@ninjato>
 <681500CE65202E47A192754B01DAB4671B1674818F@SDE12.beckipc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55791 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751018AbdFTI2h (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Jun 2017 04:28:37 -0400
Content-Disposition: inline
In-Reply-To: <681500CE65202E47A192754B01DAB4671B1674818F@SDE12.beckipc.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Andy Duan <fugang.duan@nxp.com>

Cc += Andy Duan

On Tue, Jun 20, 2017 at 10:20:42AM +0200, Michail Georgios Etairidis wrote:
> 
> The i2c-imx driver incorrectly uses readb()/writeb() to read and 
> write to the appropriate registers when performing a repeated start. 
> The appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions 
> should be used instead. Performing a repeated start results in 
> a kernel panic. The platform is imx.

I really wonder why this didn't pop up earlier, maybe repeated start
just isn't that usual.

> Signed-off-by: Michail G Etairidis <m.etairidis@beck-ipc.com>
Fixes: ce1a78840ff7 ("i2c: imx: add DMA support for freescale i2c driver")
Fixes: 054b62d9f25c ("i2c: imx: fix the i2c bus hang issue when do repeat restart")
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
