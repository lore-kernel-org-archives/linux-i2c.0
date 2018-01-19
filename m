From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH i2c-tools] CHANGES: add i2ctransfer
Date: Fri, 19 Jan 2018 09:22:52 +0100
Message-ID: <20180119092252.6eaa32c6@endymion>
References: <20180115173644.12342-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754920AbeASIWy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Jan 2018 03:22:54 -0500
In-Reply-To: <20180115173644.12342-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 15 Jan 2018 18:36:44 +0100, Wolfram Sang wrote:
> So people know from CHANGES when it has been added.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  CHANGES | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/CHANGES b/CHANGES
> index 1ddaa9c..7ad9e21 100644
> --- a/CHANGES
> +++ b/CHANGES
> @@ -63,6 +63,7 @@ master
>              Marked as deprecated
>    i2cdetect: Do a best effort detection if functionality is missing
>               Clarify the SMBus commands used for probing by default
> +  i2ctransfer: new tool to send user-defined I2C messages in one transfer
>    i2c-dev.h: Minimize differences with kernel flavor
>               Move SMBus helper functions to include/i2c/smbus.h
>    i2c-stub-from-dump: Be more tolerant on input dump format

Good idea. A leading capital would be appreciated for consistency.

Speaking of i2ctransfer, would you agree to remove it from the
i2c-tools-3.1 branch? As I recall, the only reason why it was added
there in the first place is because the release of i2c-tools 4.0 was
late, but this has happened meanwhile. I don't think it makes sense to
add a new tool to branch in maintenance state which is supposed to
receive only bug fixes. As a packager, I would not expect to have to
change anything to my packaging if I follow such a branch.

-- 
Jean Delvare
SUSE L3 Support
