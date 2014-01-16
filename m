From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Date: Thu, 16 Jan 2014 12:45:44 +0100
Message-ID: <20140116124544.763415dd@endymion.delvare>
References: <20131217063226.GD25105@phys.ethz.ch>
	<20131217180131.GB2840@roeck-us.net>
	<20131217181053.GE7071@katana>
	<20131217195323.581143a8@endymion.delvare>
	<20140106123105.GN25105@phys.ethz.ch>
	<20140106140522.14e83454@endymion.delvare>
	<20140109162421.GF25105@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140109162421.GF25105-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Christian,

On Thu, 9 Jan 2014 17:24:22 +0100, Christian Herzog wrote:
> sorry to bother you again, but this might save you some work: I just compiled
> 3.13.0-rc7 on the apu board and i2c works out of the box. I'm pretty stumped
> as I'm pretty sure it didn't work OOTB on -rc3, but now it does.. Are you
> aware of any Hudson-1 specific changes recently?

I am not aware of anything related to Hudson-1. I don't even know the
PCI IDs for that device.

The git history tells that there was no change to the i2c-piix4 driver
since kernel version 3.12-rc1. This is when support for secondary SMBus
on AMD SB800 and AMD FCH chipsets was added. I think FCH and Hudson-2
are the same thing, not sure how Hudson-1 fits into the picture.

Are you certain that the kernel version change fixed it? A BIOS update
could have helped as well, or even just changing some BIOS settings.

Another possibility is that some PCI or architecture quirk was added
meanwhile. However a quick search did not reveal anything between
3.13-rc3 and 3.13-rc7.

If you are really sure that 3.13-rc3 didn't work and 3.13-rc7 does
work, and you really want to understand why, then you can bisect the
git kernel tree between both points and it'll point you to the commit
that fixed it.

As for me, if things work for you now, I see no point in investigating
further. As Wolfram already pointed out, your contribution came in a
format we can't do anything with. The patch is huge, reversed, based on
a source file which had indentation changes, mixes actual changes with
(mostly unjustified) white-space changes, etc. If you ever need to get
changes into the kernel, please follow the rules listed in
Documentation/SubmittingPatches, otherwise nobody will review your
work, no matter how needed you think it is.

-- 
Jean Delvare
