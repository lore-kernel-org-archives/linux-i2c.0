From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Tue, 15 Jul 2008 09:47:53 +0200
Message-ID: <20080715094753.475708cd@hyperion.delvare>
References: <180252.53613.qm@web27607.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <180252.53613.qm-WQsacCdWWGLGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Nick Teen <xpage_de-LWAfsSFWpa4@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Nick,

On Tue, 15 Jul 2008 07:29:56 +0000 (GMT), Nick Teen wrote:
> > You probably want to use i2c_smbus_write_i2c_block_data instead. With
> > i2c_smbus_write_block_data, the first data byte isn't real data,
> > instead in indicates how many bytes follow until the end of the block.
> > It should result in "5D W 11 33 44" in your case though, not sure why
> > you get "5D W 11 03 33" instead.
> 
> i'm aware of the length field and i2c_smbus_write_i2c_block_data doesn't
> work, too. Now i get: 5D W 11 44
> 
> unsigned char values[3];
> int reg = 0x11;
> values[0] = 0x33;
> values[1] = 0x44;
> i2c_smbus_write_i2c_block_data(fd, reg, 2, values);
> 
> If i change the third parameter (length) to 1 I get the 0x33.

Ah, you're in user-space, using i2c-dev? You should have told us so.

> I've no idea! :-(

I don't remember any similar problem, so no idea either. I can only
suspect that your bus driver is doing something wrong. So please give
us the detail of your setup:

* Which version of i2c-dev.h are you using?
* What architecture are you working on?
* Which kernel version are you using?
* What i2c bus driver are you using?
* How do you know for sure what actually goes on the bus?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
