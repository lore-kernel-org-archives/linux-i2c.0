From: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Date: Fri, 17 Jan 2014 07:57:24 +0100
Message-ID: <20140117065724.GR22080@phys.ethz.ch>
References: <20131217063226.GD25105@phys.ethz.ch>
 <20131217180131.GB2840@roeck-us.net>
 <20131217181053.GE7071@katana>
 <20131217195323.581143a8@endymion.delvare>
 <20140106123105.GN25105@phys.ethz.ch>
 <20140106140522.14e83454@endymion.delvare>
 <20140109162421.GF25105@phys.ethz.ch>
 <20140116124544.763415dd@endymion.delvare>
Reply-To: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140116124544.763415dd-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Jean,

thanks for your reply.

> The git history tells that there was no change to the i2c-piix4 driver
> since kernel version 3.12-rc1. This is when support for secondary SMBus
> on AMD SB800 and AMD FCH chipsets was added. I think FCH and Hudson-2
> are the same thing, not sure how Hudson-1 fits into the picture.
as far as I understand it, both Hudsons are FCHs in AMD speak.
It is very reasonable to assume that indeed 3.12-rc1 did add Hudson-1
support if that's when secondary SMBus support was introduced. I think it
was mainly this 2nd channel that was missing in the 'old' driver.

> Are you certain that the kernel version change fixed it? A BIOS update
> could have helped as well, or even just changing some BIOS settings.
nope, since the apu board has a very minimal BIOS and I didn't do anything in
this regard.

> If you are really sure that 3.13-rc3 didn't work and 3.13-rc7 does
> work, and you really want to understand why, then you can bisect the
> git kernel tree between both points and it'll point you to the commit
> that fixed it.
I thought so, but with the above it is very likely that it started working as
of 3.12-rc1 and I somehow missed it in 3.13-rc3. Unfortunately I can't check
now since the board is being used elsewhere.

> As for me, if things work for you now, I see no point in investigating
> further. As Wolfram already pointed out, your contribution came in a
I second this pragmatic approach. Goal was to add support and support we have.


> format we can't do anything with. The patch is huge, reversed, based on
> a source file which had indentation changes, mixes actual changes with
> (mostly unjustified) white-space changes, etc. If you ever need to get
> changes into the kernel, please follow the rules listed in
> Documentation/SubmittingPatches, otherwise nobody will review your
> work, no matter how needed you think it is.
I apologize. As stated before, I'm not the author of the patch and simply felt
not comfortable enough in the code to clean it up more than just make it
compile on a new kernel. Next time I'll try harder.

thanks for you work, we have support and are happy. I'll inform the author of
the patch.

cheers,
-Christian


-- 
Dr. Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>  support: +41 44 633 26 68
IT Services Group, HPT H 8                    voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://nic.phys.ethz.ch/
