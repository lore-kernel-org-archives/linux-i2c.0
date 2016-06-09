From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v10 0/8] add i2c driver supported for rk3399
Date: Thu, 09 Jun 2016 16:12:58 +0200
Message-ID: <1984217.j9J6dIjr4z@diego>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com> <2239664.BKqQWGCl8U@diego> <20160609074752.GA3720@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:35477 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbcFIONV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 10:13:21 -0400
In-Reply-To: <20160609074752.GA3720@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: David Wu <david.wu@rock-chips.com>, robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Am Donnerstag, 9. Juni 2016, 09:47:53 schrieb Wolfram Sang:
> > this series looks pretty nice now and it seems most everybody is happy
> > with it by now. Do you still have it in your inbox to look at, or should
> > David resend it again?
> 
> I use patchwork (as stated in MAINTAINERS), so nothing gets lost as long
> as it is send to the i2c-list. As long as it still applies, no need to
> resend. This series does have priority, thanks to the tags given.

Just verified that everything still applies against 4.7-rc1 and present boards 
still have working i2c with this series.


Heiko
