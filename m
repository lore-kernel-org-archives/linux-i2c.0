From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Subject: [PATCH v2 0/1 resend] ARM: shmobile: r8a7790: add I2C support
Date: Fri, 26 Jul 2013 19:33:38 +0900
Message-ID: <1374834819-319-1-git-send-email-nv-dung@jinso.co.jp>
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
To: linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: kuninori.morimoto.gx@renesas.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram
CC Morimoto

Please consider the following patch for the r8a7790 Soc.
This patch modify I2C driver of rcar-H1 to usable on both rcar-H1 and rcar-H2.
It was developed base on the renesas-next-20130528 branch and 
have tested on the Lager board.
Input clock of I2C is peripheral module clock that is named peripheral_clk.

V2: dropped patches 2,3,4 from the previous version.

Thanks,
Nguyen viet Dung

Nguyen Viet Dung (1):
  i2c: rcar: modify I2C driver

 drivers/i2c/busses/i2c-rcar.c |   17 +++++++++++++++--
 include/linux/i2c/i2c-rcar.h  |    4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
1.7.9.5
