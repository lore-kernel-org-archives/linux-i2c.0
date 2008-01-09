From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-i801: Regression between 2.6.19-1 & 2.6.23.9
Date: Wed, 9 Jan 2008 13:53:41 +0100
Message-ID: <20080109135341.461688d1@hyperion.delvare>
References: <dba8564e0801090308j34215f98rd758dff3702b194@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <dba8564e0801090308j34215f98rd758dff3702b194-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, 9 Jan 2008 12:08:28 +0100, Ivo Manca wrote:
> Trying to test  interrupt support for i801 I learned that somehow
> between kernel version 2.6.22.14 and 2.6.23.9, something went wrong
> with the bus driver. Is this a known issue?

No, you are the first person to report this problem as far as I know.

> When I try to use i2cdump to block-read an EEP OM, my i2cbus hangs.

What is an "EEP OM"?

Please note that EEPROMs typically want I2C block reads (mode "i" of
i2cdump) and not SMBus block reads. Using the wrong mode shouldn't hang
the bus though.

> Please find my output for 2.6.19-1 (working), 2.6.22.14-72 (working)
> and 2.6.23.9-85 (not working).
> 
> Note: SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R)
> 
> Ivo
> 
> [root@localhost ~]# uname -r
> 2.6.19-1.2911.fc6
> 
> [root@localhost ~]# modprobe i2c-dev
> [root@localhost ~]# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: 50 XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX 73 XX XX XX XX
> 
> [root@localhost ~]# i2cdump -y 0 0x55 s
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u
> 
> [root@localhost ~]# i2cdump -y 0 0x55 s
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u
> 
> ====
> 
> [root@localhost ~]# uname -r
> 2.6.22.14-72.fc6
> 
> [root@localhost ~]# modprobe i2c-dev
> 
> [root@localhost ~]# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
> 50: 50 XX XX XX 54 55 XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX 73 XX XX XX XX
> 
> [root@localhost ~]# i2cdump -y 0 0x55 s
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u
> 
> [root@localhost ~]# i2cdump -y 0 0x55 s
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 08 07 0d 0a 01 40 00 04 60 70 00 82 08 00 01 0e    ?????@.?`p.??.??
> 10: 04 0c 01 02 20 c0 75 70 00 00 48 30 48 2a 40 75    ???? ?up..H0H*@u

So 2.6.22 works as good as 2.6.19 did, right?

> 
> ====
> 
> [root@localhost ~]# uname -r
> 2.6.23.9-85.fc8
> 
> [root@localhost ~]# modprobe i2c-dev
> 
> [root@localhost ~]# i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> 50: 50 -- -- -- 54 55 -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
> 70: -- -- -- 73 -- -- -- --

I note that this version of i2cdetect is more recent than the one you
used when testing 2.6.19-1.2911.fc6 and 2.6.22.14-72.fc6 kernels. I
suppose that this is the case for i2cdump as well... To make sure that
this is really an i2c-i801 driver issue and not a user-space issue, can
you please try again using the exact same version of i2cdetect and
i2cdump?

> 
> [root@localhost ~]# i2cdump -y 0 0x55 s
> Error: Block read failed, return code -1
> 
> [root@localhost ~]# i2cdump -y 0 0x55 s
> Error: Block read failed, return code -1
> 
> (i2c Bus hangs completely, poweroff needed.)

Note that i2cdump relies on i2c-dev, so the problem could be in
i2c-dev. There were changes to i2c-dev between 2.6.22 and 2.6.23, that
affect I2C block reads, but not SMBus block reads. There were two large
patches applied to i2c-i801:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ca8b9e32a11a7cbfecbef00c8451a79fe1af392e
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7edcb9abb594a8f3b4ca756e03d01c870aeae127

You may also want to check what fedora-specific patches your kernels
include for i2c-i801 and i2c-dev, if any. Can you reproduce the problem
with a vanilla 2.6.23.12 kernel?

On my side I'll check if I can reproduce the problem on one of my test
systems. I don't test SMBus block reads very often so I could have
missed it.

-- 
Jean Delvare
