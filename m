From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/3] i2c: at91: slave mode support
Date: Mon, 25 Feb 2019 12:24:09 +0200
Message-ID: <20190225102409.GQ9224@smile.fi.intel.com>
References: <20190222092522.4913-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222092522.4913-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 22, 2019 at 10:25:19AM +0100, Ludovic Desroches wrote:
> [Ludovic Desroches: see Changes section]
> 
> Based on the discussion we had on the i2c-linux list [1], I wrote a patch for
> AT91 hardware and tried to fulfill the Linux I2C slave interface description
> [2] as good as possible. This enables aforementioned hardware to act as an I2C
> slave that can be accessed by a remote I2C master.
> 
> I have tested this patchset successfully on an ATSAMA5D27.
> 
>                                  ^  3.3V   ^  3.3V
>     +-----------------------+    |         |         +-----------------------+
>     | Slave: ATSAMA5D27     |   +-+       +-+        | Master: ATSAMA5D35    |
>     | with i2c-slave-eeprom |   | | 100k  | | 100k   | with i2cset           |
>     +-------------------+-+-+   +-+       +-+        +-+-+-------------------+
>                         | |      |         |           | |
>                         | +------+---------|---(SDA)---+ |
>                         +------------------+---(SCL)-----+
> 
>     Schematic: Connection of slave and master with 100kOhm pullup resistors.
> 
> On the master the following BASH script has been used to stress the slave.
> 
>         root@emblinux:~# cat ./stress.sh

>         #!/bin/bash

Not everybody has bash in their environments. See below, how easily to switch
to regular shell.

#!/bin/sh

>         I=0
>         while true
>         do
>                 if i2cset -y -r 1 0x64 0 $I w | grep mismatch
>                 then
>                         echo "$(date): Error in transmission ${I}"
>                 fi

>                 ((I++))

I=$(($I+1))

>                 if [ $I -eq 65536 ]
>                 then
>                         I=0
>                         echo "$(date): Sent 65536 transmissions"
>                 fi

This one can be optimized to

for I in $(seq 65536); do
...
done

>         done
> 
> After running the script for some time I had the following output. To me this
> looks promising :)
> 
>         root@emblinux:~# ./stress.sh
>         Thu Nov  9 13:58:45 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 14:35:20 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 15:12:11 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 15:49:04 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 16:26:00 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 17:03:07 UTC 2017: Sent 65536 transmissions
>         Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions
> 
>         If you have some hardware with an at91-i2c interface included at hand, I really
>         would appreciate if you can run the test script on your hardware and test this
>         driver.
>         Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions
> 
>         If you have some hardware with an at91-i2c interface included at hand, I really
>         would appreciate if you can run the test script on your hardware and test this
>         driver.

-- 
With Best Regards,
Andy Shevchenko
