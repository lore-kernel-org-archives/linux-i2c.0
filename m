From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 1/3] i2c: rcar: don't issue stop when HW does it automatically
Date: Wed, 30 May 2018 11:07:11 +0100
Message-ID: <1527674833-13122-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1527674833-13122-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1527674833-13122-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit d89667b14f9d13b684287f6189ca209af5feee43 upstream.

The manual says (55.4.8.6) that HW does automatically send STOP after
NACK was received. My measuerments confirm that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
[fabrizio: cherry-pick to 4.4]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 44662e2..6f23b97 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -455,8 +455,8 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 
 	/* Nack */
 	if (msr & MNR) {
-		/* go to stop phase */
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
+		/* HW automatically sends STOP after received NACK */
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
-- 
2.7.4
