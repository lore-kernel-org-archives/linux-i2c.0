From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v4] i2c: Add device tree support to i2c-pnx.c
Date: Fri, 20 Apr 2012 09:53:47 +0200
Message-ID: <4F91160B.5070802@antcom.de>
References: <1334850612-24151-1-git-send-email-stigge@antcom.de> <20120419160715.GD24987@pengutronix.de> <4F903E0C.6010604@antcom.de> <20120419203915.GB28005@pengutronix.de> <4F90812F.5090106@antcom.de> <20120420072811.GA9769@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120420072811.GA9769-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/20/2012 09:28 AM, Wolfram Sang wrote:
>> Another solution would be to not use timeout with the dt enabled 
>> i2c-pnx for now (using the hard coded default timeout as the
>> current i2c-pnx.c does) and possibly introduce the (anyway
>> optional) "timeout" later.
> 
> Yeah, let's do it like this.

Good, will do!

>> Interesting! When the documentation is outdated - how does the
>> parser actually decide between hex (e.g. regs/addresses) and dec
>> (e.g. clock-frequency) in the absence of "0x"?
> 
> Are there regs without 0x?

Lots of, in Documentation/devicetree/booting-without-of.txt ;-)
Admittedly, not in arch/arm/boot/dts/*...

I would like to clarify the hex/dec issue and the various examples to
prevent confusion of others. Will post a patch.

Roland
