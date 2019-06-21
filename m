From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 0/2] i2c: bcm2835: Fixes for clock changes in probe function
Date: Fri, 21 Jun 2019 03:52:48 -0700
Message-ID: <20190621105250.19858-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: eric@anholt.net, wahrenst@gmx.net, f.fainelli@gmail.com, wsa@the-dreams.de, swarren@wwwdotorg.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: linux-i2c@vger.kernel.org

An issue was reported in [1] and [2] that the latest version of the i2c
driver was not properly loading.  After analysis it was determined that
the new clock code was failiing because the i2c driver was trying to
load before the bcm2835-clk driver when not loaded as a module. This is
fixed by actually attempting to grab a reference to the clock and failing
out with a EPROBE_DEFER if it's not there.  This gives the other drivers
an opportunity to load.

This series also fixes a related bug where the clock setup code in the
probe function could cause an issue where the IRQ would be requested
by the driver and never freed in case of some clock setup failure.  The
patch moves this IRQ code to the end of the probe function where it will
not cause this issue.

[1] - https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=242856
[2] - https://archlinuxarm.org/forum/viewtopic.php?f=23&t=13719

Annaliese McDermond (2):
  i2c: bcm2835: Move IRQ request after clock code in probe
  i2c: bcm2835: Ensure clock exists when probing

 drivers/i2c/busses/i2c-bcm2835.c | 42 +++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 17 deletions(-)

-- 
2.19.1
