From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v8 0/2] i2c: imx: add DMA support for freescale i2c driver
Date: Thu, 25 Sep 2014 12:23:54 +0200
Message-ID: <201409251223.54218.marex@denx.de>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: wsa@the-dreams.de, LW@karo-electronics.de, mark.rutland@arm.com, fugang.duan@freescale.com, shawn.guo@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thursday, September 25, 2014 at 10:11:27 AM, Yuan Yao wrote:
> Changed in v8:
> - some minor fixes for coding style.
> - unsetting I2CR_DMAEN immediatelly when failed in DMA mode.

Brief skim over the patch doesn't show any dangling problems.

Reviewed-by: Marek Vasut <marex@denx.de>

btw. the U-Boot output is completely irrelevant, it only points out you use 
outdated version, so please keep only the relevant output. Also, I would 
recommend you to trim the responses to patches with [...] so one doesn't have to 
scroll through a wall of old text, but can easily find the relevant portions.

Best regards,
Marek Vasut
