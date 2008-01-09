From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-i801: Regression between 2.6.22.9 & 2.6.23.9
Date: Wed, 09 Jan 2008 14:47:20 +0100
Message-ID: <4784D068.8080401@gmail.com>
References: <dba8564e0801090308j34215f98rd758dff3702b194@mail.gmail.com>
	<20080109135341.461688d1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080109135341.461688d1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
> On Wed, 9 Jan 2008 12:08:28 +0100, Ivo Manca wrote:
>   
>> Trying to test  interrupt support for i801 I learned that somehow
>> between kernel version 2.6.22.14 and 2.6.23.9, something went wrong
>> with the bus driver. Is this a known issue?
>>     
>
> No, you are the first person to report this problem as far as I know.
>
>   
>> When I try to use i2cdump to block-read an EEP OM, my i2cbus hangs.
>>     
>
> What is an "EEP OM"?
>   
Sorry, that should read "EEPROM" ofcourse.
> Please note that EEPROMs typically want I2C block reads (mode "i" of
> i2cdump) and not SMBus block reads. Using the wrong mode shouldn't hang
> the bus though.
>   
I know; however, i2cdump states my bus doesn't have i2c block read
capabilities. That's why I used SMBus block reads, which seemed to work
properly.
>> Please find my output for 2.6.19-1 (working), 2.6.22.14-72 (working)
>> and 2.6.23.9-85 (not working).
>>
>> Note: SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R)
>>
>> Ivo
>>
>> [root@localhost ~]# uname -r
>> 2.6.19-1.2911.fc6
>>
>> [root@localhost ~]# modprobe i2c-dev
>> [root@localhost ~]# i2cdetect -y 0
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
>> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
>> 50: 50 XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
>> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
>> 70: XX XX XX 73 XX XX XX XX
>>
>> [root@localhost ~]# i2cdump -y 0 0x55 s
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
>> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u
>>
>> [root@localhost ~]# i2cdump -y 0 0x55 s
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
>> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u
>>
>> ====
>>
>> [root@localhost ~]# uname -r
>> 2.6.22.14-72.fc6
>>
>> [root@localhost ~]# modprobe i2c-dev
>>
>> [root@localhost ~]# i2cdetect -y 0
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
>> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
>> 50: 50 XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
>> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
>> 70: XX XX XX 73 XX XX XX XX
>>
>> [root@localhost ~]# i2cdump -y 0 0x55 s
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
>> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u
>>
>> [root@localhost ~]# i2cdump -y 0 0x55 s
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
>> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u
>>     
>
> So 2.6.22 works as good as 2.6.19 did, right?
>   
Correct. I had to test this at university, since I don't have to proper
hardware at home. Because they machine's there are running FC6 with
2.6.19 kernels, I just wanted to be sure the problem didn't start
between 2.6.19 and 2.6.22.9. Being in a hurry, I forgot to change the
subject of this mail (and of course, only noticed just after pushing the
send button).
>> ====
>>
>> [root@localhost ~]# uname -r
>> 2.6.23.9-85.fc8
>>
>> [root@localhost ~]# modprobe i2c-dev
>>
>> [root@localhost ~]# i2cdetect -y 0
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
>> 50: 50 -- -- -- 54 55 -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
>> 70: -- -- -- 73 -- -- -- --
>>     
>
> I note that this version of i2cdetect is more recent than the one you
> used when testing 2.6.19-1.2911.fc6 and 2.6.22.14-72.fc6 kernels. I
> suppose that this is the case for i2cdump as well... To make sure that
> this is really an i2c-i801 driver issue and not a user-space issue, can
> you please try again using the exact same version of i2cdetect and
> i2cdump?
>   
True. I used an old version of the fedora lm_sensors package. I updated
both installations to the newest version available @ ATrpms.net. This
did not make any difference.
>> [root@localhost ~]# i2cdump -y 0 0x55 s
>> Error: Block read failed, return code -1
>>
>> [root@localhost ~]# i2cdump -y 0 0x55 s
>> Error: Block read failed, return code -1
>>
>> (i2c Bus hangs completely, poweroff needed.)
>>     
>
> Note that i2cdump relies on i2c-dev, so the problem could be in
> i2c-dev. There were changes to i2c-dev between 2.6.22 and 2.6.23, that
> affect I2C block reads, but not SMBus block reads. 
Not sure if it helps, but the 2.6.23.9 i2c_i801 module loaded on a
2.6.22.9 kernel gave the same error message and problems. Yes: I'm aware
that I'm not supposed to test modules like that ;)
> There were two large
> patches applied to i2c-i801:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ca8b9e32a11a7cbfecbef00c8451a79fe1af392e
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7edcb9abb594a8f3b4ca756e03d01c870aeae127
>   
I already noticed these patches while trying to convert my patch, which
adds interrupt support, to 2.6.23.9. I was happy to see them, since I
was always curious why defines were not used for statusses and why
"/* set 32 byte buffer */" was there without doing anything ;)

Since I was using an ICH5/ICH5R, which is not listed in the switch
statement at the probe function, I should be defaulting to isich = 0 and
therefor using  i801_block_transaction_byte_by_byte. I'll look into the
exact changes made here.
> You may also want to check what fedora-specific patches your kernels
> include for i2c-i801 and i2c-dev, if any. Can you reproduce the problem
> with a vanilla 2.6.23.12 kernel?
>
> On my side I'll check if I can reproduce the problem on one of my test
> systems. I don't test SMBus block reads very often so I could have
> missed it.
>   
I'll check with Hans for fedora specific patches and install a vanilla
kernel as soon as time permits; I hope tomorrow.

Thanks,

Ivo
