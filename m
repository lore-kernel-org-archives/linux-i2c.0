From: John Stultz <john.stultz@linaro.org>
Subject: Re: Issue with i2c-designware-platdrv's suspend/runtime-suspend handling
Date: Mon, 30 Jan 2017 14:05:43 -0800
Message-ID: <CALAqxLVzW6Di5GM6iXi7PUen2Dq0TZ=awXYXY74BUK02Nfwm0Q@mail.gmail.com>
References: <CALAqxLU7-77hEwUFNNdsvnRnrPPu+-eZfkDMHxeTT3MLMiKhfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:36355 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdA3WHZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Jan 2017 17:07:25 -0500
Received: by mail-ot0-f180.google.com with SMTP id 32so94380117oth.3
        for <linux-i2c@vger.kernel.org>; Mon, 30 Jan 2017 14:05:44 -0800 (PST)
In-Reply-To: <CALAqxLU7-77hEwUFNNdsvnRnrPPu+-eZfkDMHxeTT3MLMiKhfA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, zhangfei <zhangfei.gao@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Amit Pundir <amit.pundir@linaro.org>

On Tue, Jan 24, 2017 at 2:03 PM, John Stultz <john.stultz@linaro.org> wrote:
> I noticed that with my hikey board, on resume from suspend I'm getting
> the following WARNING:
>
> [   54.334054] ------------[ cut here ]------------
> [   54.334077] WARNING: CPU: 0 PID: 2217 at drivers/clk/clk.c:594
> clk_core_disable+0x20/0x78
> [   54.334080]
> [   54.334090] CPU: 0 PID: 2217 Comm: system_server Not tainted
> 4.9.0-00046-gee9ec2c #2067
> [   54.334094] Hardware name: HiKey Development Board (DT)
> [   54.334099] task: ffffffc074863200 task.stack: ffffffc061d1c000
> [   54.334105] PC is at clk_core_disable+0x20/0x78
> [   54.334111] LR is at clk_core_disable_lock+0x20/0x38
> [   54.334116] pc : [<ffffff80084ab728>] lr : [<ffffff80084ab848>]
> pstate: 800001c5
> [   54.334119] sp : ffffffc061d1faf0
> [   54.334128] x29: ffffffc061d1faf0 x28: 0000000000000000
> [   54.334136] x27: 0000000000000002 x26: ffffff8008d47000
> [   54.334143] x25: ffffff8008596000 x24: ffffff8008d15498
> [   54.334151] x23: ffffff8008db9000 x22: ffffffc075074870
> [   54.334158] x21: 0000000000000002 x20: ffffffc005f09500
> [   54.334165] x19: 0000000000000140 x18: 0000000000000001
> [   54.334172] x17: 0000000000000000 x16: 0000000000000000
> [   54.334180] x15: ffffffc005f43dc0 x14: 0000000000010000
> [   54.334187] x13: ffffff8008d906f8 x12: ffffff8008d15790
> [   54.334196] x11: ffffff8008d15000 x10: ffffff8008d8d000
> [   54.334204] x9 : 0000000000000000 x8 : ffffffc077f26218
> [   54.334212] x7 : 0000000000000000 x6 : 0000000000000000
> [   54.334220] x5 : ffffffc077f2b090 x4 : ffffffc061d1fa80
> [   54.334228] x3 : ffffff80084ab62c x2 : ffffff80084ab62c
> [   54.334236] x1 : 0000000000000000 x0 : ffffffc005f09500
> [   54.334239]
> [   54.334243] ---[ end trace 6474a624fb2fd658 ]---
> [   54.334248] Call trace:
> [   54.334254] Exception stack(0xffffffc061d1f920 to 0xffffffc061d1fa50)
> [   54.334262] f920: 0000000000000140 0000008000000000
> ffffffc061d1faf0 ffffff80084ab728
> [   54.334269] f940: ffffff8008ccc090 ffffffc074863200
> 0000000000000000 6f6674616c703d4d
> [   54.334276] f960: ffffffc061d1f970 ffffff8008087990
> ffffffc061d1f9b0 ffffff8008450c6c
> [   54.334283] f980: ffffff8008cc8000 ffffffc061d1fa90
> ffffff8008ccc090 ffffffc074863200
> [   54.334290] f9a0: ffffff8008db6170 ffffffc061d1fa08
> ffffffc061d1f9c0 ffffff8008087990
> [   54.334297] f9c0: ffffffc005f09500 0000000000000000
> ffffff80084ab62c ffffff80084ab62c
> [   54.334303] f9e0: ffffffc061d1fa80 ffffffc077f2b090
> 0000000000000000 0000000000000000
> [   54.334310] fa00: ffffffc077f26218 0000000000000000
> ffffff8008d8d000 ffffff8008d15000
> [   54.334317] fa20: ffffff8008d15790 ffffff8008d906f8
> 0000000000010000 ffffffc005f43dc0
> [   54.334322] fa40: 0000000000000000 0000000000000000
> [   54.334328] [<ffffff80084ab728>] clk_core_disable+0x20/0x78
> [   54.334336] [<ffffff80084ad26c>] clk_disable+0x1c/0x30
> [   54.334349] [<ffffff80086d926c>] i2c_dw_plat_prepare_clk.isra.0+0x44/0x80
> [   54.334356] [<ffffff80086d930c>] dw_i2c_plat_suspend+0x24/0x38
> [   54.334367] [<ffffff800858ad54>] platform_pm_suspend+0x24/0x58
> [   54.334377] [<ffffff8008595558>] dpm_run_callback.isra.7+0x20/0x68
> [   54.334385] [<ffffff8008595fb4>] __device_suspend+0x10c/0x298
> [   54.334393] [<ffffff8008597154>] dpm_suspend+0x10c/0x228
> [   54.334401] [<ffffff8008597540>] dpm_suspend_start+0x68/0x78
> [   54.334412] [<ffffff80080fa058>] suspend_devices_and_enter+0xb8/0x458
> [   54.334419] [<ffffff80080fa5e4>] pm_suspend+0x1ec/0x248
> [   54.334426] [<ffffff80080f924c>] state_store+0x94/0xa8
> [   54.334434] [<ffffff80084366dc>] kobj_attr_store+0x14/0x28
> [   54.334444] [<ffffff8008249a28>] sysfs_kf_write+0x48/0x58
> [   54.334451] [<ffffff8008248d20>] kernfs_fop_write+0xb0/0x1d8
> [   54.334461] [<ffffff80081cd714>] __vfs_write+0x1c/0x100
> [   54.334469] [<ffffff80081cd9a0>] vfs_write+0xa0/0x1b8
> [   54.334477] [<ffffff80081cdb9c>] SyS_write+0x44/0xa0
> [   54.334485] [<ffffff8008082ef0>] el0_svc_naked+0x24/0x28
>
>
> Doing some further debugging, it seems the problem is that the device
> is being runtime suspended, and then at suspend time, we're calling
> the same logic, calling i2c_dw_plat_prepare_clk, which causes the clk
> count warning.
>
> Removing the runtime pm ops:
> -       SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
> +//     SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
>
> seems to avoid the warning, but clearly isn't ideal. :)
>
> Should there be some logic keep track of the suspend state for the
> dw_i2c_dev device so we don't try to suspend (or resume) it twice?  Or
> is there something else I'm missing to keep this from happening?

Ping? Any thoughts on how best to fix this?  I'm leaning towards
adding a suspended state to the struct dw_i2c_dev. Any objections?

thanks
-john
