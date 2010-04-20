From: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
Subject: Re: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
Date: Tue, 20 Apr 2010 10:27:00 +0200
Message-ID: <8d2bff4f5c4178f89e410edc702cd18f@localhost>
References: <20100412213235.1688dda8@hyperion.delvare> <1271591309-22567-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1271591309-22567-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Sun, 18 Apr 2010 13:48:29 +0200, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
wrote:
> The timeout value is in jiffies, so it should be using HZ, not a plain
> number. Assume with HZ=100 '100' means 1s here and adapt accordingly.
> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
> Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Acked-by: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>

Eric, can you merge this directly via your -devel branch?

Thanks,

        M.
-- 
Who you jivin' with that Cosmik Debris?
