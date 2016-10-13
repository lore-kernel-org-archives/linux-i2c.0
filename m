From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 3/5] i2c: i2c-piix4: coding style fix - long comments
 blocks
Date: Thu, 13 Oct 2016 13:30:52 +0200
Message-ID: <20161013133052.3e2296d1@endymion>
References: <20161011172441.7422-1-palminha@synopsys.com>
        <20161011172441.7422-4-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755324AbcJMLn6 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Oct 2016 07:43:58 -0400
In-Reply-To: <20161011172441.7422-4-palminha@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de

Hi Carlos,

On Tue, 11 Oct 2016 18:24:39 +0100, Carlos Palminha wrote:
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 94 ++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 5d6f637..85b1052 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> (...)
>  /*
> -   Supports:
> -	Intel PIIX4, 440MX
> -	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
> -	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
> -	AMD Hudson-2, ML, CZ
> -	SMSC Victory66
> -
> -   Note: we assume there can only be one device, with one or more
> -   SMBus interfaces.
> -   The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
> -   For devices supporting multiple ports the i2c_adapter should provide
> -   an i2c_algorithm to access them.
> -*/
> + * Supports:
> + *	Intel PIIX4, 440MX
> + *	Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
> + *	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
> + *	AMD Hudson-2, ML, CZ
> + *	SMSC Victory66
> + *
> + *  Note: we assume there can only be one device, with one or more

There's an extra space before "Note:", please remove.

> + * SMBus interfaces.
> + * The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
> + * For devices supporting multiple ports the i2c_adapter should provide
> + * an i2c_algorithm to access them.
> + */

-- 
Jean Delvare
SUSE L3 Support
