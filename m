From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 07/12] i2cdev: move compat_ioctl handling into driver
Date: Mon, 14 Dec 2009 16:31:45 +0100
Message-ID: <200912141631.46300.arnd@arndb.de>
References: <1258331227-1694-1-git-send-email-arnd@arndb.de> <1258331227-1694-8-git-send-email-arnd@arndb.de> <20091214152307.5ba3ea4d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091214152307.5ba3ea4d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 14 December 2009, Jean Delvare wrote:
> This patch no longer applies so I can't test it. I do not have any
> objection about it though.

The patch is part of a longer series of patches moving code out
of fs/compat_ioctl.c. If you want to test it, you can just apply the
half adding it to i2c-dev.c and that version will be used.

That part has gained a trivial conflict against an #include cleanup.

> I'm also not sure what I am supposed to comment on. As far as I can
> see, most of this patch is merely moving code from one file to another,
> so there's little point in reviewing that code. Is there any part in
> particular which needs my attention?

No, nothing particular. I was just running the whole series by the
maintainers (or the closest approximation of that) in order to
collect Acked-by and/or have people include the patches in their
trees, especially the ones that I didn't have a test case for.
The patches I got an Ack for were merged now, and I'll repost
the rest after -rc1 to prepare them for the next merge window.

A good way to avoid conflicts would be if you take the i2c-dev.c
parts into a tree of yours and let me follow up with removing the
code from fs/compat_ioctl.c once your tree is merged.

If everyone does that, I can just remove half of fs/compat_ioctl.c
at once.

> If you want to test your patch yourself, it is fairly easy using the
> i2c-stub driver, which is a software-only i2c bus driver. Install the
> i2c-tools package on your system, and then:
> 
> # modprobe i2c-stub chip_addr=0x6d
> # modprobe i2c-dev
> # i2cdetect -l
> # i2cbus=$(i2cdetect -l | grep stub | cut -f1 | cut -d- -f2)
> # i2cdetect -F $i2cbus
> Functionalities implemented by /dev/i2c-x:
> I2C                              no
> SMBus Quick Command              yes
> SMBus Send Byte                  yes
> SMBus Receive Byte               yes
> SMBus Write Byte                 yes
> SMBus Read Byte                  yes
> SMBus Write Word                 yes
> SMBus Read Word                  yes
> SMBus Process Call               no
> SMBus Block Write                no
> SMBus Block Read                 no
> SMBus Block Process Call         no
> SMBus PEC                        no
> I2C Block Write                  no
> I2C Block Read                   no
> # i2cset -y $i2cbus 0x6d 0x00 0x42 b
> Value 0x42 written, readback matched
> # i2cget -y $i2cbus 0x6d 0x00 b
> 0x42
> #
> 
> The last 3 commands will generate i2c-dev ioctls.

Ok, I'll try that, thanks!

	Arnd <><
