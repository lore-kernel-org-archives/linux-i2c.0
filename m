From: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 8 Jan 2010 14:43:39 +0100
Message-ID: <20100108134339.GE4004@radix50.net>
References: <20100108020253.GJ3388@radix50.net> <4B471647.8050806@scram.de> <20100108121723.GD4004@radix50.net> <4B4726CF.9020605@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B4726CF.9020605-NIgtFMG+Po8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 08, 2010 at 01:36:31PM +0100, Jochen Friedrich wrote:
>> How did it work in 2.6.25.7?
>
> It was probably probed by some userspace tool.

Nope, it worked directly after booting. The initialization sequence
looked like this:

w1_add_master_device
ds2482_attach_adapter
i2c_register_driver
sensors_ds2482_init
kernel_init
kernel_thread


> This has been turned off as probing i2c might be problematic on Soc
> boards. See:
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D0a346dacee18ff69f6162d9860d723a058f47321
>
> You could try to add the property "linux,i2c-class=3D1" to the i2c=20
> controller in your dts to see if this commit is the cause of differen=
ce.

I've added "linux,i2c-class =3D <1>;" to i2c@860; this has set i2c-cpm'=
s
class to I2C_CLASS_HWMON. You are probably right in that the problem
seems to be partly related to that.

That said, the default class of i2c-cpm is I2C_CLASS_HWMON |
I2C_CLASS_SPD, whereas the one of ds2482 is not set and thus zero (I'm
using 2.6.27.25), so if (!(adapter->class & driver->class)) in
i2c_detect goes to exit_free. So yesterday I had to set ds2482's class
to I2C_CLASS_SPD since the classes have to match.

However, it still goes to exit_free immediately after that since ds2482
doesn't provide I2C_FUNC_SMBUS_QUICK. IIUC, drivers are not required to
provide that, so I'm still looking why cpm_i2c_probe and ds2482_probe
don't get called.


> You should definitely add your ds2482 to the device tree so it is aut=
o
> loaded by the i2c subsystem.

You mean, in dts? Do you have a template for that? I could look up the
necessary values in the working 2.6.25.7 kernel if I knew which ones I
need. Which routine reads it and calls probe?


Gru=DF,
Baurzhan.
