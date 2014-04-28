From: Adam Williamson <awilliam@redhat.com>
Subject: Re: [Patch V2 1/9] ACPICA: Executer: Fix buffer allocation issue
 for generic_serial_bus region field accesses.
Date: Mon, 28 Apr 2014 11:08:25 -0700
Message-ID: <1398708505.2843.17.camel@adam.happyassassin.net>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
	 <1398695268-28645-1-git-send-email-tianyu.lan@intel.com>
	 <1398695268-28645-2-git-send-email-tianyu.lan@intel.com>
	 <1398707520.2843.16.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1398707520.2843.16.camel@adam.happyassassin.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: wsa@the-dreams.de, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2014-04-28 at 10:52 -0700, Adam Williamson wrote:
> On Mon, 2014-04-28 at 22:27 +0800, Lan Tianyu wrote:
> > From: Lv Zheng <lv.zheng@intel.com>
> > 
> > The size of the buffer allocated for generic_serial_bus region access
> > is not correct.  This patch introduces acpi_ex_get_serial_access_length()
> > to be invoked to obtain correct data buffer length.  Reported by
> > Lan Tianyu, Fixed by Lv Zheng.
> > 
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> 
> Very superficial issue, and sorry I forgot to mention it for v1, but the
> summary line for this patch (1/9) ends with a period - "...region field
> accesses." - which I think is not the correct style?

In fact, it seems this patch already got merged into Linus' tree
somehow:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/acpi/acpica/exfield.c?id=6273f00e6ecbd60494a979033b7e5271a29a0436

the others do not seem to have been merged yet.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net

