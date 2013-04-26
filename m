From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Status of I2C mac-drivers needing attach_adapter?
Date: Fri, 26 Apr 2013 17:31:00 +0200
Message-ID: <20130426153100.GA3104@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

because I will push a patch to get rid of detach_adapter() from the I2C
core in the next merge window, I was curious to find out about the
status of attach_adapter().

I found commit 6cd3209967469f6e89d329deda6bb0b4700e7b62
(powerpc/powermac: New windfarm driver for PowerMac G5 (AGP) and Xserve
G5) which should get rid of therm_pm72 if I understand correctly? Or is
it still needed? Can you give me an overview if there is/was progress
regarding the other two drivers therm_windtunnel and sound/ppc/keywest?

Thanks,

   Wolfram
