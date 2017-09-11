From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] i2c: imx: allow i2c devices share an interrupt
Date: Mon, 11 Sep 2017 11:09:30 +0200
Message-ID: <20170911090930.p5horsgf4atqtlhs@pengutronix.de>
References: <20170911083416.2895-1-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51007 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751013AbdIKJJc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Sep 2017 05:09:32 -0400
Content-Disposition: inline
In-Reply-To: <20170911083416.2895-1-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ying.zhang22455@nxp.com
Cc: linux-i2c@vger.kernel.org

Hello,

On Mon, Sep 11, 2017 at 04:34:16PM +0800, ying.zhang22455@nxp.com wrote:
> From: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> 
> Allow the I2C device on the same bus can’t claim irq.

I don't understand the motivation for this change. Is there an
imx-platform that doesn't have a dedicated irq for i2c? The commit log
suggests there is an i2c device with the same irq. What is meant here, a
bus device or the imx operating in slave mode?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
