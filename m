From: liguo zhang <liguo.zhang@mediatek.com>
Subject: Re: [PATCH v3] i2c: mediatek: i2c multi transfer optimization
Date: Sat, 16 Apr 2016 12:21:01 +0800
Message-ID: <1460780461.29864.34.camel@mhfsdcap03>
References: <1457375031-3769-1-git-send-email-liguo.zhang@mediatek.com>
	 <20160412211355.GA1526@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:35570 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750791AbcDPEVQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 16 Apr 2016 00:21:16 -0400
In-Reply-To: <20160412211355.GA1526@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

On Tue, 2016-04-12 at 23:13 +0200, Wolfram Sang wrote:
> Hi,
> 
> thanks for the submission!
> 
> On Tue, Mar 08, 2016 at 02:23:51AM +0800, Liguo Zhang wrote:
> > Signal complete() in the i2c irq handler after one transfer done,
> > and then wait_for_completion_timeout() will return, this procedure
> > may cost much time, so only signal complete() when the entire
> > transaction has been completed, it will reduce the entire transaction
> > time.
> > 
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> 
> I wonder. You have less context switches, yes. On the other hand, you
> likely have bigger interrupt latency because you do more stuff in the
> interrupt handler. Is it really a gain in the end?
> 

When doing i2c multi transfer(first i2c write then i2c read, and not
using the MTK i2c WRRD mode) repeatedly in our stress test, we found the
procedure(complete()-->wait_for_completion_timeout()) may cost much
time, and it will affect the following i2c transfer. In our stress test,
It will affect the i2c read transfer, the value from the i2c read is not
right.
So when doing i2c multi transfer, the first is i2c write,then i2c read,
we will use the MTK i2c WRRD mode to do i2c multi transfer in the
previous patch.
But If i2c multi transfer has at least three transfer, we can't use the
MTK i2c WRRD mode, this patch may be important. Now we have not already
seen the i2c multi transfer scenario, which has at least three transfer.

> Regards,
> 
>    Wolfram
> 
