From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: [PATCH] i2c-nomadik: fix kerneldoc warning
Date: Tue, 28 Jun 2011 07:25:25 +0200
Message-ID: <4E0965C5.30600@stericsson.com>
References: <1308134522-30858-1-git-send-email-linus.walleij@stericsson.com> <20110627220449.GB23027@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110627220449.GB23027-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 06/28/2011 12:04 AM, Ben Dooks wrote:
> On Wed, Jun 15, 2011 at 12:42:02PM +0200, Linus Walleij wrote:
>    
>> From: Linus Walleij<linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> There was a missing struct item in the kerneldoc, add it and fix
>> another pretty-printing formatting issue with a missing space.
>>      
> weird, it didn't apply to 3.0-rc4.
>    

In my topic branch I also have a patch from Srinidhi Kasagar
titled "i2c-nomadik: Do not use _interruptible_ variant call",
that went on the list some time back, could it be that you
missed that one?

If you want to I can resend it.

Thanks,
Linus Walleij
