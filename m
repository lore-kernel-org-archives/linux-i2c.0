From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)"
        <krzysztof.adamski@nokia.com>
Subject: [PATCH 2/3] i2c-axxia: check for error conditions first
Date: Mon, 10 Dec 2018 15:01:27 +0000
Message-ID: <d9a8070357973b5078dc897a18f319cba1df5de0.1544453688.git.krzysztof.adamski@nokia.com>
References: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Content-Language: en-US
Content-ID: <483A37907C106B439A2559E2FA27B219@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>, Tobias Jordan <Tobias.Jordan@elektrobit.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

It was observed that when using seqentional mode contrary to the
documentation, the SS bit (which is supposed to only be set if
automatic/sequence command completed normally), is sometimes set
together with NA (NAK in address phase) causing transfer to falsely be
considered successful.

My assumption is that this does not happen during manual mode since the
controller is stopping its work the moment it sets NA/ND bit in status
register. This is not the case in Automatic/Sequentional mode where it
is still working to send STOP condition and the actual status we get
depends on the time when the ISR is run.

This patch changes the order of checking status bits in ISR - error
conditions are checked first and only if none of them occurred, the
transfer may be considered successful. This is required to introduce
using of sequentional mode in next patch.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 drivers/i2c/busses/i2c-axxia.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.=
c
index d37caf694fbf..35258321e81b 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -296,22 +296,7 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			i2c_int_disable(idev, MST_STATUS_TFL);
 	}
=20
-	if (status & MST_STATUS_SCC) {
-		/* Stop completed */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_SNS) {
-		/* Transfer done */
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
-			axxia_i2c_empty_rx_fifo(idev);
-		complete(&idev->msg_complete);
-	} else if (status & MST_STATUS_TSS) {
-		/* Transfer timeout */
-		idev->msg_err =3D -ETIMEDOUT;
-		i2c_int_disable(idev, ~MST_STATUS_TSS);
-		complete(&idev->msg_complete);
-	} else if (unlikely(status & MST_STATUS_ERR)) {
+	if (unlikely(status & MST_STATUS_ERR)) {
 		/* Transfer error */
 		i2c_int_disable(idev, ~0);
 		if (status & MST_STATUS_AL)
@@ -328,6 +313,21 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 			readl(idev->base + MST_TX_BYTES_XFRD),
 			readl(idev->base + MST_TX_XFER));
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SCC) {
+		/* Stop completed */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_SNS) {
+		/* Transfer done */
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
+			axxia_i2c_empty_rx_fifo(idev);
+		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_TSS) {
+		/* Transfer timeout */
+		idev->msg_err =3D -ETIMEDOUT;
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
 	}
=20
 out:
--=20
2.17.2
