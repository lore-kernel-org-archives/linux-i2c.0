From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: clock driver
Date: Wed, 27 May 2015 16:08:12 -0700
Message-ID: <55664E5C.3000903@roeck-us.net>
References: <5564C58B.9050400@freescale.com> <20150526223829.GA26454@roeck-us.net> <55650DBA.5000304@freescale.com> <5565108D.2020502@freescale.com> <20150527173055.22384.74368@quantum> <556602BC.6040203@freescale.com> <20150527181521.GA19448@roeck-us.net> <55660BF2.6000002@freescale.com> <20150527185442.GA6607@roeck-us.net> <556613CE.8020906@freescale.com> <14d96cd6d64.f62a1a09739217.9114963256886461171@elphel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <14d96cd6d64.f62a1a09739217.9114963256886461171-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andrey <andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org>, Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org, York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 05/27/2015 12:44 PM, andrey wrote:
> Hello all,
> Let me add a comment on using sysfs to simplify user space access to the clock features as opposed to controlling them from a driver that uses the clock chip driver.
>
> It is common to use such advanced clock chips with the FPGA devices (as me and York do), and a lot of development (HDL code) is done before a fancy higher-level driver is even started. And it is not just a temporary stage needed by a small minority of developers - as HDL coding gets more to the the core of many new devices running Linux kernel, it makes sense to create the chip drivers more developer-friendly, not just for the final use in a higher level device driver - modification of the HDL code (most modern FPGA are programmed at runtime) makes it a new device that may need a new driver.
> I'm sure that it is not just for me, when it starts with the chip driver that supports low-level functionality exposing it to the user space, and then working on the HDL code using Python scripts at that stage. And only later in the development designing the higher level device drivers that may not need all of the chip functionality. And such higher level driver will work for our systems, but other developers who work on their embedded systems will again need access to low level chip functionality, and will have to redo the same work all over again. This I believe is a rationale of exposing such chip-specific hardware features (not all of them are probably easy to fit into a specific standard model) to the user space scrtipts.
>
> I wrote the initial driver code for our system ( https://github.com/Elphel/linux-elphel/blob/master/src/drivers/misc/si5338.c ) and being very far from being a kernel developer myself (I'm more of a hardware guy) I didn't even try to satisfy the required coding style and submit it, so I'm very thankful to York who re-wrote the code and is trying to make it usable to others.
>

Line wraps at ~75 columns would make this a bet easier to read.

A more generic solution to your problem might be to implement a driver
similar to i2c-dev, which exports raw i2c device information to user space.
In your case, you would export information about the clocks in the system,
possibly through sysfs (i2c-dev uses ioctl which is a bit old-fashioned).

This would be a driver independent solution, and work for all clock drivers.
It might still not be accepted by Mike and Stephen, due to the risk, but it
might be worth a try. After all, using i2c-dev to access i2c devices directly
is just as risky.

In my opinion, it is always better to have a driver in the upstream kernel,
if possible one that uses a standard framework. That makes it much easier
to support going forward.

Guenter
