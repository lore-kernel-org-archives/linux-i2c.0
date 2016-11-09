From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Date: Wed, 9 Nov 2016 14:41:03 +0100
Message-ID: <20161109134103.GC2960@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:15920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932410AbcKINlW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 9 Nov 2016 08:41:22 -0500
Content-Disposition: inline
In-Reply-To: <20161107200921.30284-2-paul.burton@imgtec.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Peter Swain <pswain@cavium.com>, Wolfram Sang <wsa@the-dreams.de>

Hi Paul,

I think we should revert commit "70121f7 i2c: octeon: thunderx: Limit
register access retries". With debugging enabled I'm getting:

[   78.871568] ipmi_ssif: Trying hotmod-specified SSIF interface at i2c address 0x12, adapter Cavium ThunderX i2c adapter at 0000:01:09.4, slave address 0x0
[   78.886107] do not call blocking ops when !TASK_RUNNING; state=2 set at [<fffffc00080e0088>] prepare_to_wait_event+0x58/0x10c
[   78.897436] ------------[ cut here ]------------
[   78.902050] WARNING: CPU: 6 PID: 2235 at kernel/sched/core.c:7718 __might_sleep+0x80/0x88
[   78.910218] Modules linked in: ipmi_ssif i2c_thunderx i2c_smbus nicvf nicpf thunder_bgx thunder_xcv mdio_thunder

[   78.921916] CPU: 6 PID: 2235 Comm: bash Tainted: G        W       4.9.0-rc3-jang+ #17
[   78.929737] Hardware name: www.cavium.com ThunderX CRB-1S/ThunderX CRB-1S, BIOS 0.3 Aug 24 2016
[   78.938426] task: fffffe1fdd554500 task.stack: fffffe1fe384c000
[   78.944338] PC is at __might_sleep+0x80/0x88
[   78.948601] LR is at __might_sleep+0x80/0x88
[   78.952863] pc : [<fffffc00080c3aac>] lr : [<fffffc00080c3aac>] pstate: 80000145
[   78.960250] sp : fffffe1fe384f600
[   78.963557] x29: fffffe1fe384f600 x28: fffffe1fe384f860
[   78.968875] x27: fffffe1fd07fa018 x26: fffffe1fe384f968
[   78.974193] x25: fffffc0009a2b000 x24: 00000000ffff26d6
[   78.979510] x23: fffffe1fe384f860 x22: fffffe1fe384f860
[   78.984827] x21: 0000000000000000 x20: 00000000000000b1
[   78.990144] x19: fffffc0000e330b8 x18: 0000000000005bb0
[   78.995461] x17: fffffc0009669ca8 x16: 0000000000000000
[   79.000779] x15: 0000000000000539 x14: 66663c5b20746120
[   79.006097] x13: 74657320323d6574 x12: 617473203b474e49
[   79.011415] x11: 4e4e55525f4b5341 x10: 5421206e65687720
[   79.016732] x9 : 73706f20676e696b x8 : 0000000000000000
[   79.022049] x7 : fffffc00080f5740 x6 : fffffc00080f5740
[   79.027367] x5 : ffffffffffffff80 x4 : 0000000000000060
[   79.032684] x3 : 0000000000000000 x2 : 0000000000000001
[   79.038001] x1 : 0000000000000000 x0 : 0000000000000071

[   79.044803] ---[ end trace d8af6005f683d444 ]---
[   79.049413] Call trace:
[   79.051853] Exception stack(0xfffffe1fe384f420 to 0xfffffe1fe384f550)
[   79.058287] f420: fffffc0000e330b8 0000040000000000 fffffe1fe384f600 fffffc00080c3aac
[   79.066109] f440: 0000000080000145 000000000000003d 0000000000000000 fffffc0008853920
[   79.073931] f460: 0000040000000000 0000000100000001 fffffe1fe384f520 fffffc00080f60d8
[   79.081752] f480: fffffc0000e330b8 00000000000000b1 0000000000000000 fffffe1fe384f860
[   79.089574] f4a0: fffffe1fe384f860 00000000ffff26d6 fffffc0009a2b000 fffffe1fe384f968
[   79.097396] f4c0: fffffe1fd07fa018 fffffe1fe384f860 0000000000000071 0000000000000000
[   79.105218] f4e0: 0000000000000001 0000000000000000 0000000000000060 ffffffffffffff80
[   79.113040] f500: fffffc00080f5740 fffffc00080f5740 0000000000000000 73706f20676e696b
[   79.120861] f520: 5421206e65687720 4e4e55525f4b5341 617473203b474e49 74657320323d6574
[   79.128683] f540: 66663c5b20746120 0000000000000539
[   79.133553] [<fffffc00080c3aac>] __might_sleep+0x80/0x88
[   79.138862] [<fffffc0000e30138>] octeon_i2c_test_iflg+0x4c/0xbc [i2c_thunderx]
[   79.146077] [<fffffc0000e30958>] octeon_i2c_test_ready+0x18/0x70 [i2c_thunderx]
[   79.153379] [<fffffc0000e30b04>] octeon_i2c_wait+0x154/0x1a4 [i2c_thunderx]
[   79.160334] [<fffffc0000e310bc>] octeon_i2c_xfer+0xf4/0xf60 [i2c_thunderx]

This is not caused by the usleep inside the wait_event but by readq_poll_timeout().
Could you try if it works for you if you only revert this patch?

Thanks,
Jan
