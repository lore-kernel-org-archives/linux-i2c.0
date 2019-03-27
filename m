From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [RESEND] i2c: imx: defer probing on dma channel request
Date: Wed, 27 Mar 2019 13:47:56 -0500
Message-ID: <CADRPPNTDvbbnGKqS4E8yd_rM5VryM518BYMge+rzhG0uQMR7qg@mail.gmail.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
 <873b5aeb-e20a-de6b-515e-bc8fcc263452@arm.com>
 <1f3a370e-1c47-2fcb-6816-2b136713c68d@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1f3a370e-1c47-2fcb-6816-2b136713c68d@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: "upstream-release@linux.nxdi.nxp.com" <upstream-release@linux.nxdi.nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Ying Zhang <ying.zhang22455@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Price <steven.price@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 27, 2019 at 8:46 AM Laurentiu Tudor <laurentiu.tudor@nxp.com> wrote:
>
> Hello,
>
> Just FYI, I'm still seeing issues with the dma driver compiled _out_,
> trying to test i2c without dma support. I get the crash below in generic
> driver code later in the boot process, debug is in progress.

That probably means the dma API shouldn't return -EPROBE_DEFER when
the driver is not compiled in?

>
> P.S. This is seen on an NXP LS1043A chip.
>
> [    5.152697] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000010
> [    5.161483] Mem abort info:
> [    5.164311]   ESR = 0x96000004
> [    5.167407]   Exception class = DABT (current EL), IL = 32 bits
> [    5.173391] device_initialize: dev = ffff800027756808
> [    5.178446] usb 4-1: new SuperSpeed Gen 1 USB device number 2 using
> xhci-hcd
> [    5.185489]   SET = 0, FnV = 0
> [    5.188532]   EA = 0, S1PTW = 0
> [    5.191676] Data abort info:
> [    5.194599]   ISV = 0, ISS = 0x00000004
> [    5.198476]   CM = 0, WnR = 0
> [    5.201485] [0000000000000010] user address but active_mm is swapper
> [    5.207894] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    5.213455] Modules linked in:
> [    5.216502] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted
> 5.1.0-rc2-next-20190327-00021-g7b1a4c075381-dirty #15
> [    5.226489] Hardware name: LS1043A RDB Board (DT)
> [    5.231189] Workqueue: events deferred_probe_work_func
> [    5.236317] pstate: a0000005 (NzCv daif -PAN -UAO)
> [    5.241098] pc : device_reorder_to_tail+0x13c/0x1b8
> [    5.245965] lr : device_reorder_to_tail+0xd8/0x1b8
> [    5.250743] sp : ffff000011823c70
> [    5.254046] x29: ffff000011823c70 x28: 0000000000000000
> [    5.259347] x27: ffff0000117abcd8 x26: ffff000011293a20
> [    5.264649] x25: ffff00001102a000 x24: ffff00001102a708
> [    5.269950] x23: ffff00001102a700 x22: ffff000010d28000
> [    5.275251] x21: ffff80007393b9a0 x20: fffffffffffffff8
> [    5.280552] x19: ffff80007393b8f0 x18: ffffffffffffffff
> [    5.285853] x17: 0000000000000002 x16: 0000000000000000
> [    5.291154] x15: ffff00001127d6c8 x14: 000000000000017e
> [    5.296454] x13: 0000000000000001 x12: 0000000000000000
> [    5.301755] x11: 0000000000000000 x10: 0000000000000980
> [    5.307055] x9 : ffff0000118238c0 x8 : ffff800073872560
> [    5.312356] x7 : ffff800073871d00 x6 : 0000000000000058
> [    5.317656] x5 : 000000000000000f x4 : 0000000000000100
> [    5.322957] x3 : 000080006a351000 x2 : 0991ec05b7534200
> [    5.328257] x1 : fffffffffffffff8 x0 : 0000000000000000
> [    5.333560] Process kworker/0:1 (pid: 18, stack limit =
> 0x(____ptrval____))
> [    5.340509] Call trace:
> [    5.342945]  device_reorder_to_tail+0x13c/0x1b8
> [    5.347466]  device_for_each_child+0x50/0xa8
> [    5.351725]  device_reorder_to_tail+0xc4/0x1b8
> [    5.356157]  device_pm_move_to_tail+0x34/0x50
> [    5.360502]  deferred_probe_work_func+0x64/0xa0
> [    5.365023]  process_one_work+0x1c8/0x320
> [    5.369021]  worker_thread+0x234/0x428
> [    5.372761]  kthread+0xf4/0x120
> [    5.375892]  ret_from_fork+0x10/0x18
> [    5.379458] Code: 911c2318 911c02f7 d0004e19 b4000274 (f9400e84)
> [    5.385541] ---[ end trace ab4b151d346a8d41 ]---
>
> ---
> Best Regards, Laurentiu
>
> On 25.03.2019 19:12, Steven Price wrote:
> > On 25/03/2019 15:30, laurentiu.tudor@nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> If the dma controller is not yet probed, defer i2c probe.
> >> The error path in probe was slightly modified (no functional change)
> >
> > There is a functional change for cases like:
> >
> >>      ret = pm_runtime_get_sync(&pdev->dev);
> >>      if (ret < 0)
> >>              goto rpm_disable;
> >
> > ...as rpm_disable will no longer fall through to the call of
> > clk_disable_unprepare().
> >
> >> to avoid triggering this WARN_ON():
> >> "cg-pll0-div1 already disabled
> >> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb0"
> >
> > I'm also not sure how this WARN_ON was hit. i2c_imx_probe() calls
> > clk_prepare_enable() which should increment the reference count. So it
> > should always be possible to decrememt the enable_count. What am I missing?
> >
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> ---
> >>   drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
> >>   1 file changed, 13 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> >> index 42fed40198a0..4e34b1572756 100644
> >> --- a/drivers/i2c/busses/i2c-imx.c
> >> +++ b/drivers/i2c/busses/i2c-imx.c
> >> @@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >>                              pdev->name, i2c_imx);
> >>      if (ret) {
> >>              dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> >> -            goto clk_disable;
> >> +            clk_disable_unprepare(i2c_imx->clk);
> >> +            return ret;
> >>      }
> >>
> >>      /* Init queue */
> >> @@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >>      pm_runtime_mark_last_busy(&pdev->dev);
> >>      pm_runtime_put_autosuspend(&pdev->dev);
> >>
> >> +    /* Init DMA config if supported */
> >> +    ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> >> +    if (ret) {
> >> +            if (ret != -EPROBE_DEFER)
> >> +                    dev_info(&pdev->dev, "can't use DMA, using PIO instead.\n");
> >> +            else
> >> +                    goto del_adapter;
> >> +    }
> >> +
> >
> > This can be simplified by reversing the condition:
> >
> >       if (ret) {
> >               if (ret == -EPROBE_DEFER)
> >                       goto del_adapter;
> >               dev_info();
> >       }
> >
> > or even:
> >
> >       if (ret == -EPROBE_DEFER)
> >               goto del_adapter;
> >       else if (ret)
> >               dev_info();
> >
> >>      dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
> >>      dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
> >>      dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
> >>              i2c_imx->adapter.name);
> >>
> >> -    /* Init DMA config if supported */
> >> -    ret = i2c_imx_dma_request(i2c_imx, phy_addr);
> >> -    if (ret < 0)
> >> -            goto clk_notifier_unregister;
> >> -
> >>      dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> >>      return 0;   /* Return OK */
> >>
> >> +del_adapter:
> >> +    i2c_del_adapter(&i2c_imx->adapter);
> >
> > This looks like a separate fix (previously the call to
> > i2c_add_numbered_adapter() was not undone in case of later errors). It
> > worth spelling this out in the commit message.
> >
> > Thanks,
> >
> > Steve
> >
> >>   clk_notifier_unregister:
> >>      clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
> >>   rpm_disable:
> >> @@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
> >>      pm_runtime_set_suspended(&pdev->dev);
> >>      pm_runtime_dont_use_autosuspend(&pdev->dev);
> >>
> >> -clk_disable:
> >> -    clk_disable_unprepare(i2c_imx->clk);
> >>      return ret;
> >>   }
> >>
> >>
> >
