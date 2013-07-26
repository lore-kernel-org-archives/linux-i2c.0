From: Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH] i2c: Fix Kontron PLD prescaler calculation
Date: Fri, 26 Jul 2013 14:04:55 +0200
Message-ID: <20130726140455.40b4b86b@hyperion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Kevin Strasser <strassek-29tvszzbzErpgkiH4x7ZXw@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Michael Brunner <Michael.Brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Chris Healy <chealy-KRR2zmvM+DFWk0Htik3J/w@public.gmane.org>, Dirk Hohndel <Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add some necessary braces that have been removed during driver cleanup.
This fixes the I2C prescaler calculation.

Signed-off-by: Michael Brunner <michael.brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-kempld.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-kempld.c b/drivers/i2c/busses/i2c-kempld.c
index ccec916..af8f65f 100644
--- a/drivers/i2c/busses/i2c-kempld.c
+++ b/drivers/i2c/busses/i2c-kempld.c
@@ -246,9 +246,9 @@ static void kempld_i2c_device_init(struct kempld_i2c_data *i2c)
 		bus_frequency = KEMPLD_I2C_FREQ_MAX;
 
 	if (pld->info.spec_major == 1)
-		prescale = pld->pld_clock / bus_frequency * 5 - 1000;
+		prescale = pld->pld_clock / (bus_frequency * 5) - 1000;
 	else
-		prescale = pld->pld_clock / bus_frequency * 4 - 3000;
+		prescale = pld->pld_clock / (bus_frequency * 4) - 3000;
 
 	if (prescale < 0)
 		prescale = 0;
