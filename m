From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client devices
Date: Thu, 12 Sep 2013 14:40:15 -0700
Message-ID: <CAGa+x85vxX8dbmk-8mOEQ03q6Ud1a-OfnV7t5-rNtu06vn_cSQ@mail.gmail.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
	<1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
	<87vc25pvvm.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87vc25pvvm.fsf-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 12, 2013 at 2:34 PM, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>
>> From: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> This patch adds runtime PM support for the I2C bus in a similar way that
>> has been done for PCI bus already. This means that the I2C bus core
>> prepares runtime PM for a client device just before a driver is about to be
>> bound to it. Devices that are not bound to any driver are not prepared for
>> runtime PM.
>>
>> In order to take advantage of this runtime PM support, the client device
>> driver needs drop the device runtime PM reference count by calling
>> pm_runtime_put() in its ->probe() callback and possibly implement rest of
>> the runtime PM callbacks.
>>
>> If the driver doesn't support runtime PM (like most of the existing I2C
>> client drivers), the device in question is regarded as being runtime PM
>> active and powered on.
>
> But for existing drivers which already support runtime PM (at least 7 by
> a quick grep), they will be stuck runtime enabled and stop hitting
> low-power states after this patch.

Oops, nevermind.  I was mixing this up with runtime PM on the i2c
adapter but this is for the i2c client.

Sorry for the noise.

Kevin
