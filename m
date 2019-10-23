From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v6 3/9] i2c: add support for filters optional properties
Date: Wed, 23 Oct 2019 12:40:14 +0000
Message-ID: <1571834060-31580-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, wsa@the-dreams.de, peda@axentia.se, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

i2c-digital-filter-width-ns:
This optional timing property specifies the width of the spikes on the i2c
lines (in ns) that can be filtered out by built-in digital filters which ar=
e
embedded in some i2c controllers.
i2c-analog-filter-cutoff-frequency:
This optional timing property specifies the cutoff frequency of a low-pass
analog filter built-in i2c controllers. This low pass filter is used to fil=
ter
out high frequency noise on the i2c lines. Specified in Hz.
Include these properties in the timings structure and read them as integers=
.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

Hello Wolfram,

I modified the comment as requested.
I only resent this patch.

Thanks !
Eugen


 drivers/i2c/i2c-core-base.c | 6 ++++++
 include/linux/i2c.h         | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5f6a498..6a5183c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1656,6 +1656,12 @@ void i2c_parse_fw_timings(struct device *dev, struct=
 i2c_timings *t, bool use_de
 		t->sda_fall_ns =3D t->scl_fall_ns;
=20
 	device_property_read_u32(dev, "i2c-sda-hold-time-ns", &t->sda_hold_ns);
+
+	device_property_read_u32(dev, "i2c-digital-filter-width-ns",
+				 &t->digital_filter_width_ns);
+
+	device_property_read_u32(dev, "i2c-analog-filter-cutoff-frequency",
+				 &t->analog_filter_cutoff_freq_hz);
 }
 EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
=20
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 1361637..aaf57d9 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -575,6 +575,10 @@ struct i2c_lock_operations {
  * @scl_int_delay_ns: time IP core additionally needs to setup SCL in ns
  * @sda_fall_ns: time SDA signal takes to fall in ns; t(f) in the I2C spec=
ification
  * @sda_hold_ns: time IP core additionally needs to hold SDA in ns
+ * @digital_filter_width_ns: width in ns of spikes on i2c lines that the I=
P core
+ *	digital filter can filter out
+ * @analog_filter_cutoff_freq_hz: threshold frequency for the low pass IP =
core
+ *	analog filter
  */
 struct i2c_timings {
 	u32 bus_freq_hz;
@@ -583,6 +587,8 @@ struct i2c_timings {
 	u32 scl_int_delay_ns;
 	u32 sda_fall_ns;
 	u32 sda_hold_ns;
+	u32 digital_filter_width_ns;
+	u32 analog_filter_cutoff_freq_hz;
 };
=20
 /**
--=20
2.7.4
