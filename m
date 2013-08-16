From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Fri, 16 Aug 2013 11:15:12 +0900
Message-ID: <520D8B30.9000602@pobox.com>
References: <20130710165634.GA30693@ab42.lan> <20130711073600.GG4898@intel.com> <20130711101330.GP4898@intel.com> <51DFB6C1.4040001@pobox.com> <20130712085140.GY4898@intel.com> <51E0E76B.1040304@pobox.com> <20130716111616.GA25835@ab42.lan> <51E6ACBE.7000509@pobox.com> <20130722131706.GA24081@ab42.lan> <51EFE550.1000507@pobox.com> <20130805093126.GE20936@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130805093126.GE20936-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 8/5/13 6:31 PM, Christian Ruppert wrote:> On Wed, Jul 24, 2013 at 11:31:44PM +0900, Shinya Kuribayashi wrote:
>> As said before, all t_SCL things should go away.  Please forget
>> about 100kbps, 400kbps, and so on.  Bus/clock speed is totally
>> pointless concept for the I2C bus systems.  For example, as long
>> as tr/tf, tHIGH/tLOW, tHD;STA, etc. are met by _all_ devices in a
>> certain I2C bus, it doesn't matter that the resulting clock speed
>> is, say 120 kbps with Standard-mode, or even 800 kbps for Fast-mode.
>> Nobody in the I2C bus doesn't care about actual bus/clock speed.
>>
>> We don't have to care about the resulting bus speed, or rather
>> we should/must not check to see if it's within the proper range.
>
> Actually, the I2C specification clearly defines f_SCL;max (and thus
> implies t_SCL;min), both in the tables and the timing diagrams. Why can
> we ignore this constraint while having to meet all the others?

If we meet t_r, t_f, t_HIGH, t_LOW (and t_HIGH in this DW case),
f_SCL;max will be met by itself.  And again, all I2C master and
slave devices in the bus don't care about f_SCL; what they do care
are t_f, t_r, t_HIGH, t_LOW, and so on.  That's why I'm saying
f_SCL is pointless and has no value for HCNT/LCNT calculations.

Is that clear?  What is the point to make sure whether f_SCL
constraint is met or not?  Is there any combination where t_f,
t_r, t_HIGH, t_LOW, t_HD;SATA are met, but f_SCL is out of range?
I don't think there is.

I'd make a compromise proposal; it's fine to make sure whether the
resulting f_SCL is within a supported range, but should not make a
correction of HCNT/LCNT values.  Just report warning messages that
some parameters/calculations might be mis-configured an/or wrong.

   Shinya
