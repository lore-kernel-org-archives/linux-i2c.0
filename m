From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drivers/i2c/i2c-smbus.c: convert kzalloc to
 devm_kzalloc
Date: Sat, 4 Aug 2012 21:43:05 +0200
Message-ID: <20120804214305.2c18b13a@endymion.delvare>
References: <1344100248-16238-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344100248-16238-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Julia,

On Sat,  4 Aug 2012 19:10:48 +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
> 
> Converting kzalloc to devm_kzalloc simplifies the code and ensures that the
> result, alert, is freed after the irq allocated by the subsequent
> devm_request_irq.  This in turn ensures that when an interrupt can be
> triggered, the alert structure is still available.

Good point. I honestly have no idea why this driver's resources are
half managed, it doesn't make much sense...

Patch applied, with a comment clarified, thanks.

-- 
Jean Delvare
