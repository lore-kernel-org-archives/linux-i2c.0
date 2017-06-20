From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Add support for Intel Cannon Lake
Date: Tue, 20 Jun 2017 15:33:39 +0200
Message-ID: <20170620153339.4b1118ee@endymion>
References: <20170518082306.3831-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40675 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752075AbdFTNdm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 20 Jun 2017 09:33:42 -0400
In-Reply-To: <20170518082306.3831-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thu, 18 May 2017 11:23:06 +0300, Jarkko Nikula wrote:
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Added SMBUS PCI Ids for SMBUS for Cannon Lake PCH.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> [jarkko.nikula@linux.intel.com: Add entries to Documentation and Kconfig.
> Cover Cannon Lake-H too]
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  Documentation/i2c/busses/i2c-i801 | 2 ++
>  drivers/i2c/busses/Kconfig        | 2 ++
>  drivers/i2c/busses/i2c-i801.c     | 8 ++++++++
>  3 files changed, 12 insertions(+)
> (...)

Sorry, missed that one.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
