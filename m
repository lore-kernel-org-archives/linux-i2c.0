From: Jisheng Zhang <jszhang@marvell.com>
Subject: use {readl|writel}_relaxed instead of readl/writel in
 i2c-designware-core ?
Date: Fri, 14 Feb 2014 15:54:38 +0800
Message-ID: <20140214155438.4f749a79@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

The writel/readl is too expensive especially on Cortex A9 w/ outer L2 cache. This
introduce i2c read/write error on Marvell Berlin SoCs when there are L2 cache
maintenance operations at the same time.

In our internal berlin bsp, we just replaced readl/writel with the relaxed
version. But AFAIK, the "relaxed" version doesn't exist on all architectures. How
to handle this issue? 

Any suggestions are appreciated.

Thanks in advance,
Jisheng
