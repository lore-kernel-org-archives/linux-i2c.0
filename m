From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: i2c-mux-gpio: Use devm_kzalloc instead of
 kzalloc
Date: Sat, 6 Oct 2012 15:10:28 +0200
Message-ID: <20121006151028.3c9fbd53@endymion.delvare>
References: <1348758784-15245-1-git-send-email-maxime.ripard@free-electrons.com>
	<1348758784-15245-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348758784-15245-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 27 Sep 2012 17:13:02 +0200, Maxime Ripard wrote:
> Use the devm_kzalloc managed function to stripdown the error and remove
> code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-gpio.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> (...)

Note: I ended up applying this patch (it's on its way to Linus already)
because it did conflict with another patch in my tree. So only patches
2/3 and 3/3 in this series are left for Wolfram to handle.

-- 
Jean Delvare
