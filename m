From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=201/3=5D=20i2c=3A=20at91=3A=20fix=20compilation=20warning?=
Date: Fri, 23 Nov 2012 17:03:16 +0100
Message-ID: <1353686596-28606-1-git-send-email-ludovic.desroches@atmel.com>
References: <20121123091608.GL5764@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121123091608.GL5764-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

This patch fixes the following warning:
drivers/i2c/busses/i2c-at91.c: In function =E2=80=98at91_twi_get_driver=
_data=E2=80=99:
drivers/i2c/busses/i2c-at91.c:411:3: warning: return discards =E2=80=98=
const=E2=80=99 qualifier from pointer target type [enabled by default]

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at9=
1.c
index aa59a25..f222600 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -408,7 +408,7 @@ static struct at91_twi_pdata * __devinit at91_twi_g=
et_driver_data(
 		match =3D of_match_node(atmel_twi_dt_ids, pdev->dev.of_node);
 		if (!match)
 			return NULL;
-		return match->data;
+		return (struct at91_twi_pdata *)match->data;
 	}
 	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver=
_data;
 }
--=20
1.7.11.3
