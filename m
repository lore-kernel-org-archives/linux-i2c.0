From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Tue, 2 Jul 2013 10:23:44 +0800
Message-ID: <20130702022342.GZ13206@S2101-09.ap.freescale.net>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372713261-20551-1-git-send-email-festevam@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: wsa@the-dreams.de, marex@denx.de, kernel@pengutronix.de, linux-i2c@vger.kernel.org, alexandre.belloni@free-electrons.com, to-fleischer@t-online.de, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 01, 2013 at 06:14:21PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Recently we have been seing some reports about PIO mode not working properly.
> 
> - http://www.spinics.net/lists/linux-i2c/msg11985.html
> - http://marc.info/?l=linux-i2c&m=137235593101385&w=2
> - https://lkml.org/lkml/2013/6/24/430
> 
It also causes sgtl5000 register write failure [1].  Changing it back to
DMA mode fixes the failure.  So,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

[1] http://thread.gmane.org/gmane.linux.alsa.devel/109715/focus=109747
