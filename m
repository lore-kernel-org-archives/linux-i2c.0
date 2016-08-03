From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 0/4] Use complete() instead of complete_all()
Date: Wed,  3 Aug 2016 14:03:07 +0200
Message-ID: <1470225791-16613-1-git-send-email-wagi@monom.org>
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
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Tim Kryger <tim.kryger@linaro.org>, Ray Jui <rjui@broadcom.com>, Daniel Wagner <daniel.wagner@bmw-carit.de>, linux-kernel@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

Hi,

Using complete_all() is not wrong per se but it suggest that there
might be more than one reader. For -rt I am reviewing all
complete_all() users and would like to leave only the real ones in the
tree. The main problem for -rt about complete_all() is that it can be
uses inside IRQ context and that can lead to unbounded amount work
inside the interrupt handler. That is a no no for -rt.

The patches grouped per subsystem and in small batches to allow
reviewing. Unfortanatly I am not so good in coming up with unique
commit message, so please bear with me in that regard. I could also
squash them together, although each patch containts a very short
reasoning why there is only one waiter. Let me know what you rather
prefer. One patch which updates all complete_all() users or those 4
patches with some reasoning.

It is only test compiled because I don't have the all the hardware.

cheers,
daniel

Daniel Wagner (4):
  i2c: bcm-iproc: Use complete() instead of complete_all()
  i2c: bcm-kona: Use complete() instead of complete_all()
  i2c: brcmstb: Use complete() instead of complete_all()
  i2c: meson: Use complete() instead of complete_all()

 drivers/i2c/busses/i2c-bcm-iproc.c | 2 +-
 drivers/i2c/busses/i2c-bcm-kona.c  | 2 +-
 drivers/i2c/busses/i2c-brcmstb.c   | 2 +-
 drivers/i2c/busses/i2c-meson.c     | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.7.4
