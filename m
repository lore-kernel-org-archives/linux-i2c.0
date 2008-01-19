From: Gary Chambers <gwc-OVIABD91gjs3uPMLIKxrzw@public.gmane.org>
Subject: Re: I2C_SMBUS_WORD Definition
Date: Sat, 19 Jan 2008 15:55:42 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0801191539500.18738@galley.ll.mit.edu>
References: <Pine.LNX.4.64.0801181524040.14018@galley.ll.mit.edu>
	<20080119174950.1f12f3c0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080119174950.1f12f3c0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: I2C Mailing List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean...

Thanks for the reply!

> i2c_smbus_read_word_data() does exist, isn't it what you are looking
> for? It corresponds to a "read word" transaction in SMBus terminology.

i2c_smbus_read_word_data() implies (to me, anyway) a required 
data/command in the transaction.  Some of the devices with which we deal 
apparently cannot tolerate this extra 8 bits on the bus when attempting 
to read a word from them.  The bus analyzer also indicates those extra 
bits are present.  I'm doing my work through the dev interface, and our 
functionality matrix seems to indicate that I cannot use pure I2C.  Any 
thoughts or insight?  Thanks very much!

-- 
Gary Chambers

// -------------------------------------
// Advanced SatComm Systems & Operations
// MIT Lincoln Laboratory / 781-981-0957
// Lexington, Massachusetts
// Nothing fancy and nothing Microsoft
// -------------------------------------

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
