From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Discard unused driver IDs
Date: Thu, 3 Jan 2008 18:08:11 +0100
Message-ID: <20080103180811.59dbb59f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: V4L and DVB maintainers <v4l-dvb-maintainer-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Discard all I2C driver IDs that aren't used anywhere. That's not just a
couple of them, but more like 49 or one quarter of all defined IDs! And
this is just a first pass, next will come all IDs that are set but
never used, or used but never set.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
V4L/DVB people, if any of these IDs should _not_ be removed for
whatever reason, please let me know so that we can discuss it.

 include/linux/i2c-id.h |   60 ------------------------------------------------
 1 file changed, 60 deletions(-)

--- linux-2.6.24-rc6.orig/include/linux/i2c-id.h	2007-12-22 09:30:41.000000000 +0100
+++ linux-2.6.24-rc6/include/linux/i2c-id.h	2007-12-22 09:31:00.000000000 +0100
@@ -33,23 +33,13 @@
 
 #define I2C_DRIVERID_MSP3400	 1
 #define I2C_DRIVERID_TUNER	 2
-#define I2C_DRIVERID_VIDEOTEX	 3	/* please rename		*/
 #define I2C_DRIVERID_TDA8425	 4	/* stereo sound processor	*/
 #define I2C_DRIVERID_TEA6420	 5	/* audio matrix switch		*/
 #define I2C_DRIVERID_TEA6415C	 6	/* video matrix switch		*/
 #define I2C_DRIVERID_TDA9840	 7	/* stereo sound processor	*/
 #define I2C_DRIVERID_SAA7111A	 8	/* video input processor	*/
-#define I2C_DRIVERID_SAA5281	 9	/* videotext decoder		*/
-#define I2C_DRIVERID_SAA7112	10	/* video decoder, image scaler	*/
-#define I2C_DRIVERID_SAA7120	11	/* video encoder		*/
-#define I2C_DRIVERID_SAA7121	12	/* video encoder		*/
 #define I2C_DRIVERID_SAA7185B	13	/* video encoder		*/
-#define I2C_DRIVERID_CH7003	14	/* digital pc to tv encoder	*/
-#define I2C_DRIVERID_PCF8574A	15	/* i2c expander - 8 bit in/out	*/
-#define I2C_DRIVERID_PCF8582C	16	/* eeprom			*/
-#define I2C_DRIVERID_AT24Cxx	17	/* eeprom 1/2/4/8/16 K		*/
 #define I2C_DRIVERID_TEA6300	18	/* audio mixer			*/
-#define I2C_DRIVERID_BT829	19	/* pc to tv encoder		*/
 #define I2C_DRIVERID_TDA9850	20	/* audio mixer			*/
 #define I2C_DRIVERID_TDA9855	21	/* audio mixer			*/
 #define I2C_DRIVERID_SAA7110	22	/* video decoder		*/
@@ -60,40 +50,19 @@
 #define I2C_DRIVERID_TDA7432	27	/* Stereo sound processor	*/
 #define I2C_DRIVERID_TVMIXER    28      /* Mixer driver for tv cards    */
 #define I2C_DRIVERID_TVAUDIO    29      /* Generic TV sound driver      */
-#define I2C_DRIVERID_DPL3518    30      /* Dolby decoder chip           */
 #define I2C_DRIVERID_TDA9873    31      /* TV sound decoder chip        */
 #define I2C_DRIVERID_TDA9875    32      /* TV sound decoder chip        */
 #define I2C_DRIVERID_PIC16C54_PV9 33    /* Audio mux/ir receiver        */
-
-#define I2C_DRIVERID_SBATT      34     /* Smart Battery Device		*/
-#define I2C_DRIVERID_SBS        35     /* SB System Manager		*/
-#define I2C_DRIVERID_VES1893	36     /* VLSI DVB-S decoder		*/
-#define I2C_DRIVERID_VES1820	37     /* VLSI DVB-C decoder		*/
-#define I2C_DRIVERID_SAA7113	38     /* video decoder			*/
-#define I2C_DRIVERID_TDA8444	39     /* octuple 6-bit DAC             */
 #define I2C_DRIVERID_BT819	40     /* video decoder			*/
 #define I2C_DRIVERID_BT856	41     /* video encoder			*/
 #define I2C_DRIVERID_VPX3220	42     /* video decoder+vbi/vtxt	*/
