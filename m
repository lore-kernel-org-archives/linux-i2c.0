From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND/PATCH] i2c: pxa: Use suspend() and resume() instead of the _noirq hooks
Date: Wed, 22 Oct 2014 17:25:02 -0700
Message-ID: <7hzjcnaazl.fsf@deeprootsystems.com>
References: <1413829432-7815-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<7hzjcqe9ge.fsf@deeprootsystems.com>
	<54482EB1.9030407@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54482EB1.9030407-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> (Ezequiel Garcia's
	message of "Wed, 22 Oct 2014 19:24:49 -0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> writes:

> On 10/20/2014 06:07 PM, Kevin Hilman wrote:
>> Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> writes:
>> 
>>> The _noirq were previously chosen to make sure all the users of the
>>> adapter were suspended by the time the adapter itself enters the
>>> suspended state.
>>>
>>> The {suspend,resume}_noirq usage was converted from an earlier
>>> implementation based on suspend_late and resume_early on this commit:
>>>
>>> commit 57f4d4f1b72983f8c76e2f232e064730aeffe599
>>> Author: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
>>> Date:   Wed Jul 8 13:22:39 2009 +0200
>>>
>>>     I2C: Rework i2c-pxa suspend_late()/resume_early()
>>>
>>> However, all the I2C devices are probed as children of its I2C adapter,
>>> and hence the device model guarantees they are suspended before its parent, and
>>> resumed after it.
>>>
>>> In other words, there's no need to use the _noirq hooks to get a suspend/resume
>>> device/adapter order.
>> 
>> Are you sure *really* about this?
>> 
>
> Hm, now you made me doubt.

Good. :)

>> It's usally not the children that are the problem here.  It's usually
>> some other driver trying to use an I2C device e.g. MMC changing voltage
>> using an I2C-based PMIC during its suspend process.
>> 
>
> So we can't know for sure if using suspend/resume is going to work OK for
> a I2C adapter?
>
> There might be some use of it that can't be accurately modeled in the
> device model.

Correct.

> I.e., the above example is a dependency of MMC on the I2C being suspended
> after him, but right now there's no way to model such relationship.

That's right.  That's why many i2c drivers are using the late/early
callbacks for suspend/resume.

suspend/resume order depends on probe ordering, so with deferred probe,
the probe ordering might be right, but it should be thoroughly tested.

Kevin
