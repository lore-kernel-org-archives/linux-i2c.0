From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Disable runtime PM in case
 i2c_dw_probe() fails
Date: Thu, 22 Oct 2015 10:41:04 +0300
Message-ID: <20151022074104.GG1526@lahna.fi.intel.com>
References: <1445437306-9268-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7106 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbbJVHlI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 03:41:08 -0400
Content-Disposition: inline
In-Reply-To: <1445437306-9268-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Wed, Oct 21, 2015 at 05:21:46PM +0300, Jarkko Nikula wrote:
> Call to pm_runtime_disable() got dropped while handling the merge conflict
> between commit 36d48fb5766a ("i2c: designware-platdrv: enable RuntimePM
> before registering to the core") and commit d80d134182ba ("i2c: designware:
> Move common probe code into i2c_dw_probe()").
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
