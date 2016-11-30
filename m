From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Wed, 30 Nov 2016 14:21:26 +0100
Message-ID: <20161130132126.fziwsoik5ffmsiwx@pengutronix.de>
References: <20161130115005.11508-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59559 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754223AbcK3NV3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Nov 2016 08:21:29 -0500
Content-Disposition: inline
In-Reply-To: <20161130115005.11508-1-l.stach@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

On Wed, Nov 30, 2016 at 12:50:05PM +0100, Lucas Stach wrote:
> DDC buses are manually managed by their consumers to communicate
> with the display. There is no need to try to populate OF childs.

s/childs/children/ (in sum 3 times)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
