From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-i801: Regression between 2.6.22.9 & 2.6.23.9
Date: Wed, 09 Jan 2008 19:09:31 +0100
Message-ID: <47850DDB.5080101@gmail.com>
References: <dba8564e0801090308j34215f98rd758dff3702b194@mail.gmail.com>	<20080109135341.461688d1@hyperion.delvare>	<4784D068.8080401@gmail.com>
	<20080109154216.3cec6053@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080109154216.3cec6053-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

Jean Delvare wrote:
> On Wed, 09 Jan 2008 14:47:20 +0100, Ivo Manca wrote:
>   
>> Jean Delvare wrote:
>>     
>>> What is an "EEP OM"?
>>>       
>> Sorry, that should read "EEPROM" ofcourse.
>>     
>
> Err, of course. I'm not very smart today it seems...
>
>   
>>> Please note that EEPROMs typically want I2C block reads (mode "i" of
>>> i2cdump) and not SMBus block reads. Using the wrong mode shouldn't hang
>>> the bus though.
>>>       
>> I know; however, i2cdump states my bus doesn't have i2c block read
>> capabilities. That's why I used SMBus block reads, which seemed to work
>> properly.
>>     
>
> OK. This is an important fact when tracking this regression. I guess
> that the 1st byte returned by your EEPROM is 0x80, which is NOT a valid
> SMBus block length. This means that it is expected that an error is
> returned. It wasn't the case before (the invalid length was adjust to
> the nearest valid valid length, i.e. 32) but that was changed in 2.6.23
> to return an error instead, and I think this is the right thing to do:
>   
Ahhhh, seeing the code this way makes perfect sense. Funny, that actual
correcting something makes me feel like it's an error.
>>                 if (i == 1 && read_write == I2C_SMBUS_READ) {
>>                         len = inb_p(SMBHSTDAT0);
>> -                       if (len < 1)
>> -                               len = 1;
>> -                       if (len > 32)
>> -                               len = 32;
>> +                       if (len < 1 || len > I2C_SMBUS_BLOCK_MAX) {
>> +                               result = -1;
>> +                               goto END;
>> +                       }
>>                         data->block[0] = len;
>>                 }
>>     
>
> So, the fact that you get an error with 2.6.23 when you did not in
> 2.6.22 is expected, this is not a regression. I get the same error on
> my test system. The only difference is that it does NOT hang the bus
> for me.
>   
Thanks for showing me; I agree it's not a regression.
However, the bus normally did not hang and now it does, which kinda
feels like an awful downside. Maybe I'm just too lazy to unplug the
power cord every time I test something  ;).
> BTW, I2C block read is now supported in -mm:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-i801-04-add-support-for-i2c-block-read.patch
>   
Some more to apply to my patch then :-). Thanks for noticing me, now I
can properly test interrupt support tomorrow.
> Note that the chip you have at 0x69 is most certainly a clock chip and
> many clock chip do support the SMBus block read transaction. This is
> how I test it, maybe you can try this and see if it hangs as well or
> not.
>
>   
>> Since I was using an ICH5/ICH5R, which is not listed in the switch
>> statement at the probe function, I should be defaulting to isich = 0 and
>> therefor using  i801_block_transaction_byte_by_byte. I'll look into the
>> exact changes made here.
>>     
>
> The ICH5 _is_ listed in the switch statement:
>   
>> 	case PCI_DEVICE_ID_INTEL_82801EB_3:
>>     
>   
Doh. Not my day either.
> So it should use i801_block_transaction_by_block(). You might want to
> test removing this case from the switch statement to force the driver
> to use i801_block_transaction_byte_by_byte() instead, and see if it
> makes a difference.
>   
Will try soon.
>>> On my side I'll check if I can reproduce the problem on one of my test
>>> systems. I don't test SMBus block reads very often so I could have
>>> missed it.
>>>       
>
> I did that, with an ICH5 as well, I get the error when using an SMBus
> block read on an EEPROM, as expected, but the bus never hangs. I have
> no idea why it hangs for you and not for me. If you figure it out,
> please let me know.
>
>   

I'll still have to do quite a lot of testing, so if I stumble acros the
caus, I'll let you know.

Just a quick update:
Interrupt support seemed to work well for both block and byte reads in
2.6.22.9. However, the code was too ugly and full with awful hacks, so
I've converted it to a proper patch for both 2.6.22.9 and (later)
2.6.23.9. Since I do not have the proper hardware at home, I had to wait
for today & tomorrow to test.

I'm very curious whether it will work or not, and especially, how fast
it'll be with i2c block reads.

Last test results shows:

Old driver:
(time 25x i2cdump -s)
real    0m27.375s
user    0m0.008s
sys     0m0.023s    
--
I2C_SMBUS_QUICK(nodev) 0.00222
I2C_SMBUS_QUICK 0.00238
I2C_SMBUS_BYTE 0.00203
I2C_SMBUS_BYTE_DATA 0.00203
I2C_SMBUS_WORD_DATA 0.00216

New driver:
(time 25x i2cdump -s)
./bla (i2c-dump 25x)
real    0m24.215s
user    0m0.013s
sys     0m0.175s
--
I2C_SMBUS_QUICK(nodev) 0.00112
I2C_SMBUS_QUICK 0.00112
I2C_SMBUS_BYTE 0.00110
I2C_SMBUS_BYTE_DATA 0.00113
I2C_SMBUS_WORD_DATA 0.00108
