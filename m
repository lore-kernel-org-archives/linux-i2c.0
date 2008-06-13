From: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-pcf: Drop unused struct members
Date: Fri, 13 Jun 2008 18:36:09 +0200
Message-ID: <4852A1F9.7030005@mydatex.cz>
References: <20080613102510.0b40b352@hyperion.delvare>
	<ec7cefb0806130854y66f93fa8x9b671b539d9b2492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <ec7cefb0806130854y66f93fa8x9b671b539d9b2492-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Eric Brower <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Eric Brower napsal(a):
> On Fri, Jun 13, 2008 at 1:25 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>> Struct members udelay and timeout aren't used anywhere, so drop them.
>>
>> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>> ---
>> Eric, Daniel, you're using i2c-algo-pcf more than me, can you please
>> check and confirm that this patch is correct? It applies on top of
>> Eric's patch for lost arbitration handling.
>>
>>  drivers/i2c/busses/i2c-elektor.c |    2 --
>>  include/linux/i2c-algo-pcf.h     |    4 ----
>>  2 files changed, 6 deletions(-)
>>
>> --- linux-2.6.26-rc5.orig/drivers/i2c/busses/i2c-elektor.c      2008-06-12 15:22:32.000000000 +0200
>> +++ linux-2.6.26-rc5/drivers/i2c/busses/i2c-elektor.c   2008-06-13 09:32:27.000000000 +0200
>> @@ -196,8 +196,6 @@ static struct i2c_algo_pcf_data pcf_isa_
>>        .getown     = pcf_isa_getown,
>>        .getclock   = pcf_isa_getclock,
>>        .waitforpin = pcf_isa_waitforpin,
>> -       .udelay     = 10,
>> -       .timeout    = 100,
>>  };
>>
>>  static struct i2c_adapter pcf_isa_ops = {
>> --- linux-2.6.26-rc5.orig/include/linux/i2c-algo-pcf.h  2008-06-13 09:08:00.000000000 +0200
>> +++ linux-2.6.26-rc5/include/linux/i2c-algo-pcf.h       2008-06-13 09:11:50.000000000 +0200
>> @@ -33,10 +33,6 @@ struct i2c_algo_pcf_data {
>>        int  (*getclock) (void *data);
>>        void (*waitforpin) (void);
>>
>> -       /* local settings */
>> -       int udelay;
>> -       int timeout;
>> -
>>        /* Multi-master lost arbitration back-off delay (msecs)
>>         * This should be set by the bus adapter or knowledgable client
>>         * if bus is multi-mastered, else zero
>>
>>
>> --
>> Jean Delvare
>>
> 
> ACKed on 2.6.26-rc1.  Compiles (and runs) fine.
> 
> [Daniel, this requires changes to i2c-envctrl, since it references the
> removed members when initializing the i2c_algo_pcf_data struct.]
> 
> Thanks again, Jean.
> 
> E
> 
> 
Do you includes this changes to SVN repository or can  do it myself on my source ?


	Dan



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
