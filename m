From: Krishna Kothapalli <krishna_sunitha-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Looking for ICH SMBUS "Process call" support in i2c-i801 bus driver
Date: Thu, 8 Oct 2009 19:09:27 -0400
Message-ID: <COL117-W70326CE4BD5366E7F94C688CC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



Hi,

I have a couple of devices EEDPROM and Power Sequencer(ADM1066) that ne=
ed "Sequential Random Read" which has 2 byte address requirements.
Currently Process call is not implemented in code drivers/i2c/busses/i2=
c-i801.c.=20
Appreciate any suggestions for alternative implementations.

Thanks.,

/* I801 command constants */
=A0#define I801_QUICK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00
=A0#define I801_BYTE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x04
=A0#define I801_BYTE_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x08
=A0#define I801_WORD_DATA=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x0C
=A0#define I801_PROC_CALL=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x10=A0=A0=A0 /* u=
nimplemented */<------=20
=A0#define I801_BLOCK_DATA=A0=A0=A0=A0=A0=A0=A0=A0 0x14
=A0#define I801_I2C_BLOCK_DATA=A0=A0=A0=A0 0x18=A0=A0=A0 /* ICH5 and la=
ter */
=A0#define I801_BLOCK_LAST=A0=A0=A0=A0=A0=A0=A0=A0 0x34
=A0#define I801_I2C_BLOCK_LAST=A0=A0=A0=A0 0x38=A0=A0=A0 /* ICH5 and la=
ter */
=A0#define I801_START=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x40
=A0#define I801_PEC_EN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x80=A0=A0=A0=
 /* ICH3 and later */

 		 	   		 =20
_________________________________________________________________
Hotmail: Free, trusted and rich email service.
http://clk.atdmt.com/GBL/go/171222984/direct/01/--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
