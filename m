From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Add support for Intel Cedar Fork
Date: Thu, 21 Sep 2017 18:21:17 +0200
Message-ID: <20170921182117.5822e33b@endymion>
References: <20170921132316.20517-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750790AbdIUQVU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 21 Sep 2017 12:21:20 -0400
In-Reply-To: <20170921132316.20517-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Thu, 21 Sep 2017 16:23:16 +0300, Jarkko Nikula wrote:
> Add PCI ID for Intel Cedar Fork PCH.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  Documentation/i2c/busses/i2c-i801 | 1 +
>  drivers/i2c/busses/Kconfig        | 1 +
>  drivers/i2c/busses/i2c-i801.c     | 4 ++++
>  3 files changed, 6 insertions(+)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
