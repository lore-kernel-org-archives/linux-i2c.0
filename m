From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Wed, 17 Jun 2015 17:00:59 +0200
Message-ID: <55818BAB.5090605@nokia.com>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
 <1434531244.2069.111.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434531244.2069.111.camel@x220>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 17/06/15 10:54, ext Paul Bolle wrote:
>> +MODULE_ALIAS("platform:i2c-mux-reg");
> As far as I understand it, this alias is only useful if there's a
> corresponding struct platform_device, somewhere. Ie, this alias needs a
> platform_device that will fire of a "MODALIAS=platform:i2c-mux-reg"
> uevent when it's created. (I don't know exactly how all that works, so
> I'm handwaving quite a bit here.) That would be platform_device with a
> "i2c-mux-reg" name.
> 
> Did I get this right? Because then I think this MODULE_ALIAS() isn't
> needed, as I couldn't find such a corresponding platform_device.

You do not see the platform_device, because there are no users yet, put
this MODULE_ALIAS() is perfectly fine, it will allow automatic module loading
in non-DT case.

-- 
Best regards,
Alexander Sverdlin.
