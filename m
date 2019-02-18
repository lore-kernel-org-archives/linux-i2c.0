From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive arbitration
 lost
Date: Mon, 18 Feb 2019 11:11:53 +0100
Message-ID: <4731eba7-7d85-62b9-2252-24ad55d75a0c@xilinx.com>
References: <20190218094132.5226-1-sxauwsk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218094132.5226-1-sxauwsk@163.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shikai Wang <sxauwsk@163.com>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 18. 02. 19 10:41, Shikai Wang wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting
> the adapter which resulted in the adapter being out of control.
> 
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.
> 
> Signed-off-by: Shikai Wang <sxauwsk@163.com>

ok. This is much better.

> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

I haven't see that Shubhrajyoti gave you this line that he is coauthor
of this.
It means you shouldn't add this SoB line if he didn't work on this.
He reviewed it that's why you should wait what he is going to sent.

Anyway based on email I see that this is 3rd version but I can't see any
version in subject and also description of changes.

That's why please take a look at this
Documentation/process/submitting-patches.rst

And send proper version. I would suggest to use v2 or v3.

Thanks,
Michal
