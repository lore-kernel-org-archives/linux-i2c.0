From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Fri, 26 Sep 2008 09:28:46 +0200
Message-ID: <20080926092846.63ac885a@hyperion.delvare>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <6601CF63C167F44A9A9E97E41EE4B16C902D37-5t2rvgrEeX4DiO1sSoDvakTPyXqlV3SlZkel5v8DVj8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Prakash,

Removing Kyosti and Mark, who have stepped back long ago, and adding
the i2c mailing list instead, where people may have insight about your
problem.

On Thu, 25 Sep 2008 10:25:50 -0400, Mortha, Prakash wrote:
> I am working with I2c bus driver in Via Ex mother board.
> 
> I am trying to communicate with Micronas chip (MAP5401) on SMBus.
> 
> I need to send 1 sub command and 2 bytes of register address and then
> have to read 2 bytes of data. For this to work I am trying to implement
> I2C_SMBUS_PROC_CALL in function vt596_access() in the file
> drivers/i2c/busses/i2c-viapro.c
> 
> One of the requirement here is I need to send REPEATED START after
> sending 1 command byte and 2 register address bytes before reading 2
> data bytes. But when I use the logic analyzer I could see that a STOP
> being sent when I expect a REPEATED START.
> 
> How to I implement SMBus Process Call functionality. Please guide me.

Well, these VIA chips aren't I2C chips where you have full control of
the clock and data lines, but SMBus master chips with a limited set of
commands available. The SMBus Process Call is one of these commands, it
is supposed to be supported by the VIA chips (protocol = 0100b). Adding
support to the i2c-viapro driver should be trivial.

However, if you did that and the logic analyzer reveals that the VIA
chip doesn't implement the command properly, then this is a hardware
bug and unfortunately there's nothing we can do. This makes me a bit
curious... did you test the other commands with your logic analyzer to
make sure they are correct?

Can you show us the patch you wrote?

What exact VIA chip are you using?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
