From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c/at91: adopt pinctrl support
Date: Mon, 20 Oct 2014 11:17:43 -0700
Message-ID: <7h4muyfvw8.fsf@deeprootsystems.com>
References: <1413776535-10123-1-git-send-email-wenyou.yang@atmel.com>
	<1413776535-10123-4-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413776535-10123-4-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> (Wenyou
	Yang's message of "Mon, 20 Oct 2014 11:42:14 +0800")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

> Amend the i2c at91 pin controller to optionally take a pin control
> handle and set the state of the pins to:
>
> - "default" on boot, resume and before performing an transfer
> - "sleep" on suspend()
>
> This should make it possible to optimize energy usage for the pins
> both for the suspend/resume cycle
>
> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

This patch is a good example of why you should just have the ->suspend
function call the same function as ->runtime_suspend.

If you do that, rather than having to add the pinctrl_pm* calls bo both
system PM and runtime PM functions, you could've just added them to the
runtime PM functions.

Kevin
