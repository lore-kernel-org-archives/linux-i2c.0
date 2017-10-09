From: Stephen Douthit <stephend@adiengineering.com>
Subject: Re: [PATCH] i2c: ismt: Separate I2C block read from SMBus block read
Date: Mon, 9 Oct 2017 13:18:20 -0400
Message-ID: <61adc1fb-ecb2-7164-ded3-b45cb7d570b5@adiengineering.com>
References: <20171002124519.GA13496@leonis.localdomain>
 <20171005124133.7ue727bib2mlpnyy@ninjato>
 <20171005141311.GA8565@leonis.localdomain>
 <20171007081426.inlxjb4zevybkai6@ninjato>
 <c9a1d377-1a72-a1fa-304a-48d593d48e6b@adiengineering.com>
Reply-To: stephend@adiengineering.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c9a1d377-1a72-a1fa-304a-48d593d48e6b@adiengineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Pontus Andersson <epontan@gmail.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

 > So, I'll wait for his tests and then send it to Linus ASAP. I think it
 > should be in rc5.

I've been able to confirm the regression my patch introduced, and the
fix from Pontus.

Doing a block read of the SPD EEPROM with my patch everything is shifted
by a byte:

[root@localhost ~]# i2cdump -y 0 0x50 i
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 13 0b 02 04 21 02 01 03 11 01 08 0a 00 fe 00 69    ????!???????.?.i
10: 78 69 30 69 11 18 81 20 08 3c 3c 00 f0 83 05 80    xi0i??? ?<<.????
20: 00 00 00 00 00 00 00 00 85 00 00 00 00 00 00 00    ........?.......
30: 00 00 00 00 00 00 00 00 00 00 00 0f 01 23 00 00    ...........??#..
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 80 2c 00 00 00 00 00 00 00 a6 dc 39    ....?,.......??9
80: 4b 53 46 35 31 32 37 32 41 5a 2d 31 47 36 45 31    KSF51272AZ-1G6E1
90: 20 45 31 80 2c 00 00 00 00 00 00 00 00 00 00 00     E1?,...........
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 92    ...............?

With the patch from Pontus the I2C block read works as expected:

[root@localhost ~]# i2cdump -y 0 0x50 i
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 92 13 0b 02 04 21 02 01 03 11 01 08 0a 00 fe 00    ?????!???????.?.
10: 69 78 69 30 69 11 18 81 20 08 3c 3c 00 f0 83 05    ixi0i??? ?<<.???
20: 80 00 00 00 00 00 00 00 00 85 00 00 00 00 00 00    ?........?......
30: 00 00 00 00 00 00 00 00 00 00 00 00 0f 01 23 00    ............??#.
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 80 2c 00 00 00 00 00 00 00 a6 dc    .....?,.......??
80: 39 4b 53 46 35 31 32 37 32 41 5a 2d 31 47 36 45    9KSF51272AZ-1G6E
90: 31 20 45 31 80 2c 00 00 00 00 00 00 00 00 00 00    1 E1?,..........
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

The ipmi_ssif driver still works with this patch, so no issues for
SMBus block reads.

Tested-by: Stephen Douthit <stephend@adiengineering.com>
