From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] i2c: rk3x: add support for rk3228
Date: Fri, 18 Mar 2016 15:16:00 -0500
Message-ID: <20160318201600.GA3317@rob-hp-laptop>
References: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54658 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbcCRUQF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 18 Mar 2016 16:16:05 -0400
Content-Disposition: inline
In-Reply-To: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yakir Yang <ykk@rock-chips.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Heiko Stuebner <heiko@sntech.de>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

On Mon, Mar 14, 2016 at 11:09:15AM +0800, Yakir Yang wrote:
> Enable the I2C core for this SoC.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 4 ++--
>  drivers/i2c/busses/i2c-rk3x.c                      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