-#define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
-#define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
-#define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
-#define I2C_DRIVERID_SAA7108	46     /* video decoder, image scaler   */
-#define I2C_DRIVERID_DS1307	47     /* DS1307 real time clock	*/
 #define I2C_DRIVERID_ADV7175	48     /* ADV 7175/7176 video encoder	*/
 #define I2C_DRIVERID_SAA7114	49	/* video decoder		*/
-#define I2C_DRIVERID_ZR36120	50     /* Zoran 36120 video encoder	*/
-#define I2C_DRIVERID_24LC32A	51	/* Microchip 24LC32A 32k EEPROM	*/
-#define I2C_DRIVERID_UDA1342	53	/* UDA1342 audio codec		*/
 #define I2C_DRIVERID_ADV7170	54	/* video encoder		*/
-#define I2C_DRIVERID_MAX1617	56	/* temp sensor			*/
 #define I2C_DRIVERID_SAA7191	57	/* video decoder		*/
 #define I2C_DRIVERID_INDYCAM	58	/* SGI IndyCam			*/
-#define I2C_DRIVERID_BT832	59	/* CMOS camera video processor	*/
-#define I2C_DRIVERID_TDA9887	60	/* TDA988x IF-PLL demodulator	*/
 #define I2C_DRIVERID_OVCAMCHIP	61	/* OmniVision CMOS image sens.	*/
-#define I2C_DRIVERID_TDA7313	62	/* TDA7313 audio processor	*/
 #define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/
-#define I2C_DRIVERID_SAA7114H	64	/* video decoder		*/
 #define I2C_DRIVERID_TDA9874	66	/* TV sound decoder		*/
 #define I2C_DRIVERID_SAA6752HS	67	/* MPEG2 encoder		*/
 #define I2C_DRIVERID_TVEEPROM	68	/* TV EEPROM			*/
@@ -112,7 +81,6 @@
 #define I2C_DRIVERID_DS1672	81	/* Dallas/Maxim DS1672 RTC	*/
 #define I2C_DRIVERID_X1205	82	/* Xicor/Intersil X1205 RTC	*/
 #define I2C_DRIVERID_PCF8563	83	/* Philips PCF8563 RTC		*/
-#define I2C_DRIVERID_RS5C372	84	/* Ricoh RS5C372 RTC		*/
 #define I2C_DRIVERID_BT866	85	/* Conexant bt866 video encoder */
 #define I2C_DRIVERID_KS0127	86	/* Samsung ks0127 video decoder */
 #define I2C_DRIVERID_TLV320AIC23B 87	/* TI TLV320AIC23B audio codec  */
@@ -125,8 +93,6 @@
 #define I2C_DRIVERID_CS4270	94	/* Cirrus Logic 4270 audio codec */
 
 #define I2C_DRIVERID_I2CDEV	900
-#define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
-#define I2C_DRIVERID_ALERT      903    /* SMBus Alert Responder Client  */
 
 /* IDs --   Use DRIVERIDs 1000-1999 for sensors.
    These were originally in sensors.h in the lm_sensors package */
@@ -172,22 +138,15 @@
 
 /* --- Bit algorithm adapters						*/
 #define I2C_HW_B_LP		0x010000 /* Parallel port Philips style */
-#define I2C_HW_B_SER		0x010002 /* Serial line interface */
 #define I2C_HW_B_BT848		0x010005 /* BT848 video boards */
