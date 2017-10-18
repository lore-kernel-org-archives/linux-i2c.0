From: Juergen Fitschen <me@jue.yt>
Subject: Re: I2C slave mode for i2c-at91 driver
Date: Wed, 18 Oct 2017 14:40:54 +0200
Message-ID: <e63b922a43905f912262652ff888e02f@jfitschen.de>
References: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
 <20171018073115.ewuoy5z3pbrysx4i@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from srv1.host37.de ([176.28.54.59]:49989 "EHLO srv1.host37.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbdJRNJu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 18 Oct 2017 09:09:50 -0400
In-Reply-To: <20171018073115.ewuoy5z3pbrysx4i@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org

Hi Uwe,

> <halfknowledge> Isn't the at91 i2c hardware broken or unreliable such
> that it's usually recommended to stick to i2c-gpio? If so maybe the 
> same
> applies to client mode and someone should better extend i2c-gpio to
> handle the slave API?

Can you describe what kind of unreliability you've observed? I had the 
master and slave mode running for some time and it seems to work quite 
well. No data losses. No undesired states.

Best regards,
   Juergen
