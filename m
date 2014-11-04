From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Tue, 04 Nov 2014 06:16:37 -0800
Message-ID: <5458DFC5.1010101@roeck-us.net>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de> <20141103205534.GA18937@roeck-us.net> <20141103210200.GA6242@katana> <20141103221850.GA16026@roeck-us.net> <20141104073306.GB1887@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141104073306.GB1887@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/03/2014 11:33 PM, Wolfram Sang wrote:
>>> What is your muxing setup?
>>>
>> Complicated ;-).
>
> ...
>
> Ooooookay... well, for testing these patches, your setup is absolutely
> awesome, of course :D May I ask what you are doing with that amount of
> I2C?
>

The HW folks are trying to have one bus per device. So a card with 48x10GE
needs 48 I2C busses, plus one or more busses for its other devices.

Some of the HW tends to block its I2C bus if looked at in a wrong way,
so that isn't actually too bad. The bus master selectors let either
one of the main controller CPUs or the CPU on a line card have access
to the bus.

Guenter
