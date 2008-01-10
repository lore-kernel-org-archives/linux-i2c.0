From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-i801: Regression between 2.6.22.9 & 2.6.23.9
Date: Thu, 10 Jan 2008 15:09:17 +0100
Message-ID: <20080110150917.646c2677@hyperion.delvare>
References: <dba8564e0801090308j34215f98rd758dff3702b194@mail.gmail.com>
	<20080109135341.461688d1@hyperion.delvare>
	<4784D068.8080401@gmail.com>
	<20080109154216.3cec6053@hyperion.delvare>
	<47850DDB.5080101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <47850DDB.5080101-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oleg Ryjkov <oryjkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ivo,

On Wed, 09 Jan 2008 19:09:31 +0100, Ivo Manca wrote:
> I'll still have to do quite a lot of testing, so if I stumble acros the
> caus, I'll let you know.

OK, great.

> Just a quick update:
> Interrupt support seemed to work well for both block and byte reads in
> 2.6.22.9. However, the code was too ugly and full with awful hacks, so
> I've converted it to a proper patch for both 2.6.22.9 and (later)
> 2.6.23.9. Since I do not have the proper hardware at home, I had to wait
> for today & tomorrow to test.
> 
> I'm very curious whether it will work or not, and especially, how fast
> it'll be with i2c block reads.

I am very interested in this as well. I have several ICH3-M, ICH5 and
ICH7-based systems here for testing as soon as you have something good
enough to be published.

For devices which support the block buffer (i.e. ICH4 and later),
Oleg's patch improved speed dramatically for block transactions
already. I don't think that you will win much with interrupts here,
except maybe for HZ=100. I think that you will win a lot more on short
transactions, where polled mode has to wait for at least one jiffie
(and more like 2 on practice) and interrupt mode could be one or two
orders of magnitude faster than this. For hardware monitoring chips
with a lot of registers (e.g. LM85 or ADM1026) the speedup should be
very visible.

> Last test results shows:
> 
> Old driver:
> (time 25x i2cdump -s)
> real    0m27.375s
> user    0m0.008s
> sys     0m0.023s    
> --
> I2C_SMBUS_QUICK(nodev) 0.00222
> I2C_SMBUS_QUICK 0.00238
> I2C_SMBUS_BYTE 0.00203
> I2C_SMBUS_BYTE_DATA 0.00203
> I2C_SMBUS_WORD_DATA 0.00216

What value of HZ are you using? It matters for polled mode. From the
figures above I'd guess HZ=1000. Try again with HZ=250 or even HZ=100
if you want more impressive figures ;)

> New driver:
> (time 25x i2cdump -s)
> ./bla (i2c-dump 25x)
> real    0m24.215s
> user    0m0.013s
> sys     0m0.175s
> --
> I2C_SMBUS_QUICK(nodev) 0.00112
> I2C_SMBUS_QUICK 0.00112
> I2C_SMBUS_BYTE 0.00110
> I2C_SMBUS_BYTE_DATA 0.00113
> I2C_SMBUS_WORD_DATA 0.00108

So that would be a 2x improvement for short transactions at HZ=1000...
and 20x at HZ=100. Very nice :)

-- 
Jean Delvare
