From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH V2] i2c: i801: Intel DNV_N device IDs SMBus
Date: Thu, 18 Feb 2016 09:40:41 +0100
Message-ID: <20160218094041.6b16cb67@endymion>
References: <[PATCH V2] i2c: i801: Intel DNV_N device IDs SMBus>
	<1455762228-22341-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41707 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030335AbcBRIkp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 18 Feb 2016 03:40:45 -0500
In-Reply-To: <1455762228-22341-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 17 Feb 2016 18:23:48 -0800, Alexandra Yates wrote:
> Adding Intel codename DNV_N platform device IDs for SMBus.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> ---
>  Change log V1 to V2: Added changes to Documentation/i2c/busses/i2c-i801
>  drivers/i2c/busses/Kconfig and fixed merge conflicts.
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
