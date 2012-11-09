From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: fix compilation issue due to header move
Date: Fri, 09 Nov 2012 16:51:44 +0400
Message-ID: <509CFC60.6000203@mvista.com>
References: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352455900-21074-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 09-11-2012 14:11, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:

> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> arch/arm/mach-at91/include/mach/at_hdmac.h has been move to
> include/linux/platform_data/dma-atmel.h, commit 7cdc39e.

    Need to also specify that commit's summary in parens.

> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

WBR, Sergei
