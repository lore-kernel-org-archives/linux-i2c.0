From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] i2c: imx: correct the method of getting private data in
 notifier_call
Date: Wed, 17 Apr 2019 03:18:39 +0000
Message-ID: <DB3PR0402MB39164854EB00BD26E8B70E76F5250@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555466064-27984-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AM0PR04MB4211D493C95357CE7B69574A80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
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
To: Aisheng Dong <aisheng.dong@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "eha@deif.com" <eha@deif.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "mojha@codeaurora.org" <mojha@codeaurora.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, "peda@axentia.se" <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hi, Aisheng

Best Regards!
Anson Huang

> -----Original Message-----
> From: Aisheng Dong
> Sent: Wednesday, April 17, 2019 11:13 AM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> wsa+renesas@sang-engineering.com; u.kleine-koenig@pengutronix.de;
> eha@deif.com; linux@rempel-privat.de; mojha@codeaurora.org; Laurentiu
> Tudor <laurentiu.tudor@nxp.com>; peda@axentia.se; linux-
> i2c@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH] i2c: imx: correct the method of getting private data in
> notifier_call
> 
> > From: Anson Huang
> > Sent: Wednesday, April 17, 2019 10:00 AM
> >
> > The way of getting private imx_i2c_struct in
> > i2c_imx_clk_notifier_call() is incorrect, should use clk_change_nb
> > element to get correct address and avoid below kernel dump during
> > POST_RATE_CHANGE notify by clk
> > framework:
> >
> > Unable to handle kernel paging request at virtual address 03ef1488 pgd
> > =
> > (ptrval) [03ef1488] *pgd=00000000 Internal error: Oops: 5 [#1] PREEMPT
> > SMP ARM Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > Workqueue: events reduce_bus_freq_handler PC is at
> > i2c_imx_set_clk+0x10/0xb8 LR is at i2c_imx_clk_notifier_call+0x20/0x28
> > pc : [<806a893c>]    lr : [<806a8a04>]    psr: a0080013
> > sp : bf399dd8  ip : bf3432ac  fp : bf7c1dc0
> > r10: 00000002  r9 : 00000000  r8 : 00000000
> > r7 : 03ef1480  r6 : bf399e50  r5 : ffffffff  r4 : 00000000
> > r3 : bf025300  r2 : bf399e50  r1 : 00b71b00  r0 : bf399be8
> > Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 4e03004a  DAC: 00000051 Process kworker/2:1
> > (pid: 38, stack limit = 0x(ptrval))
> > Stack: (0xbf399dd8 to 0xbf39a000)
> > 9dc0:
> > 806a89e4 00000000
> > 9de0: ffffffff bf399e50 00000002 806a8a04 806a89e4 80142900 ffffffff
> > 00000000
> > 9e00: bf34ef18 bf34ef04 00000000 ffffffff bf399e50 80142d84 00000000
> > bf399e6c
> > 9e20: bf34ef00 80f214c4 bf025300 00000002 80f08d08 bf017480 00000000
> > 80142df0
> > 9e40: 00000000 80166ed8 80c27638 8045de58 bf352340 03ef1480
> > 00b71b00 0f82e242
> > 9e60: bf025300 00000002 03ef1480 80f60e5c 00000001 8045edf0
> > 00000002 8045eb08
> > 9e80: bf025300 00000002 03ef1480 8045ee10 03ef1480 8045eb08
> > bf01be40 00000002
> > 9ea0: 03ef1480 8045ee10 07de2900 8045eb08 bf01b780 00000002
> > 07de2900 8045ee10
> > 9ec0: 80c27898 bf399ee4 bf020a80 00000002 1f78a400 8045ee10 80f60e5c
> > 80460514
> > 9ee0: 80f60e5c bf01b600 bf01b480 80460460 0f82e242 bf383a80 bf383a00
> > 80f60e5c
> > 9f00: 00000000 bf7c1dc0 80f60e70 80460564 80f60df0 80f60d24 80f60df0
> > 8011e72c
> > 9f20: 00000000 80f60df0 80f60e6c bf7c4f00 00000000 8011e7ac bf274000
> > 8013bd84
> > 9f40: bf7c1dd8 80f03d00 bf274000 bf7c1dc0 bf274014 bf7c1dd8 80f03d00
> > bf398000
> > 9f60: 00000008 8013bfb4 00000000 bf25d100 bf25d0c0 00000000
> > bf274000 8013bf88
> > 9f80: bf25d11c bf0cfebc 00000000 8014140c bf25d0c0 801412ec 00000000
> > 00000000
> > 9fa0: 00000000 00000000 00000000 801010e8 00000000 00000000
> > 00000000 00000000
> > 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000
> > 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > 00000000 00000000 [<806a893c>] (i2c_imx_set_clk) from [<806a8a04>]
> > (i2c_imx_clk_notifier_call+0x20/0x28)
> > [<806a8a04>] (i2c_imx_clk_notifier_call) from [<80142900>]
> > (notifier_call_chain+0x44/0x84) [<80142900>] (notifier_call_chain)
> > from [<80142d84>] (__srcu_notifier_call_chain+0x44/0x98)
> > [<80142d84>] (__srcu_notifier_call_chain) from [<80142df0>]
> > (srcu_notifier_call_chain+0x18/0x20)
> > [<80142df0>] (srcu_notifier_call_chain) from [<8045de58>]
> > (__clk_notify+0x78/0xa4) [<8045de58>] (__clk_notify) from [<8045edf0>]
> > (__clk_recalc_rates+0x60/0xb4) [<8045edf0>] (__clk_recalc_rates) from
> > [<8045ee10>] (__clk_recalc_rates+0x80/0xb4)
> > Code: e92d40f8 e5903298 e59072a0 e1530001 (e5975008) ---[ end trace
> > fc7f5514b97b6cbb ]---
> >
> > Fixes: 90ad2cbe88c2("i2c: imx: use clk notifier for rate changes")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Please also provide how to reproduce it.
> And it seems not a new issue, should we CC stable?

This issue is NOT easy to reproduce unless creating a dedicated test case, upstream
kernel normally does NOT go into this path, I met this issue during internal bus-freq
test, and it should be a real issue. Code review also can find this issue I think.

Yes, if it is indeed a real issue, we should CC stable.

Anson.

> 
> Regards
> Dong Aisheng
> 
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c
> > b/drivers/i2c/busses/i2c-imx.c index
> > c0c3043..fd70b11 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -515,9 +515,9 @@ static int i2c_imx_clk_notifier_call(struct
> > notifier_block *nb,
> >  				     unsigned long action, void *data)  {
> >  	struct clk_notifier_data *ndata = data;
> > -	struct imx_i2c_struct *i2c_imx = container_of(&ndata->clk,
> > +	struct imx_i2c_struct *i2c_imx = container_of(nb,
> >  						      struct imx_i2c_struct,
> > -						      clk);
> > +						      clk_change_nb);
> >
> >  	if (action & POST_RATE_CHANGE)
> >  		i2c_imx_set_clk(i2c_imx, ndata->new_rate);
> > --
> > 2.7.4
