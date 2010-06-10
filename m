From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 0/2] Rework OF i2c support code
Date: Wed, 09 Jun 2010 23:22:27 -0600
Message-ID: <20100610052102.16222.86662.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following series reworks the of_i2c support code so that i2c drivers
can be matched to devices using the struct device_driver of_match table,
and so that i2c devices described in a device tree node will be
transparently registered if the i2c adapter of_node pointer is set.

The OF hooks used in the second patch are entirely compiled out when
CONFIG_OF is not set.

---

Ben, these changes probably should go through my devicetree branch.  They
are currently sitting in the following branch, and I'll move it over to
next-devicetree in a week or so if I don't receive any objections (it
can always come out again if there are, but I want the test coverage).

git://git.secretlab.ca/git/linux-2.6 test-devicetree

Grant Likely (2):
      of/i2c: Generalize OF support
      i2c: Add OF-style registration and binding


 drivers/i2c/busses/i2c-cpm.c     |    6 +----
 drivers/i2c/busses/i2c-ibm_iic.c |    4 +--
 drivers/i2c/busses/i2c-mpc.c     |    2 +-
 drivers/i2c/i2c-core.c           |    9 ++++++++
 drivers/of/Kconfig               |    2 +-
 drivers/of/of_i2c.c              |   44 ++++++++++++++++++++++++--------------
 include/linux/of_i2c.h           |   13 +++++++++--
 7 files changed, 51 insertions(+), 29 deletions(-)
