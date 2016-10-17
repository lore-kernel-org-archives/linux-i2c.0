From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] i2c: i801: Fix I2C Block Read on 8-Series/C220 and
 later
Date: Mon, 17 Oct 2016 15:38:28 +0300
Message-ID: <293bfff5-6f69-4651-f488-affc353bfb5a@linux.intel.com>
References: <20161011131327.0eabd227@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:35939 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933978AbcJQMia (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 17 Oct 2016 08:38:30 -0400
In-Reply-To: <20161011131327.0eabd227@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On 10/11/2016 02:13 PM, Jean Delvare wrote:
>  drivers/i2c/busses/i2c-i801.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> --- linux-4.8.orig/drivers/i2c/busses/i2c-i801.c	2016-10-11 10:41:43.984120197 +0200
> +++ linux-4.8/drivers/i2c/busses/i2c-i801.c	2016-10-11 10:42:46.648783059 +0200
> @@ -146,6 +146,7 @@
>  #define SMBHSTCFG_HST_EN	BIT(0)
>  #define SMBHSTCFG_SMB_SMI_EN	BIT(1)
>  #define SMBHSTCFG_I2C_EN	BIT(2)
> +#define SMBHSTCFG_SPD_WD	BIT(4)
>
Looks like you had some local BIT() cleanup patch before this and patch 
doesn't apply. I fixed it locally and you can add my tested-by to this 
patch.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
