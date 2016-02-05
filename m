From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH V2] i2c: i801: Adding Intel Lewisburg support for iTCO
Date: Fri, 5 Feb 2016 10:48:55 +0100
Message-ID: <20160205104855.5ec3432c@endymion>
References: <1454627215-2418-1-git-send-email-alexandra.yates@linux.intel.com>
	<20160204232746.GA2421@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56822 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbcBEJs6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 5 Feb 2016 04:48:58 -0500
In-Reply-To: <20160204232746.GA2421@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alexandra Yates <alexandra.yates@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 5 Feb 2016 00:27:46 +0100, Wolfram Sang wrote:
> On Thu, Feb 04, 2016 at 03:06:55PM -0800, Alexandra Yates wrote:
> > Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog
> > resources have been moved to reside under the i801 SMBus host
> > controller whereas previously they were under the LPC device.
> > 
> > This patch adds Intel lewisburg SMBus support for iTCO device.
> > 
> > Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> 
> Please state what has changed in v2 of this patch?

Yes, Alexandra, please always include a changelog (between the ---
separator and the diffstat) when posting patch updates.

In this case there is no code change, the only change is the subject.

If I understand correctly, this is a fixup for commit
cdc5a3110e7c3ae793f367285789a6bc39c962dc ("i2c: i801: add Intel
Lewisburg device IDs") which should have included these changes. If so,
please mention it in the commit message. It may also make sense to tag
the patch for stable [v4.4].

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
