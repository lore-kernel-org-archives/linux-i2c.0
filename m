From: Nick Teen <xpage_de-LWAfsSFWpa4@public.gmane.org>
Subject: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 07:29:56 +0000 (GMT)
Message-ID: <180252.53613.qm@web27607.mail.ukl.yahoo.com>
Reply-To: xpage_de-LWAfsSFWpa4@public.gmane.org
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> You probably want to use i2c_smbus_write_i2c_block_data instead. With
> i2c_smbus_write_block_data, the first data byte isn't real data,
> instead in indicates how many bytes follow until the end of the block.
> It should result in "5D W 11 33 44" in your case though, not sure why
> you get "5D W 11 03 33" instead.

i'm aware of the length field and i2c_smbus_write_i2c_block_data doesn't work, too. Now i get: 5D W 11 44

unsigned char values[3];
int reg = 0x11;
values[0] = 0x33;
values[1] = 0x44;
i2c_smbus_write_i2c_block_data(fd, reg, 2, values);

If i change the third parameter (length) to 1 I get the 0x33.

I've no idea! :-(

Regards,

Nick


      __________________________________________________________
Gesendet von Yahoo! Mail.
Dem pfiffigeren Posteingang.
http://de.overview.mail.yahoo.com

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
