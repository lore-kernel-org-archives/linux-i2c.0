From: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [RFC] i2c: designware: Avoid initcall and initialize the driver
 like a regular one
Date: Tue, 23 Dec 2014 09:53:20 -0300
Message-ID: <CABxpGwDMY7T1OuHmLU4EmuBAyE_SCS-GTa=EeSGjZ976N1K9-g@mail.gmail.com>
References: <1419272149-28716-1-git-send-email-walter@vanguardiasur.com.ar>
	<20141222190233.GA1014@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141222190233.GA1014@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 22, 2014 at 4:02 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Dec 22, 2014 at 03:15:49PM -0300, Walter Lozano wrote:
>> Currently, the driver is relying on a subsys_initcall() to register
>> the platform driver struct. This is typically done to allow early uses
>> of the I2C bus (for instance, I2C regulators used from early machine code).
>>
>> While this might work on some cases, it breaks on others. For instance,
>> I2C devices with GPIO-wired interrupts will fail to request the
>> interrupt because of this initcall usage.
>>
>> This commits attempts to fix the above issue, by converting the I2C
>> driver into a regular kernel platform driver. This guarantees it will
>> probe after GPIOs drivers.
>>
>> Platforms based on devicetree won't be affected by this change.
>
> Huh, why is that?
>
>> Legacy platforms, relying on the I2C being available early, might need
>> to implement proper defered mechanisms to overcome potential problems.
>
> NAK. We can't say "Let's cause a regression to force people to fix
> things that used to work" IMO. You exactly pointed out the problem that using
> subsys_initcall() creates.
>
> What about fixing the drivers you use to support deferred probing when
> acquitin the irq?

Yes, probably it is the best approach to avoid possible issues with
other drivers.
I'll check your suggestion.

Thanks for your comments.

Regards,

Walter

-- 
Walter Lozano, VanguardiaSur
www.vanguardiasur.com.ar
