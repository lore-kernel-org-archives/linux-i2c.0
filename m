From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/4] use correct compatibles for the nxp,se97b chips
Date: Tue, 16 Jan 2018 17:06:14 +0100
Message-ID: <20180116160618.27859-1-peda@axentia.se>
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
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi!

The TSE-850 and the Nattis are using se97b chips from NXP. Previously,
these have been specified as compatible to "nxp,24c02". But the updated
bindings for the at24 eeproms makes me think that the right thing to
do is to have their compatible be

   "nxp,se97b", "atmel,24c02"

This series takes care of that, and throws in a sorting patch while at it.

Cheers,
Peter

Peter Rosin (4):
  dt-bindings: at24: sort manufacturers alphabetically
  dt-bindings: at24: add compatible for nxp,se97b
  ARM: dts: at91: nattis: use the correct compatible for the eeprom
  ARM: dts: at91: tse850: use the correct compatible for the eeprom

 Documentation/devicetree/bindings/eeprom/at24.txt | 3 ++-
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts       | 2 +-
 arch/arm/boot/dts/at91-tse850-3.dts               | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.11.0
