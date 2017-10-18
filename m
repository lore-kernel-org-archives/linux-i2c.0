From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: I2C slave mode for i2c-at91 driver
Date: Wed, 18 Oct 2017 10:00:51 +0200
Message-ID: <20171018080051.unweewh6bx66pejh@pengutronix.de>
References: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
 <20171018073115.ewuoy5z3pbrysx4i@pengutronix.de>
 <20171018074306.gapzynnrzpf7bvfj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53865 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935793AbdJRIAx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 04:00:53 -0400
Content-Disposition: inline
In-Reply-To: <20171018074306.gapzynnrzpf7bvfj@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Juergen Fitschen <me@jue.yt>, linux-i2c@vger.kernel.org

On Wed, Oct 18, 2017 at 09:43:07AM +0200, Wolfram Sang wrote:
> 
> > <halfknowledge> Isn't the at91 i2c hardware broken or unreliable such
> > that it's usually recommended to stick to i2c-gpio? If so maybe the same
> 
> I thought later versions have been fixed? (half knowledge, too)
> 
> > applies to client mode and someone should better extend i2c-gpio to
> > handle the slave API?
> 
> I wouldn't like that much. It means polling the GPIOs to scan the I2C
> bus for the communication of the master.

GPIOs changing its level can trigger an irq, so the hardware does the
job of polling for you.  This doesn't necessarily makes this a good
idea, but it's not as bad as it could be.

> That is timing-critical and does not like latency. Might even depend
> on the RT patchset ;)

If the bus is operated slow enough it could work.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
