From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Delete 10 unused driver IDs
Date: Tue, 13 Jan 2009 22:04:23 +0100
Message-ID: <20090113220423.7372e67b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c-id.h |   10 ----------
 1 file changed, 10 deletions(-)

--- linux-2.6.29-rc1.orig/include/linux/i2c-id.h	2009-01-13 15:48:41.000000000 +0100
+++ linux-2.6.29-rc1/include/linux/i2c-id.h	2009-01-13 16:20:36.000000000 +0100
@@ -40,9 +40,7 @@
 #define I2C_DRIVERID_SAA7185B	13	/* video encoder		*/
 #define I2C_DRIVERID_SAA7110	22	/* video decoder		*/
 #define I2C_DRIVERID_SAA5249	24	/* SAA5249 and compatibles	*/
-#define I2C_DRIVERID_PCF8583	25	/* real time clock		*/
 #define I2C_DRIVERID_TDA7432	27	/* Stereo sound processor	*/
-#define I2C_DRIVERID_TVMIXER    28      /* Mixer driver for tv cards    */
 #define I2C_DRIVERID_TVAUDIO    29      /* Generic TV sound driver      */
 #define I2C_DRIVERID_TDA9875    32      /* TV sound decoder chip        */
 #define I2C_DRIVERID_BT819	40     /* video decoder			*/
@@ -54,7 +52,6 @@
 #define I2C_DRIVERID_SAA7191	57	/* video decoder		*/
 #define I2C_DRIVERID_INDYCAM	58	/* SGI IndyCam			*/
 #define I2C_DRIVERID_OVCAMCHIP	61	/* OmniVision CMOS image sens.	*/
-#define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/
 #define I2C_DRIVERID_SAA6752HS	67	/* MPEG2 encoder		*/
 #define I2C_DRIVERID_TVEEPROM	68	/* TV EEPROM			*/
 #define I2C_DRIVERID_WM8775	69	/* wm8775 audio processor	*/
@@ -62,23 +59,16 @@
 #define I2C_DRIVERID_CX25840	71	/* cx2584x video encoder	*/
 #define I2C_DRIVERID_SAA7127	72	/* saa7127 video encoder	*/
 #define I2C_DRIVERID_SAA711X	73	/* saa711x video encoders	*/
-#define I2C_DRIVERID_AKITAIOEXP	74	/* IO Expander on Sharp SL-C1000 */
 #define I2C_DRIVERID_INFRARED	75	/* I2C InfraRed on Video boards */
 #define I2C_DRIVERID_TVP5150	76	/* TVP5150 video decoder        */
 #define I2C_DRIVERID_WM8739	77	/* wm8739 audio processor	*/
 #define I2C_DRIVERID_UPD64083	78	/* upd64083 video processor	*/
 #define I2C_DRIVERID_UPD64031A	79	/* upd64031a video processor	*/
 #define I2C_DRIVERID_SAA717X	80	/* saa717x video encoder	*/
-#define I2C_DRIVERID_DS1672	81	/* Dallas/Maxim DS1672 RTC	*/
 #define I2C_DRIVERID_BT866	85	/* Conexant bt866 video encoder */
 #define I2C_DRIVERID_KS0127	86	/* Samsung ks0127 video decoder */
 #define I2C_DRIVERID_TLV320AIC23B 87	/* TI TLV320AIC23B audio codec  */
-#define I2C_DRIVERID_WM8731	89	/* Wolfson WM8731 audio codec */
-#define I2C_DRIVERID_WM8750	90	/* Wolfson WM8750 audio codec */
-#define I2C_DRIVERID_WM8753	91	/* Wolfson WM8753 audio codec */
-#define I2C_DRIVERID_LM4857 	92 	/* LM4857 Audio Amplifier */
 #define I2C_DRIVERID_VP27SMPX	93	/* Panasonic VP27s tuner internal MPX */
-#define I2C_DRIVERID_CS4270	94	/* Cirrus Logic 4270 audio codec */
 #define I2C_DRIVERID_M52790 	95      /* Mitsubishi M52790SP/FP AV switch */
 #define I2C_DRIVERID_CS5345	96	/* cs5345 audio processor	*/
 


-- 
Jean Delvare
