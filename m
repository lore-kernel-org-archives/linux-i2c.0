From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 17/24] regulator: fix dangling pointers
Date: Mon, 22 Mar 2010 19:49:10 +0000
Message-ID: <1269287350.3754.22.camel@odin>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
	 <1269094385-16114-18-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269094385-16114-18-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2010-03-20 at 15:12 +0100, Wolfram Sang wrote:
> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the structure
> was freed already.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 

Applied.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
