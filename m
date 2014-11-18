From: Yao Yuan <yao.yuan@freescale.com>
Subject: RE: [PATCH v10 3/3] i2c: imx: add DMA support for freescale i2c driver
Date: Tue, 18 Nov 2014 06:56:27 +0000
Message-ID: <BL2PR03MB33898E57AC61B7D45685DCB83880@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1416220836-7666-1-git-send-email-yao.yuan@freescale.com>
 <1416220836-7666-4-git-send-email-yao.yuan@freescale.com>
 <20141117182413.GC12644@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141117182413.GC12644@katana>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "marex@denx.de" <marex@denx.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "fugang.duan@freescale.com" <fugang.duan@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thank you for having found the bug, I indeed missed initializing it('orig_jiffies'). 
I will do more detailed review and send the v11 soon.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Tuesday, November 18, 2014 2:24 AM
> To: Yuan Yao-B46683
> Cc: marex@denx.de; LW@KARO-electronics.de; mark.rutland@arm.com; Duan
> Fugang-B38611; shawn.guo@linaro.org; linux-kernel@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; linux-i2c@vger.kernel.org
> Subject: Re: [PATCH v10 3/3] i2c: imx: add DMA support for freescale i2c
> driver
> 
> On Mon, Nov 17, 2014 at 06:40:36PM +0800, Yuan Yao wrote:
> > Add dma support for i2c. This function depend on DMA driver.
> > You can turn on it by write both the dmas and dma-name properties in
> dts node.
> > DMA is optional, even DMA request unsuccessfully, i2c can also work
> well.
> >
> > Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> 
> gcc found a bug:
> 
> drivers/i2c/busses/i2c-imx.c:703:7: warning: 'orig_jiffies' may be used
> uninitialized in this function [-Wuninitialized]
> drivers/i2c/busses/i2c-imx.c:672:16: note: 'orig_jiffies' was declared
> here
> 
> > +	result = wait_for_completion_interruptible_timeout(
> > +				&i2c_imx->dma->cmd_complete,
> > +				msecs_to_jiffies(DMA_TIMEOUT));
> 
> And are you sure you want to use
> wait_for_completion_interruptible_timeout() instead of
> wait_for_completion_timeout() here? Unless you confirm you tested it a
> lot with signals, I really cannot recommend the *_interruptible_* version.
> 
> Other than that, good. I liked the logfile of what you tested very much!
> 
> Thanks,
> 
>    Wolfram
