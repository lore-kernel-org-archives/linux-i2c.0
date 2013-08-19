From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Mon, 19 Aug 2013 21:22:46 +0900
Message-ID: <52120E16.8010503@pobox.com>
References: <20130711101330.GP4898@intel.com> <51DFB6C1.4040001@pobox.com> <20130712085140.GY4898@intel.com> <51E0E76B.1040304@pobox.com> <20130716111616.GA25835@ab42.lan> <51E6ACBE.7000509@pobox.com> <20130722131706.GA24081@ab42.lan> <51EFE550.1000507@pobox.com> <20130805093126.GE20936@ab42.lan> <520D8B30.9000602@pobox.com> <20130819113604.GN4898@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130819113604.GN4898-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 8/19/13 8:36 PM, Mika Westerberg wrote:
> On Fri, Aug 16, 2013 at 11:15:12AM +0900, Shinya Kuribayashi wrote:
>>> Actually, the I2C specification clearly defines f_SCL;max (and thus
>>> implies t_SCL;min), both in the tables and the timing diagrams. Why can
>>> we ignore this constraint while having to meet all the others?
>>
>> If we meet t_r, t_f, t_HIGH, t_LOW (and t_HIGH in this DW case),
>> f_SCL;max will be met by itself.  And again, all I2C master and
>> slave devices in the bus don't care about f_SCL; what they do care
>> are t_f, t_r, t_HIGH, t_LOW, and so on.  That's why I'm saying
>> f_SCL is pointless and has no value for HCNT/LCNT calculations.
>
> One thing that comes to mind regarding the bus speed is that even if we
> have all the minimal timing requirements met we still prefer resulting bus
> speeds closer to 400kHz than 315.41kHz for the reasons that we get more
> data transferred that way, no?

That depends I2C slave devices in the bus in your target systems.
As long as your slave devices can detect START/STOP conditions and
recognize SDA/SCL transitions properly, that should be Ok (you can
use HCNT/LCNT settings for 400 kHz without having all the minimal
timing requirements met).

My comments above was a reply to Christian's snippet code and how to
treat f_SCL;mas constraints, and unrelated to your case in question.
I'm for having a way to override HCNT/LCNT values as said before, and
that should nicely work for you.

   Shinya
