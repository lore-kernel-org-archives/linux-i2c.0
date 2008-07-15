From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 18:52:23 +0200
Message-ID: <20080715185223.7f2f39aa@hyperion.delvare>
References: <20080715151321.266cf505@hyperion.delvare>
	<785052.52325.qm@web27604.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <785052.52325.qm-qWTMlLQujKzGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: xpage_de-LWAfsSFWpa4@public.gmane.org, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Nick,

Please keep the i2c list in Cc.

On Tue, 15 Jul 2008 16:24:21 +0000 (GMT), Nick Teen wrote:
> --- Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> 
> > I2C bus, but you never clearly said what I2C bus it was! I
> > suspect a bus driver bug, but at this point I simply have no idea
> > which driver that would be. You mentioned the i2c-i801 driver, but I
> > would be very surprised to see a PIC connected on that bus, unless you
> > soldered it yourself.
> 
> Okay, I will try to tell about the iptv box. The name is ip1101 and manufactured by thomson. It is a common set-top box for internet television and comes with WinCE. If you open the box you can see a intel854 mainboard and a celeron-m 600mhz. In other words it is a personal computer... but it has a frontpanel. You can see it in the picture:
> 
> http://blog.pregos.info/wp-content/uploads/2008/03/thomsonip1101.jpg
> 
> Under WinCE i can sniff (via "milk") on the I2C bus every button
> press and the commands to switch on/off the leds (i think so). The
> frontpanel has a PIC which talks I2C and is connected to one of
> the SMSC-chips. If I disconnect the frontpanel-cable the address
> 0x5d disappear (i2cdetect).

Which bus do you see the device on in i2cdetect? You said earlier that
you were using the i2c-i801 driver, which is expected for an Intel
motherboard. However you say that the PIC is connected to an SMSC chip,
and not the Intel south bridge? Are you sure? If you are, what is the
name of the SMSC chip in question?

Which i2c bus are you running your program on? The "SMBus I801" one?

Note that it is not entirely impossible that the block write support in
the i2c-i801 driver is broken. This is a driver which is mostly used to
access SPD EEPROMs and hardware monitoring chips, to which you never
write blocks.

> I can provide shell-access to the box if it helps.

Thanks, but no thanks. I may try to help you but I'm not going to do
all the work for you ;)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
