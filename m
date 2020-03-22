From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v3] i2c: at91: support atomic write xfer
Date: Sun, 22 Mar 2020 17:30:13 +0100
Message-ID: <20200322163013.GA25488@qmqm.qmqm.pl>
References: <55613934b7d14ae4122b648c20351b63b03a1385.1584851536.git.mirq-linux@rere.qmqm.pl>
 <20200322143004.GB1091@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([91.227.64.183]:24702 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgCVQaS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 22 Mar 2020 12:30:18 -0400
Content-Disposition: inline
In-Reply-To: <20200322143004.GB1091@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dmitry Osipenko <digetx@gmail.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Marco Felsch <m.felsch@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 03:30:04PM +0100, Wolfram Sang wrote:
> 
> > +	/* FIXME: only single write request supported to 7-bit addr */
> 
> Hmm, this is quite limited. Would it be very hard to support multiple
> messages? Or reads? 10 bits don't matter.

I don't expect this to be used for much more than a simple write to PMIC
to kill the power. So this patch is tailor made for exactly this purpose.
Though, if you would go for full support of atomic transfers, then
I would suggest to hack the non-atomic path to be usable in atomic mode
instead (some I2C drivers do just that, eg. i2c-tegra).

BTW, I found this comment in i2c-core.h:

 * We only allow atomic transfers for very late communication, e.g. to send
 * the powerdown command to a PMIC. Atomic transfers are a corner case and not
 * for generic use! 

I think this covers the idea.

> > +	if (!dev->pdata->has_alt_cmd)
> > +		return -EOPNOTSUPP;
> 
> We should handle this in probe(), I think:
> 
> 	if (dev->pdata->has_alt_cmd)
> 		at91_twi_algorithm.master_xfer_atomic = at91_twi_xfer_atomic;

This would mean writable ops structure - something I try hard to avoid.
We can use another copy of i2c_algorithm structure if needed, though.

Best Regards
Micha³ Miros³aw
