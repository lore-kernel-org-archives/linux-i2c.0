From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Thu, 18 Jun 2015 09:58:22 +0200
Message-ID: <55827A1E.4020608@nokia.com>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
 <55818C3C.8000704@nokia.com> <5581A3CA.4050805@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5581A3CA.4050805-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello!

On 17/06/15 18:43, ext York Sun wrote:
>> > Yeah, this is really bad idea. You maybe want something like
>> > __iomem "cookie" here instead of this bare pointer.
> Let me try.
> 

Could you think about different access widths, please?
Not all buses are 32-bits wide and even on 64-bit CPUs one might have 16-bit bus
and 32 bits accesses are not allowed or perform two accesses, etc...

So to cover the use-cases which I see one needs to have a possibility to select between
__raw_writeb()/__raw_writew()/__raw_writel()/__raw_writeq() (now that I'm thinking about
it, I think these native-Endianness functions are preferred and if one has a bus with
different Endianness he should think about the conversion in the reg property of subnodes).

Very important is readback with corresponding __raw_read*(), but maybe you want to do
this optional via additional DT property...

-- 
Best regards,
Alexander Sverdlin.
