From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
Date: Fri, 13 Jan 2017 09:45:13 +0100
Message-ID: <20170113084513.wvuxkanrlmgz3ang@pengutronix.de>
References: <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
 <20170112120309.fmrt2lwz3vklqmti@pengutronix.de>
 <CAOAejn289GLOSP-nPJnO_VpXLpyhTsF1bWQ7Ns9OfgPQCa8YTw@mail.gmail.com>
 <20170112174902.j52foglkdouyz36n@pengutronix.de>
 <CAOAejn3tPi0fjy+t-UhMTvAq7LfdKJJdbcLw2su1-YAGDZMxew@mail.gmail.com>
 <20170112211004.z3wylc7vrubulc3x@pengutronix.de>
 <CAOAejn1HAU5spQeXmYPH4XH0L5bGuoFgguozwMp=uLKcXDEPEw@mail.gmail.com>
 <20170113072650.orx6vl2orqfakcuk@pengutronix.de>
 <20170113082903.GA1446@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42579 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751222AbdAMIp0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 13 Jan 2017 03:45:26 -0500
Content-Disposition: inline
In-Reply-To: <20170113082903.GA1446@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jan 13, 2017 at 09:29:03AM +0100, Wolfram Sang wrote:
> 
> > (But note that this is irrelevant for the patch as the driver doesn't
> > claim to support this kind of transfer.)
> 
> Yes, I wanted to mention that, too.
> 
> I'd think the series is good to go in?

AFAICT there are some unaddressed comments that Cedrics claimed to fix
before our discussion was dominated by block transfers.

Best regards
Uwe



-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
