From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c Questions
Date: Sat, 29 Mar 2008 23:09:27 +0100
Message-ID: <20080329230927.3b9b47e5@hyperion.delvare>
References: <BLU106-W751DECBB6A8A8CAAE3C71B0FE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <BLU106-W751DECBB6A8A8CAAE3C71B0FE0-MsuGFMq8XAE@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 27 Mar 2008 21:14:53 +0000, badguy development wrote:
> 
> Hello,
> 
>  I am creating 2 i2c drivers.
> 
> I have started a driver for the LTC1760 
>  and that one is working and well under way.
> 
> I have to now develop a driver for bus address 0x01
>  and in the code I have located that to be an invalid address.
> 
> the code tests for address < 0x03 && address > 0x77
> then promptly fails with invalid address.
> 
> I am hoping to find an understanding for this.
> this is a programmable address, and I will have it changed if I have to.

Please read the I2C specification. Address 0x01 is for CBUS
compatibility and cannot be used by I2C devices.

> 
> Also, I have 3 i2c busses on this iMX31 SOM
> 
> how can I tell my device to only query / operate on a specific bus.
> do I need to?

The device can only operate on the one bus to which it is connected, so
I can't see any problem here.

> 
> and finally where should a noobie to this i2c stuff be asking questions like this?

This is the right list. It would be nice if you could post under your
real name.

> 
> Please forward any response to this to my email here:
> badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org
> 
>  I am trying to join the list, but have not received confirmation yet.
> 
> Thanks ahead of time for your wealth of knowledge.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
