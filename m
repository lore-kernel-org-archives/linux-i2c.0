From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 00/17] Address several documentation build warnings
Date: Tue, 17 Mar 2020 15:54:09 +0100
Message-ID: <cover.1584456635.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Wolfram Sang <wsa@the-dreams.de>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, linux1394-devel@lists.sourceforge.net, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Russell King <linux@armlinux.org.uk>, Chanwoo Choi <cw00.choi@samsung.com>, Doug Ledford <dledford@redhat.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pci@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>, Paul E. McKe
List-Id: linux-i2c@vger.kernel.org

This patch series is against next-20200317. It addresses several warnings on
random places.

It is worth noticing patch 07/17: It changes kernel-doc parser to accept a
very common pattern on kernel-doc markups. This reduces a lot of
warnings all over the tree.

The remaining patches are just random fixes with the hope to address most
warnings that are shown in red when building the documentation.

Mauro Carvalho Chehab (17):
  docs: amu: supress some Sphinx warnings
  docs: arm64: booting.rst: get rid of some warnings
  docs: pci: boot-interrupts.rst: improve html output
  kernel: futex.c: get rid of a docs build warning
  devfreq: devfreq.h: get rid of some doc warnings
  firewire: firewire-cdev.hL get rid of a docs warning
  scripts: kernel-doc: proper handle @foo->bar()
  lib: bitmap.c: get rid of some doc warnings
  rcu: update.c: get rid of some doc warnings
  net: phy: sfp-bus.c: get rid of docs warnings
  net: core: dev.c: fix a documentation warning
  gpio: gpiolib.c: fix a doc warning
  i2c: include/linux/i2c.h: fix a doc warning
  infiniband: pa_vnic_encap.h: get rid of a warning
  ata: libata-core: fix a doc warning
  fs: inode.c: get rid of docs warnings
  regulator: driver.h: fix regulator_map_* function names

 Documentation/PCI/boot-interrupts.rst         | 34 ++++++++++--------
 Documentation/arm64/amu.rst                   |  5 +++
 Documentation/arm64/booting.rst               | 36 +++++++++++--------
 drivers/ata/libata-core.c                     |  2 +-
 drivers/gpio/gpiolib.c                        |  2 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_encap.h  |  2 +-
 drivers/net/phy/sfp-bus.c                     | 32 +++++++++--------
 fs/inode.c                                    |  6 ++--
 include/linux/devfreq.h                       |  6 ++--
 include/linux/i2c.h                           |  4 +--
 include/linux/regulator/driver.h              |  4 +--
 include/uapi/linux/firewire-cdev.h            |  2 +-
 kernel/futex.c                                |  3 +-
 kernel/rcu/update.c                           |  8 ++---
 lib/bitmap.c                                  | 27 +++++++-------
 net/core/dev.c                                |  2 +-
 scripts/kernel-doc                            |  2 ++
 17 files changed, 101 insertions(+), 76 deletions(-)

-- 
2.24.1
