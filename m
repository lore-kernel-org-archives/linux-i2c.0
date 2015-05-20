From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 0/6] use devicemodel with parport
Date: Wed, 20 May 2015 20:56:56 +0530
Message-ID: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Tim Waugh <tim@cyberelk.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

After 5 versions of WIP, finally a patch submission.
parport subsystem is now in the transition stage and supports the old
model and the new device model. 3 of the drivers have been converted
into new model and tested.
After other drivers are converted we can remove the old code from
parport.

Sudip Mukherjee (6):
  parport: add device-model to parport subsystem
  staging: panel: use new parport device model
  i2c-parport: define ports to connect
  i2c-parport: use new parport device model
  paride: use new parport device model
  MAINTAINERS: maintain parport

 MAINTAINERS                      |   7 +-
 drivers/block/paride/paride.c    |  57 ++++++-
 drivers/block/paride/paride.h    |   2 +
 drivers/block/paride/pcd.c       |   9 +
 drivers/block/paride/pd.c        |  12 +-
 drivers/block/paride/pf.c        |   7 +
 drivers/block/paride/pg.c        |   8 +
 drivers/block/paride/pt.c        |   8 +
 drivers/i2c/busses/i2c-parport.c |  38 ++++-
 drivers/parport/parport_pc.c     |   4 +-
 drivers/parport/procfs.c         |  15 +-
 drivers/parport/share.c          | 345 ++++++++++++++++++++++++++++++++++++---
 drivers/staging/panel/panel.c    |  14 +-
 include/linux/parport.h          |  43 ++++-
 14 files changed, 522 insertions(+), 47 deletions(-)

-- 
1.8.1.2
