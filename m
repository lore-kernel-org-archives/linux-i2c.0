From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected
 to SMBus adapters
Date: Thu, 19 Mar 2015 06:30:14 -0700
Message-ID: <550ACF66.5070208@roeck-us.net>
References: <20150204190819.GA15467@roeck-us.net> <20150204233516.GA1677@katana> <20150205002630.GA396@roeck-us.net> <20150205144028.GA4865@katana> <20150205175326.GA26691@roeck-us.net> <20150212040126.GA1691@roeck-us.net> <20150216120951.GA2840@katana> <20150317042049.GA6765@roeck-us.net> <20150318132707.GD3580@katana> <550A4162.8000009@roeck-us.net> <20150319081612.GA900@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150319081612.GA900@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/19/2015 01:16 AM, Wolfram Sang wrote:
>
>> I don't call that multi-master, though, so I guess we may have a bit of a
>> terminology problem.
>
> This is definately not a multi-master issue, I agree. It is just
> another issue I saw when thinking about your patch thoroughly again.
>
>> I'll see what I can come up with, but I am not sure if I'll find the time
>> before the 4.1 commit window opens. Company has a working solution (kind of),
>> so now I'll have to do this on my own time ;-).
>
> But their solution is buggy and needs a fix! :)
>
I ended up looking into this last night, and actually have some untested code.

However, looking through the kernel, the problem it solves turns out to be
wide-spread. Almost every caller of i2c_smbus_read_byte() does the call as
part of a call sequence, and thus has that very same problem. That includes,
for example, the max1363 and the ds2482 drivers, both of which are used
in our system. So, while the solution may be buggy, that bug is wide-spread
and no one really seems to care about it (or did not realize it). This gives
"needs a fix" a completely different scope.

Given that, I may spend some time trying to see if I can reproduce the problem
before trying to fix it.

Thanks,
Guenter
