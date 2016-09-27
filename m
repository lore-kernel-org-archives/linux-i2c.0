From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: defer probe if bus recovery GPIOs are not ready
Date: Tue, 27 Sep 2016 08:44:06 +0200
Message-ID: <20160927064406.s4p3px774lcm6zhb@pengutronix.de>
References: <20160927001858.11601-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37362 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752345AbcI0GoK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 27 Sep 2016 02:44:10 -0400
Content-Disposition: inline
In-Reply-To: <20160927001858.11601-1-stefan@agner.ch>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: wsa@the-dreams.de, leoyang.li@nxp.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Stefan,

On Mon, Sep 26, 2016 at 05:18:58PM -0700, Stefan Agner wrote:
> Some SoC might load the GPIO driver after the I2C driver and
> using the I2C bus recovery mechanism via GPIOs. In this case
> it is crucial to defer probing if the GPIO request functions
> do so, otherwise the I2C driver gets loaded without recovery
> mechanisms enabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
