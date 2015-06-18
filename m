From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Thu, 18 Jun 2015 11:32:23 +0200
Message-ID: <1434619943.2385.59.camel@x220>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
	 <1434531244.2069.111.camel@x220> <55818BAB.5090605@nokia.com>
	 <1434556990.2400.16.camel@x220> <558275F1.5020100@nokia.com>
	 <1434614901.2385.27.camel@x220> <5582899B.9030307@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5582899B.9030307-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2015-06-18 at 11:04 +0200, Alexander Sverdlin wrote:
> Maybe (and hopefully) there will never be a legacy user of this driver. But this macro
> is perfectly fine, adds no overhead (but modinfo)

(The test for any line of code is whether it adds value. Adding no
overhead is not adding value. That goes for one line macros too.)

>  and make the module "complete" in a
> sense that it supports both types of binding. There is a legacy probe function in it,
> all the support for legacy binding with platform_data in it and this modalias is simply
> the last part of it.

As I understand it, we've established that:
- this macro setups up udev, and modprobe, and friends, to listen to a
"MODALIAS=platform:i2c-mux-reg" message; and
- that there's currently no code in the kernel that will send out this
message.

Did I get that right? Because it follows from the above that this line
serves no purpose. Worse, it makes the code actually confusing. Because
it suggests the availability of functionality that in reality doesn't
exist.

Thanks,


Paul Bolle
