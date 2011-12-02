From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PULL] designware i2c DT binding support
Date: Fri, 02 Dec 2011 08:28:16 -0600
Message-ID: <4ED8E080.50909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben,

Please pull for 3.3. This missed 3.2 and I have rebased to the recent
plat/pci changes.

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git i2c-for-3.3

Rob Herring (1):
      i2c-designware: add OF binding support

 .../devicetree/bindings/i2c/i2c-designware.txt     |   22
++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c        |   12 ++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-designware.txt

Thanks,
Rob
