From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/11] dma: imx-sdma: make channel0
	operations atomic
Date: Fri, 27 Apr 2012 12:33:35 +0100
Message-ID: <20120427113335.GM24211@n2100.arm.linux.org.uk>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
	<1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
	<1335514900.31825.132.camel@vkoul-udesk3>
	<20120427084109.GO28063@b20223-02.ap.freescale.net>
	<1335522130.31825.135.camel@vkoul-udesk3>
	<20120427112655.GS28063@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20120427112655.GS28063@b20223-02.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, kernel@pengutronix.de, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, dan.j.williams@intel.com, shawn.guo@linaro.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 27, 2012 at 07:26:56PM +0800, Richard Zhao wrote:
> Sure, I mean, can you doc in include/linux/dmaengine.h that
> dmaengine_prep_xxx may sleep?

Incorrect.  They may _not_ sleep.
