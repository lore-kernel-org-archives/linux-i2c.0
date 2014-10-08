From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH v6 2/4] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Wed, 8 Oct 2014 14:07:53 +0300
Message-ID: <CAE1zot+SffBoD8hrpr1xyzJ+cCtmFCjb_vRYAHR4GgKKANdQRQ@mail.gmail.com>
References: <1411661254-5204-1-git-send-email-octavian.purdila@intel.com>
	<1411661254-5204-3-git-send-email-octavian.purdila@intel.com>
	<20141008104214.GD1990@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141008104214.GD1990@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 8, 2014 at 1:42 PM, Johan Hovold <johan@kernel.org> wrote:
> On Thu, Sep 25, 2014 at 07:07:32PM +0300, Octavian Purdila wrote:
>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-busses-dln2 b/Documentation/ABI/testing/sysfs-bus-i2c-busses-dln2
>> new file mode 100644
>> index 0000000..ad55af6
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-i2c-busses-dln2
>
> This is a nonstandard path that does not match the attribute path (or
> any other convention followed under ABI/).
>
> I suggest you rename it
>
>         sysfs-class-i2c-adapter-dln2
>
>> @@ -0,0 +1,5 @@
>> +What:                /sys/bus/i2c/devices/.../dln2_i2c_freq
>
> I think you should rename the attribute "bus_frequency" and name the
> attribute group "dln2". That way the attribute will show up as
>
>         .../<device>/dln2/bus_frequency
>
> Then the "What:" field should read
>
>         What:           /sys/class/i2c-adapter/<device>/dln2/bus_frequency
>
>> +Date:                September 2014
>> +Contact:     Octavian Purdila <octavian.purdila@intel.com>
>> +Description:
>> +             This attribute shows/sets the frequency (in Hz) of the I2C bus.
>
> I'd reword this "Set the frequency...".
>
> Please also describe under what circumstances this may fail, that is,
> when setting a frequency less than or greater than the min or max
> frequencies reported by the device.
>
> Perhaps you should even consider exporting those two values?
>

I noticed that a few other USB boards support this. Perhaps it is time
to add these entries to the core i2c layer?

In that case I think is better to remove the setting and update the
drievr when the patches for the i2c layer are ready?
