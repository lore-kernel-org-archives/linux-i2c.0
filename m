From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] i2c: mv64xxx: The n clockdiv factor is 0 based on sunxi SoCs
Date: Sun, 27 Sep 2015 16:57:08 +0200
Message-ID: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837AbbI0O5M (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 27 Sep 2015 10:57:12 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

According to the datasheets to n factor for dividing the tclk is
2 to the power n on Allwinner=C2=A0SoCs, not 2 to the power n + 1 as it=
 is
on other mv64xxx implementations.

I've contacted Allwinner about this and they have confirmed that the
datasheet is correct.

This commit fixes the clk-divider calculations for Allwinner SoCs
accordingly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-=
mv64xxx.c
index 30059c1..e75cf6d 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -146,6 +146,8 @@ struct mv64xxx_i2c_data {
 	bool			errata_delay;
 	struct reset_control	*rstc;
 	bool			irq_clear_inverted;
+	/* Clk div is 2 to the power n, not 2 to the power n + 1 */
+	bool			clk_n_base_0;
 };
=20
 static struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx =3D {
@@ -759,25 +761,29 @@ MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_tabl=
e);
 #ifdef CONFIG_OF
 #ifdef CONFIG_HAVE_CLK
 static int
-mv64xxx_calc_freq(const int tclk, const int n, const int m)
+mv64xxx_calc_freq(struct mv64xxx_i2c_data *drv_data,
+		  const int tclk, const int n, const int m)
 {
-	return tclk / (10 * (m + 1) * (2 << n));
+	if (drv_data->clk_n_base_0)
+		return tclk / (10 * (m + 1) * (1 << n));
+	else
+		return tclk / (10 * (m + 1) * (2 << n));
 }
=20
 static bool
-mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *bes=
t_n,
-			  u32 *best_m)
+mv64xxx_find_baud_factors(struct mv64xxx_i2c_data *drv_data,
+			  const u32 req_freq, const u32 tclk)
 {
 	int freq, delta, best_delta =3D INT_MAX;
 	int m, n;
=20
 	for (n =3D 0; n <=3D 7; n++)
 		for (m =3D 0; m <=3D 15; m++) {
-			freq =3D mv64xxx_calc_freq(tclk, n, m);
+			freq =3D mv64xxx_calc_freq(drv_data, tclk, n, m);
 			delta =3D req_freq - freq;
 			if (delta >=3D 0 && delta < best_delta) {
-				*best_m =3D m;
-				*best_n =3D n;
+				drv_data->freq_m =3D m;
+				drv_data->freq_n =3D n;
 				best_delta =3D delta;
 			}
 			if (best_delta =3D=3D 0)
@@ -815,8 +821,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_dat=
a,
 	if (of_property_read_u32(np, "clock-frequency", &bus_freq))
 		bus_freq =3D 100000; /* 100kHz by default */
=20
-	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
-				       &drv_data->freq_n, &drv_data->freq_m)) {
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
+	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
+		drv_data->clk_n_base_0 =3D true;
+
+	if (!mv64xxx_find_baud_factors(drv_data, bus_freq, tclk)) {
 		rc =3D -EINVAL;
 		goto out;
 	}
--=20
2.5.0
