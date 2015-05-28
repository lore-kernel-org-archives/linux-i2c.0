From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: clock driver
Date: Thu, 28 May 2015 08:24:24 -0700
Message-ID: <55673328.5050206@freescale.com>
References: <5564C58B.9050400@freescale.com> <20150527181521.GA19448@roeck-us.net> <55660BF2.6000002@freescale.com> <20150527185442.GA6607@roeck-us.net> <556613CE.8020906@freescale.com> <14d96cd6d64.f62a1a09739217.9114963256886461171@elphel.com> <55664E5C.3000903@roeck-us.net> <14d97d05f05.c0c23a8c778110.9087956443203424916@elphel.com> <55665CDE.7060601@roeck-us.net> <14d97ec12ae.121e65c4b780118.1307005790953163680@elphel.com> <20150528061121.22384.20782@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150528061121.22384.20782@quantum>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, andrey <andrey-MoRZu3FOBbXQT0dZR+AlfA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 05/27/2015 11:11 PM, Michael Turquette wrote:

<snip>

> 
> Hi Andrey,
> 
> I think this is a cool problem to solve. As far as frontier devices go I
> really can't say. Other companies create similar clock generators that
> are programmed at run-time over i2c. And we already have support merged
> for Silicon Labs 5351 and 570 devices:
> 
> 	drivers/clk/clk-si5351.c
> 	drivers/clk/clk-si5351.h
> 	drivers/clk/clk-si570.c
> 
> I'm not sure that we need to group such devices into a new "class". The
> Linux common clock framework (ccf) has two classes: clock providers and
> clock consumers. We haven't needed any more classification than that
> thus far.
> 
> I took a look at your github code and it looks like you expose registers
> individually as sysfs files. That is a start, but a better abstraction
> is to consider the clock input signals that your pcie/fpga device will
> take as input. With a proper clock driver for the silabs part your
> pcie/fpga driver could hopefully just call clk_prepare_enable and
> clk_set_rate and clk_set_parent as needed on those clocks to configure
> them for consumption by the downstream fpga.
> 
> According to the data sheet[0] it looks like there are not many clock
> outputs (CLK0{A,B}, CLK1{A,B}, CLK2{A,B}, and CLK3{A,B}).
> 
> At what point do you know how the clocks should be configured? I am
> guessing that your fpga driver (e.g. the clock consumer) figures that
> out as bytestream blobs are loaded? So that seems like the right call
> site to start enabling clocks and configuring rates, instead of stuffing
> that into the silabs driver (e.g. the clock provider).

I think it works for my case. I will explore this direction.

> 
> York,
> 
> There is already a way to clock drivers to extend the debugfs interfaces
> for per-driver stuff. The Nvidia Tegra guys do this already in their
> out-of-tree test modules. Do you think such an interface might be
> helpful to you? See:
> 
> clk_debugfs_add_file in drivers/clk/clk.c
> and,
> http://lkml.kernel.org/r/<1403794853-16928-1-git-send-email-pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> So your silabs clock generator driver could export some custom knobs
> which help out in the early phases of development.
> 
> Ideally this interface would not be a register-level interface, but an
> output signal type interface. Here is an example of the files you will
> have by default:
> 
> $ ls /sys/kernel/debug/clk/clk0a/
> clk_accuracy      clk_flags           clk_phase          clk_rate
> clk_enable_count  clk_notifier_count  clk_prepare_count
> 
> With the custom debugfs interface you might add a "clk_set_rate" file
> where user space can write to it and change the frequency of that clock
> signal. You can do the same to change mux settings and clock gates as
> well.
> 
> A userspace tool might even be able to take the clockbuilder data to do
> this, if someone is willing to write it.
> 
> [0] https://www.silabs.com/Support%20Documents/TechnicalDocs/Si5338.pdf

Thanks for the suggestion. I think I can limit the features of this clock chip
and fit it into CCF. Earlier I thought too much about exposing all features for
general use, which shouldn't be the case for the clocks. I will see if I can
remove those features or reserve them for debug use.

York
