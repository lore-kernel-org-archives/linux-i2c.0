From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/2] Add device tree probe for i2c-imx driver
Date: Fri, 29 Jul 2011 09:51:18 +0800
Message-ID: <20110729015116.GA1946@S2100-06.ap.freescale.net>
References: <1310659425-17499-1-git-send-email-shawn.guo@linaro.org>
	<20110722021524.GG26837@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110722021524.GG26837@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: devicetree-discuss@lists.ozlabs.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org
List-Id: linux-i2c@vger.kernel.org

Ping ...

On Fri, Jul 22, 2011 at 10:15:25AM +0800, Shawn Guo wrote:
> Hi Ben,
> 
> Any comments, or it's been good for you to queue them for v3.1 window?
> 
> Regards,
> Shawn
> 
> On Fri, Jul 15, 2011 at 12:03:43AM +0800, Shawn Guo wrote:
> > The first patch removes unused init/exit hooks from platform data,
> > and the second one actually adds the actual device tree probe support.
> > 
> > Shawn Guo (2):
> >       i2c/imx: remove init/exit hooks from platform data
> >       i2c/imx: add device tree probe support
> > 
> >  .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   25 +++++++++++
> >  arch/arm/plat-mxc/include/mach/i2c.h               |    4 --
> >  drivers/i2c/busses/i2c-imx.c                       |   46 +++++++++----------
> >  3 files changed, 47 insertions(+), 28 deletions(-)

-- 
Regards,
Shawn
