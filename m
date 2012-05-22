From: Richard Zhao <richard.zhao@freescale.com>
Subject: Re: [PATCH V2 00/11] enable imx6q_sabrelite sgtl5000
	audio support
Date: Tue, 22 May 2012 09:39:21 +0800
Message-ID: <20120522013920.GE6206@b20223-02.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
	<20120521125930.GC6206@b20223-02.ap.freescale.net>
	<20120521144543.GA4063@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20120521144543.GA4063@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, dong.aisheng@linaro.org, ben-linux@fluff.org, vinod.koul@intel.com, w.sang@pengutronix.de, timur@freescale.com, linux-i2c@vger.kernel.org, kernel@pengutronix.de, dan.j.williams@intel.com, shawn.guo@linaro.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 21, 2012 at 03:45:44PM +0100, Mark Brown wrote:
> On Mon, May 21, 2012 at 08:59:31PM +0800, Richard Zhao wrote:
> 
> > >   ASoC: imx-audmux: add pinctrl support
> > >   ASoC: fsl_ssi: convert to use devm_clk_get
> 
> > Linus has sent out pull request for pinctrl. So is that ok for you
> > to pick up the above two patch?
> 
> No, apart from anything else the second patch depends on clkdev which is
> nothing to do with pinctrl!
All right, It's my fault to mix a clean up patch. It may hold until the
merge window is closed.
>  For the first patch it wasn't clear if the
> changes in pinctrl were the actual dependencies or if there were more
> things needed from the ARM tree,
I remembered someone already explained the dependencies. It depends
on imx pinctrl work and dummy pinctrl enabled in ARM platform code. It
is why Shawn suggest it goes to ARM SoC.
> and in any case until those patches are
> actually in the ASoC tree we'll break the build if they get applied.
All righ, It's ok, if you think, I have to wait for one more cycle to
see the patch on mainline.
> 
> Guys, you really need to think about how you're organising what you're
> doing more.  You need to split your work out into focused lines of
> development rather than just having a single branch.  
Except the clean up patch, others are all related to enable audio. Do
you mean I supposed to split them in advance?
> 
> This patch series contains a whole bunch of different changes (the
> devm_clk_get() change is as far as I can tell completely unrelated to
> the rest for example) with unclear dependencies on multiple external
> trees.  You should be splitting unrelated changes out, trying to
> minimise interdependencies, and clearly identifying the dependencies
> that are there we can get things applied in a timely fashion.
hmm.. I should write more about dependencies in commit message.
> 
> Please resend these patches *after* their dependencies are in mainline.
OK.

Thanks
Richard
