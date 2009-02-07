From: Eric Brower <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2 v2] i2c,algo: handle timeout correctly
Date: Fri, 6 Feb 2009 16:33:42 -0800
Message-ID: <ec7cefb0902061633u1a9b9245l10c7ea96e90d614d@mail.gmail.com>
References: <4984688B.2090805@gmail.com>
	 <20090201114121.6448a3c9@hyperion.delvare>
	 <498760F7.6020005@gmail.com>
	 <20090202225309.359e77d6@hyperion.delvare>
	 <49883938.9010104@gmail.com>
	 <20090204093402.08ddb2e8@hyperion.delvare>
	 <4989BD34.9050406@gmail.com> <498C3712.2000904@gmail.com>
	 <20090206215111.60c83bd0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090206215111.60c83bd0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 6, 2009 at 12:51 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Fri, 06 Feb 2009 14:11:46 +0100, Roel Kluin wrote:
>> Let's first adress the other issues at hand.
>> This patch should be applied on top of my previous cleanup patch
>
> Agreed.
>
>>
>> --------------------------->8---------------------8<---------------------------
>> With a postfix decrement these timeouts reach -1 rather than 0, but after the
>> loop it is tested whether they have become 0.
>>
>> As pointed out by Jean Delvare, the msg_num should be tested before the timeout.
>> With the current order, you could exit with a timeout error while all the
>> messages were successfully transferred.
>>
>> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
>> index ce916d7..2862f11 100644
>> --- a/drivers/i2c/algos/i2c-algo-pcf.c
>> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
>> @@ -115,15 +115,17 @@ static int wait_for_bb(struct i2c_algo_pcf_data *adap)
>>
>>       status = get_pcf(adap, 1);
>>
>> -     while (timeout-- && !(status & I2C_PCF_BB)) {
>> +     while (!(status & I2C_PCF_BB) && --timeout) {
>>               udelay(100); /* wait for 100 us */
>>               status = get_pcf(adap, 1);
>>       }
>>
>> -     if (timeout <= 0)
>> +     if (timeout == 0) {
>>               printk(KERN_ERR "Timeout waiting for Bus Busy\n");
>> +             return -ETIMEDOUT;
>> +     }
>>
>> -     return timeout <= 0;
>> +     return 0;
>>  }
>>
>>  static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)
>> @@ -133,7 +135,7 @@ static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)
>>
>>       *status = get_pcf(adap, 1);
>>
>> -     while (timeout-- && (*status & I2C_PCF_PIN)) {
>> +     while ((*status & I2C_PCF_PIN) && --timeout) {
>>               adap->waitforpin(adap->data);
>>               *status = get_pcf(adap, 1);
>>       }
>> @@ -142,10 +144,10 @@ static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)
>>               return -EINTR;
>>       }
>>
>> -     if (timeout <= 0)
>> -             return -1;
>> -     else
>> -             return 0;
>> +     if (timeout == 0)
>> +             return -ETIMEDOUT;
>> +
>> +     return 0;
>>  }
>>
>>  /*
>
> Applied, thanks. It would be great if Eric (or anyone with a
> PCF8584-based adapter) could test the two patches, just to make sure we
> didn't accidentally break anything:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-algo-pcf-01-style-cleanups.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-algo-pcf-02-handle-timeout-correctly.patch
>
> --
> Jean Delvare
>

Ack'ed and Ack'ed.

Basic operation seems fine, and two LAB events were properly detected
and handled (best as one can tell, without a bus analyzer...).

-- 
E