-#define I2C_HW_B_WNV		0x010006 /* Winnov Videums */
 #define I2C_HW_B_VIA		0x010007 /* Via vt82c586b */
 #define I2C_HW_B_HYDRA		0x010008 /* Apple Hydra Mac I/O */
 #define I2C_HW_B_G400		0x010009 /* Matrox G400 */
 #define I2C_HW_B_I810		0x01000a /* Intel I810 */
 #define I2C_HW_B_VOO		0x01000b /* 3dfx Voodoo 3 / Banshee */
-#define I2C_HW_B_PPORT		0x01000c /* Primitive parallel port adapter */
-#define I2C_HW_B_SAVG		0x01000d /* Savage 4 */
 #define I2C_HW_B_SCX200		0x01000e /* Nat'l Semi SCx200 I2C */
 #define I2C_HW_B_RIVA		0x010010 /* Riva based graphics cards */
 #define I2C_HW_B_IOC		0x010011 /* IOC bit-wiggling */
-#define I2C_HW_B_TSUNA		0x010012 /* DEC Tsunami chipset */
-#define I2C_HW_B_OMAHA		0x010014 /* Omaha I2C interface (ARM) */
-#define I2C_HW_B_GUIDE		0x010015 /* Guide bit-basher */
 #define I2C_HW_B_IXP2000	0x010016 /* GPIO on IXP2000 systems */
 #define I2C_HW_B_S3VIA		0x010018 /* S3Via ProSavage adapter */
 #define I2C_HW_B_ZR36067	0x010019 /* Zoran-36057/36067 based boards */
@@ -202,22 +161,11 @@
 #define I2C_HW_B_CX23885	0x010022 /* conexant 23885 based tv cards (bus1) */
 
 /* --- PCF 8584 based algorithms					*/
-#define I2C_HW_P_LP		0x020000 /* Parallel port interface */
-#define I2C_HW_P_ISA		0x020001 /* generic ISA Bus inteface card */
 #define I2C_HW_P_ELEK		0x020002 /* Elektor ISA Bus inteface card */
 
 /* --- PCA 9564 based algorithms */
 #define I2C_HW_A_ISA		0x1a0000 /* generic ISA Bus interface card */
 
-/* --- ACPI Embedded controller algorithms                              */
-#define I2C_HW_ACPI_EC          0x1f0000
-
-/* --- MPC824x PowerPC adapters						*/
-#define I2C_HW_MPC824X		0x100001 /* Motorola 8240 / 8245 */
-
-/* --- MPC8xx PowerPC adapters						*/
-#define I2C_HW_MPC8XX_EPON	0x110000 /* Eponymous MPC8xx I2C adapter */
-
 /* --- PowerPC on-chip adapters						*/
 #define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */
 
@@ -226,7 +174,6 @@
 
 /* --- SGI adapters							*/
 #define I2C_HW_SGI_VINO		0x160000
-#define I2C_HW_SGI_MACE		0x160001
 
 /* --- XSCALE on-chip adapters                          */
 #define I2C_HW_IOP3XX		0x140000
@@ -250,17 +197,10 @@
 #define I2C_HW_SMBUS_W9968CF	0x04000d
 #define I2C_HW_SMBUS_OV511	0x04000e /* OV511(+) USB 1.1 webcam ICs */
 #define I2C_HW_SMBUS_OV518	0x04000f /* OV518(+) USB 1.1 webcam ICs */
-#define I2C_HW_SMBUS_OV519	0x040010 /* OV519 USB 1.1 webcam IC */
 #define I2C_HW_SMBUS_OVFX2	0x040011 /* Cypress/OmniVision FX2 webcam */
 #define I2C_HW_SMBUS_CAFE	0x040012 /* Marvell 88ALP01 "CAFE" cam  */
 #define I2C_HW_SMBUS_ALI1563	0x040013
 
-/* --- ISA pseudo-adapter						*/
-#define I2C_HW_ISA		0x050000
-
-/* --- IPMB adapter						*/
-#define I2C_HW_IPMB		0x0c0000
-
 /* --- MCP107 adapter */
 #define I2C_HW_MPC107		0x0d0000
 


-- 
Jean Delvare
