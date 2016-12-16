From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: i2c-mux-pca954x: only reset last channel on error
Date: Fri, 16 Dec 2016 22:30:11 +0100
Message-ID: <4214d65e-7146-38e4-cb02-d6c947a51e65@axentia.se>
References: <20161216210843.26853-1-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0117.outbound.protection.outlook.com ([104.47.2.117]:2943
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754496AbcLPVaT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Dec 2016 16:30:19 -0500
In-Reply-To: <20161216210843.26853-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com, Russell King <rmk+kernel@armlinux.org.uk>

On 2016-12-16 22:08, Vivien Didelot wrote:
> The current code is selecting the mux channel before each operation and
> does not benefit from the cached value (data->last_chan).
> 
> That is because pca954x_select_chan() considers any non-zero values from
> pca954x_reg_write() as an error. But this function (via __i2c_transfer)
> returns either a negative error code or the positive number of messages
> executed.
> 
> Only check "ret" against negative values to restore the caching.
> 
> Fixes: 463e8f845cbf ("i2c: mux: pca954x: retry updating the mux selection on failure")
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Hi Vivien,

Thanks for the report, and sorry for breaking things. However, your
patch got beaten by an hour by Russel King who sent approximately
the same patch. I had already responded to his message when I saw
yours, so I did not Cc you.

Cheers,
peda
