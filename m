From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/8] arm: add I2C DT binding docs to various platforms
Date: Tue, 21 May 2019 10:21:29 +0200
Message-ID: <20190521082137.2889-1-wsa@the-dreams.de>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Some I2C drivers entries in MAINTAINERS miss their DT bindings docs.
This series fixes that. Because these drivers are all embedded in their
platform entries, I suggest the respective maintainers pick them up via
their tree. If you prefer that I take them via I2C, let me know.

Wolfram Sang (8):
  MAINTAINERS: add I2C DT bindings to Zynq platform
  MAINTAINERS: add I2C DT bindings to DaVinci platform
  MAINTAINERS: add I2C DT bindings to LPC platforms
  MAINTAINERS: add I2C DT bindings to Nomadik/U300 platforms
  MAINTAINERS: add I2C DT bindings to Rockchip platform
  MAINTAINERS: add I2C DT bindings to STI architecture
  MAINTAINERS: add I2C DT bindings to Versatile platform
  MAINTAINERS: add I2C DT bindings to vt8500 architecture

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.19.1
