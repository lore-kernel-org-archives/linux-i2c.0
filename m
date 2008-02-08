From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: I2c-i801 interrupt support (was: Re: i2c-i801: Regression
 between 2.6.22.9 & 2.6.23.9)
Date: Fri, 08 Feb 2008 17:22:33 +0100
Message-ID: <47AC81C9.3020907@gmail.com>
References: <dba8564e0801090308j34215f98rd758dff3702b194@mail.gmail.com>	<20080109135341.461688d1@hyperion.delvare>	<4784D068.8080401@gmail.com>	<20080109154216.3cec6053@hyperion.delvare>	<47850DDB.5080101@gmail.com>
	<20080110150917.646c2677@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080110150917.646c2677-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Oleg Ryjkov <oryjkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Hans de Goede <j.w.r.degoede-fbo2DhPpy/Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hey Jean,

Jean Delvare wrote:
> Hi Ivo,
>
>   
> I am very interested in this as well. I have several ICH3-M, ICH5 and
> ICH7-based systems here for testing as soon as you have something good
> enough to be published.
>
> For devices which support the block buffer (i.e. ICH4 and later),
> Oleg's patch improved speed dramatically for block transactions
> already. I don't think that you will win much with interrupts here,
> except maybe for HZ=100. I think that you will win a lot more on short
> transactions, where polled mode has to wait for at least one jiffie
> (and more like 2 on practice) and interrupt mode could be one or two
> orders of magnitude faster than this. For hardware monitoring chips
> with a lot of registers (e.g. LM85 or ADM1026) the speedup should be
> very visible.
>
>   
Sadly I haven't been able to test this improvement due to lack of
(available) hardware. The last test showed a bug which crashes the
controller but I think I've already fixed it. Luckily, Hans de Goede
arranged a spare PC which I can use for testing and development. I hope
to pick it up soon and development should speed up then!

So, thanks to the HHS (Hague University) for making a system available
for testing and thanks to Hans for arranging this!

> What value of HZ are you using? It matters for polled mode. From the
> figures above I'd guess HZ=1000. Try again with HZ=250 or even HZ=100
> if you want more impressive figures ;)
>   
Default, so 1000 I suppose.
>> New driver:
>> (time 25x i2cdump -s)
>> ./bla (i2c-dump 25x)
>> real    0m24.215s
>> user    0m0.013s
>> sys     0m0.175s
>> --
>> I2C_SMBUS_QUICK(nodev) 0.00112
>> I2C_SMBUS_QUICK 0.00112
>> I2C_SMBUS_BYTE 0.00110
>> I2C_SMBUS_BYTE_DATA 0.00113
>> I2C_SMBUS_WORD_DATA 0.00108
>>     
>
> So that would be a 2x improvement for short transactions at HZ=1000...
> and 20x at HZ=100. Very nice :)
>   
Seems quite nice yes, let's just hope I/we can get it stable enough!

Ivo


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
