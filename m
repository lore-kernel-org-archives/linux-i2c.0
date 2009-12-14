From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 07/12] i2cdev: move compat_ioctl handling into driver
Date: Mon, 14 Dec 2009 15:23:07 +0100
Message-ID: <20091214152307.5ba3ea4d@hyperion.delvare>
References: <1258331227-1694-1-git-send-email-arnd@arndb.de>
	<1258331227-1694-8-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1258331227-1694-8-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

On Mon, 16 Nov 2009 00:27:02 +0000, Arnd Bergmann wrote:
> Doing all the compat_ioctl handling in the i2c driver itself
> removes special cases from fs/compat_ioctl.c and makes it possible
> to optimize this case better.
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/i2c/i2c-dev.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/compat_ioctl.c     |  119 -------------------------------------------------
>  2 files changed, 117 insertions(+), 119 deletions(-)

This patch no longer applies so I can't test it. I do not have any
objection about it though.

I'm also not sure what I am supposed to comment on. As far as I can
see, most of this patch is merely moving code from one file to another,
so there's little point in reviewing that code. Is there any part in
particular which needs my attention?

If you want to test your patch yourself, it is fairly easy using the
i2c-stub driver, which is a software-only i2c bus driver. Install the
i2c-tools package on your system, and then:

# modprobe i2c-stub chip_addr=0x6d
# modprobe i2c-dev
# i2cdetect -l
# i2cbus=$(i2cdetect -l | grep stub | cut -f1 | cut -d- -f2)
# i2cdetect -F $i2cbus
Functionalities implemented by /dev/i2c-x:
I2C                              no
SMBus Quick Command              yes
SMBus Send Byte                  yes
SMBus Receive Byte               yes
SMBus Write Byte                 yes
SMBus Read Byte                  yes
SMBus Write Word                 yes
SMBus Read Word                  yes
SMBus Process Call               no
SMBus Block Write                no
SMBus Block Read                 no
SMBus Block Process Call         no
SMBus PEC                        no
I2C Block Write                  no
I2C Block Read                   no
# i2cset -y $i2cbus 0x6d 0x00 0x42 b
Value 0x42 written, readback matched
# i2cget -y $i2cbus 0x6d 0x00 b
0x42
#

The last 3 commands will generate i2c-dev ioctls.

-- 
Jean Delvare
