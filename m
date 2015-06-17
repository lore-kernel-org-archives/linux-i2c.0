From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Wed, 17 Jun 2015 18:03:10 +0200
Message-ID: <1434556990.2400.16.camel@x220>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
	 <1434531244.2069.111.camel@x220> <55818BAB.5090605@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55818BAB.5090605-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-06-17 at 17:00 +0200, Alexander Sverdlin wrote:
> You do not see the platform_device, because there are no users yet, put
> this MODULE_ALIAS() is perfectly fine, it will allow automatic module loading
> in non-DT case.

Do you mean that it will allow automatic module loading once the patch
that adds a struct platform_device with a "i2c-mux-reg" name lands?


Paul Bolle
