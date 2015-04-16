From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] i2c: rework last users of 2.4 style attach_adapter
Date: Thu, 16 Apr 2015 15:23:01 +0200
Message-ID: <1429190583-17517-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

The attach_adapter mechanism of the I2C framework is deprecated for years.
There are two users left; drivers for old Macintosh computers. I got the idea
of replacing this mechanism with a custom one with the help of deferred
probing. Because I don't have the hardware, I modified the windtunnel driver to
be runnable on my Renesas Lager board (ARM). This patch is not in this series
but in the branch mentioned below.

I first verified that the attach_adapter method was in deed used for bus
scanning. When scanning, the driver rightfully failed on detecting the actual
i2c clients because there is no such hardware on my board. However, the actual
scanning happened.

Using my custom mechanism, the same happens: all busses get scanned, then the
clients cannot be detected. Since I didn't change the actual detection code, I
assume that it should be working on those Macintosh devices as well. The
keywest driver is only compile-tested. That being said, I'd be more than happy,
if we could find someone willing to test these patches. Top-of-tree kernel
would be nice, but these patches can easily be backported to probably the
beginning of deferred probing. I will also notify some ppc lists of
distributions of this thread for further help.

If this works out, we can _finally_ get rid of this stone-age mechanism and
clean up the i2c core.

Changes since RFC: return -ENODEV instead of 0 when exiting the while loop
                   (= nothing found on all busses)

The branch I used for ARM compilation is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/attach_adapter_removal_with_arm_compile-experimental

Thanks,

   Wolfram


Wolfram Sang (2):
  macintosh: therm_windtunnel: drop using attach adapter
  sound: ppc: keywest: drop using attach adapter

 drivers/macintosh/therm_windtunnel.c | 25 +++++++++++++++++++++++--
 sound/ppc/keywest.c                  | 23 +++++++++++++++++++----
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.1.4
