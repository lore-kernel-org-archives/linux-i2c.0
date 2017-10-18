From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: I2C slave mode for i2c-at91 driver
Date: Wed, 18 Oct 2017 09:31:15 +0200
Message-ID: <20171018073115.ewuoy5z3pbrysx4i@pengutronix.de>
References: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52207 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762413AbdJRHbS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 03:31:18 -0400
Content-Disposition: inline
In-Reply-To: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Juergen Fitschen <me@jue.yt>
Cc: linux-i2c@vger.kernel.org

Hello,

On Tue, Oct 17, 2017 at 12:56:24PM +0200, Juergen Fitschen wrote:
> Currently I'm working on a driver adding I2C slave support to some Atmel /
> Microchip MPUs. I already patched the i2c-at91.c and made the
> i2c-slave-eeprom backend working on an ATSAMA5D27. But this is still in the
> prototype status. My next steps are cleaning up the code and sharing the
> patch with you for review and merge into Linux.

<halfknowledge> Isn't the at91 i2c hardware broken or unreliable such
that it's usually recommended to stick to i2c-gpio? If so maybe the same
applies to client mode and someone should better extend i2c-gpio to
handle the slave API?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
