From: Nick Teen <xpage_de-LWAfsSFWpa4@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 17:28:34 +0000 (GMT)
Message-ID: <968764.38783.qm@web27601.mail.ukl.yahoo.com>
References: <20080715185223.7f2f39aa@hyperion.delvare>
Reply-To: xpage_de-LWAfsSFWpa4@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080715185223.7f2f39aa-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--- Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote: 
> Which bus do you see the device on in i2cdetect? You said
> earlier that you were using the i2c-i801 driver, which is expected for
> an Intel motherboard. However you say that the PIC is connected to
> an SMSC chip, and not the Intel south bridge? Are you sure? If you are,
> what is the name of the SMSC chip in question?

Okay, i was wrong. The smsc47m192 _and_ the PIC is connected to the SMBus I801 (at a040). If i type "sensors", i get sensor data from 0x2d. 

> Which i2c bus are you running your program on? The
> "SMBus I801" one?

I'm afraid so.
 
> Note that it is not entirely impossible that the block
> write support in the i2c-i801 driver is broken. This is a driver which is
> mostly used to access SPD EEPROMs and hardware monitoring chips, to which
> you never write blocks.

Okay... so i've no chance to send the PIC block data. :'-(

Thanks a lot! I give up. ;-)

Nick


      __________________________________________________________
Gesendet von Yahoo! Mail.
Dem pfiffigeren Posteingang.
http://de.overview.mail.yahoo.com

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
