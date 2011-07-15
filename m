From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/7] at91/i2c: move register header to drivers
Date: Fri, 15 Jul 2011 09:23:14 +0200
Message-ID: <20110715092314.215043d5@endymion.delvare>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-2-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310687525-22486-2-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean-Christophe,

On Fri, 15 Jul 2011 01:52:00 +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/i2c/busses/i2c-at91.c                      |    3 ++-
>  .../at91_twi.h => drivers/i2c/busses/i2c-at91.h    |    7 +++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/arm/mach-at91/include/mach/at91_twi.h => drivers/i2c/busses/i2c-at91.h (97%)

Why don't you just merge i2c-at91.h into i2c-at91.c then, if it's the
only user?

-- 
Jean Delvare
