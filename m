From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_smbus_write_block_data does not send all bytes?!
Date: Mon, 14 Jul 2008 22:54:24 +0200
Message-ID: <20080714225424.6e183aae@hyperion.delvare>
References: <247321.99325.qm@web27608.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <247321.99325.qm-SFSZVIN0dfnGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
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

Hallo Nick,

On Mon, 14 Jul 2008 20:32:25 +0000 (GMT), Nick Teen wrote:
> Hello folks,
> 
> i despair of i2c_smbus_write_block_data. I try to send this few bytes:
> 
>  5D W 11 02 33 44
> 
> but my attached example code sends always:
> 
>  5D W 11 03 33
> 
> I'm perfectly happy if somebody can help me! :-)

You probably want to use i2c_smbus_write_i2c_block_data instead. With
i2c_smbus_write_block_data, the first data byte isn't real data,
instead in indicates how many bytes follow until the end of the block.
It should result in "5D W 11 33 44" in your case though, not sure why
you get "5D W 11 03 33" instead.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
