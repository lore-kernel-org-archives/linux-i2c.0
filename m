From: Raag Jadav <raag.jadav@einfochips.com>
Subject: [PATCH] i2c: at91: fix TXRDY interrupt spam
Date: Fri, 19 Apr 2019 13:26:53 +0000
Message-ID: <1555680298-518-1-git-send-email-raag.jadav@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Raag Jadav <raag.jadav@einfochips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Performing i2c write operation while SDA or SCL line is grounded,
TXRDY interrupt spam hangs the processor, not allowing to boot.

Signed-off-by: raag <raag.jadav@einfochips.com>
---
 drivers/i2c/busses/i2c-at91.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index bfd1fdf..47b5e8a 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -270,9 +270,11 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 writeb_relaxed(*dev->buf, dev->base + AT91_TWI_THR);

 /* send stop when last byte has been written */
-if (--dev->buf_len == 0)
+if (--dev->buf_len == 0) {
 if (!dev->use_alt_cmd)
 at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
+at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_TXRDY);
+}

 dev_dbg(dev->dev, "wrote 0x%x, to go %zu\n", *dev->buf, dev->buf_len);

--
2.7.4

************************************************************************************************************************************************************* eInfochips Business Disclaimer: This e-mail message and all attachments transmitted with it are intended solely for the use of the addressee and may contain legally privileged and confidential information. If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution, copying, or other use of this message or its attachments is strictly prohibited. If you have received this message in error, please notify the sender immediately by replying to this message and please delete it from your c
 omputer. Any views expressed in this message are those of the individual sender unless otherwise stated. Company has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email. *************************************************************************************************************************************************************
