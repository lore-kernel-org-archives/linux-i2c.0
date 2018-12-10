From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 1/2] i2c: enable buses to save their clock frequency in
 adapter
Date: Mon, 10 Dec 2018 08:41:21 +0000
Message-ID: <20181210084111.6938-2-tudor.ambarus@microchip.com>
References: <20181210084111.6938-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210084111.6938-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tudor.Ambarus@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwis=
e,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and enable the buses to save their clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v2: fix typo in R-b tag

 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..f238da204c49 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -677,6 +677,7 @@ struct i2c_adapter {
 	struct rt_mutex bus_lock;
 	struct rt_mutex mux_lock;
=20
+	u32 bus_freq_hz;
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
--=20
2.9.4
