From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V2] at24: use timeout also for read
Date: Wed, 25 Nov 2009 11:24:04 +0100
Message-ID: <20091125112404.35ff7f57@hyperion.delvare>
References: <20091122210846.14666e23@hyperion.delvare>
	<1259141876-15458-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259141876-15458-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 25 Nov 2009 10:37:56 +0100, Wolfram Sang wrote:
> Writes may take some time on EEPROMs, so for consecutive writes, we already
> have a loop waiting for the EEPROM to become ready. Use such a loop for reads,
> too, in case somebody wants to immediately read after a write. Detailed bug
> report and test case can be found here:
> 
> http://article.gmane.org/gmane.linux.drivers.i2c/4660
> 
> Reported-by: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Tested-by: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> I could reproduce the errornous behaviour and this patch fixes it for me.
> 
> Jean, you can use this version or modify V1 yourself. Whatever is faster/easier
> for you.
> 
> Changes since V1:
> 
> - Use return value from i2c_smbus_read_i2c_block_data() directly as it returns the
>   number of bytes transferred.
> 
>  drivers/misc/eeprom/at24.c |   76 ++++++++++++++++++++++++++------------------
>  1 files changed, 45 insertions(+), 31 deletions(-)

Thanks. Patch applied, I'll prepare a pull request for Linus later
today.

-- 
Jean Delvare
