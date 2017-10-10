From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3] i2c: piix4: Disable completely the IMC during
 SMBUS_BLOCK_DATA
Date: Tue, 10 Oct 2017 20:28:59 +0200
Message-ID: <20171010202859.2d2f0865@endymion>
References: <20171010161115.2259-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756288AbdJJS3D (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 10 Oct 2017 14:29:03 -0400
In-Reply-To: <20171010161115.2259-1-ricardo.ribalda@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, 10 Oct 2017 18:11:15 +0200, Ricardo Ribalda Delgado wrote:
> SMBUS_BLOCK_DATA transactions might fail due to a race condition with
> the IMC (Integrated Micro Controller), even when the IMC semaphore
> is used.
> 
> This bug has been reported and confirmed by AMD, who suggested as a
> solution an IMC firmware upgrade (obtained via BIOS update) and
> disabling the IMC during SMBUS_BLOCK_DATA transactions.
> 
> Even without the IMC upgrade, the SMBUS is much more stable with this
> patch.
> 
> Tested on a Bettong-alike board.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> v3: Suggestions by Jean Delvare <jdelvare@suse.de>
> -Group booleans in struct i2c_piix4_adaptada
> (Sorry about that, I thought your concern was the space between the
>  new field and the rest)
> -Rename port regions
> -Rename definitions
> -Unify comment style
> 
> v2: Suggestions by Jean Delvare <jdelvare@suse.de>
> -Fix function definitions (static)
> -Add register definition
> -Use muxed_io interface
> -Improve comments
> -Keep old timeout
> -Rebase
> 
>  drivers/i2c/busses/i2c-piix4.c | 132 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 126 insertions(+), 6 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Great job, thanks Ricardo.

-- 
Jean Delvare
SUSE L3 Support
