From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/5] i2c: i2c-stm32f7: add driver
Date: Thu, 29 Jun 2017 20:00:55 +0200
Message-ID: <20170629180055.ga6jgonch6dhowyi@pengutronix.de>
References: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
 <1497958890-5530-4-git-send-email-pierre-yves.mordret@st.com>
 <20170627205135.greh3baskzi4zetk@pengutronix.de>
 <21ca1ecb-39ac-5d43-71a2-d566974ab577@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41649 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753615AbdF2SBL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 29 Jun 2017 14:01:11 -0400
Content-Disposition: inline
In-Reply-To: <21ca1ecb-39ac-5d43-71a2-d566974ab577@st.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

On Thu, Jun 29, 2017 at 02:40:44PM +0000, Pierre Yves MORDRET wrote:
> >> +	/* Arbitration loss */
> >> +	if (status & STM32F7_I2C_ISR_ARLO) {
> >> +		dev_err(dev, "<%s>: Arbitration loss\n", __func__);
> > 
> > Drop this. Arbitration loss is not an error and it shouldn't pollute the
> > kernel log.
> > 
> 
> I would like to keep it as indication though.
> Agree with dev_warn ?

No, dev_debug is ok.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
