From: Michael Lawnick <ml.lawnick@gmx.de>
Subject: Re: rcar-i2c: always reads a byte
Date: Wed, 12 Mar 2014 10:00:44 +0100
Message-ID: <5320223C.2090905@gmx.de>
References: <531F3686.7050808@codethink.co.uk> <53201A83.7040605@gmx.de> <53201D46.9000306@pcserviceselectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <53201D46.9000306@pcserviceselectronics.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Carpenter <paul@pcserviceselectronics.co.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Paul Carpenter schrieb:
> Michael Lawnick wrote:
>   > Hi,
>   >
>   > Ben Dooks schrieb:
>   >> I have noticed the following behaviour with the i2c-rcar driver
>   >> with the following single i2c_msg structure:
>   >>
>   >>     msg[0].addr = 0x12;
>   >>     msg[0].flags = I2C_M_RD;
>   >>     msg[0].len = 0;
>   >>     msg[0].buf = data;
>   >
>   > isn't this illegal?
>   > This should lead to 50% chance of blocked bus: After sending read-bit
>   > the slave ACK's and puts first data bit onto SDL. If it is '0',
>
> NO device should change the data line during SCL rising or SCL HIGH
> this would cause STOP/START confusion.

Nobody talked about change while SCL high. SCL is high and SDA low for 
ACK. From slave's view it just keeps SDA low for first bit transmission 
while SCL goes low and is expected to go high again.
I'm sure to have seen this multiple times.

You may just test on ordinary devices like lm75.

KR
Michael
