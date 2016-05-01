From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/12] nvmem: mtk-efuse: remove nvmem regmap dependency
Date: Sun, 1 May 2016 14:01:46 -0700
Message-ID: <20160501210146.GA29070@kroah.com>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1461526096-29584-9-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58866 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEAVBr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 May 2016 17:01:47 -0400
Content-Disposition: inline
In-Reply-To: <1461526096-29584-9-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Joachim Eastwood <manabian@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, andrew@lunn.ch

On Sun, Apr 24, 2016 at 08:28:12PM +0100, Srinivas Kandagatla wrote:
> This patch moves to nvmem support in the driver to use callback
> instead of regmap.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> ---
>  drivers/nvmem/Kconfig     |  1 -
>  drivers/nvmem/mtk-efuse.c | 47 ++++++++++++++++++++++++++++++++---------------
>  2 files changed, 32 insertions(+), 16 deletions(-)

This patch didn't apply to my tree.  Can you fix it up and resend, and
also patch 11/12?

thanks,

greg k-h
