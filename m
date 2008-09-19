From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: tvp5150 new style i2c driver
Date: Fri, 19 Sep 2008 22:26:08 +0200
Message-ID: <20080919222608.030a3801@hyperion.delvare>
References: <48D3C5A3.3080802@spesonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48D3C5A3.3080802-wNesuFfO2Ajz1n+OaKNE4w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Luca Santini <luca.santini-wNesuFfO2Ajz1n+OaKNE4w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Luca,

On Fri, 19 Sep 2008 17:30:43 +0200, Luca Santini wrote:
> i need to interface with a TI tvp5150 (video codec), wired via
> i2c on my custom board.

Which board is that? In particular, which i2c bus drivers are you using?

> i'm on kernel 2.6.27git and i found there's a driver for the
> codec... but i get the 'SMBus not supported' error when i try
> to enable it.

I can't find the error message "SMBus not supported" anywhere in the
kernel tree, what is the exact error message?

> So old style coding...

New-style i2c drivers don't have much to do with what the underlying i2c
bus driver supports. Legacy vs. new-style is about how the devices are
created.

> I was trying to convert it to new-style when i found on the ML
> Archive someone had some similar problem....
>
> do somebody have some pre-coded patch for me?

Which mailing list archive? I can't remember any post related to the
tvp5150 driver before yours on the i2c list.
 
> After i made it work, how to communicate with it?

Not a question for this mailing list. Better ask the v4l people.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
