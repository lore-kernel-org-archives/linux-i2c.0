From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] i2c: sun6-p2wi: fix call to snprintf
Date: Fri, 13 Jun 2014 10:57:14 +0100
Message-ID: <20140613095714.GP23430@n2100.arm.linux.org.uk>
References: <CAGXu5jLi5NXNsbUAn=XndDb2JSTxiVhMWbiMxtDsUOqZZhxf2A@mail.gmail.com> <1402644002-2591-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402644002-2591-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shuge <shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 13, 2014 at 09:20:02AM +0200, Boris BREZILLON wrote:
> -	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
> +	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), "%s",
> +		 pdev->name);

Isn't this just a complicated way to express:

	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));

?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
