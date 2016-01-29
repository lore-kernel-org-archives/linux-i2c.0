From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: i2c-bcm2835: Unable to read from i2c0
Date: Fri, 29 Jan 2016 19:16:35 +0100
Message-ID: <56ABAC83.4000402@lategoodbye.de>
References: <7de3fd0b-7973-476c-a009-e9a1fb032a80@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <7de3fd0b-7973-476c-a009-e9a1fb032a80-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Phil <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Phil,

Am 28.01.2016 um 23:49 schrieb Phil:
> A few questions:
>
> 1) What has changed in your system? Have you ever been able to use the PiGlow?

please avoid top-posting. I'm using I2C just for a short time, so i 
don't know if there was a different behavior before. I tested the PiGlow 
with the following kernel versions:

Raspbian Wheezy 3.18
Raspbian Jessie 4.1.13
Mainline 4.5rc-1

All of them show the same detect behavior (see below).

Writing to the SN3218 works good, i can enable and disable the LEDs ... 
But i can't read back any values.

I've replaced the PiGlow with a Adafruit Si1145. After that the chip is 
detected in both cases, but the error messages (i2c transfer failed) 
still appear.

>
> 2) What is the state of the GPIOs?

What do you mean? configuration of both I2C0 pins?

Do you want a register dump?

Thanks
Stefan

>
> Phil
>
> On 28 Jan 2016 9:43 p.m., Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org> wrote:
>>
>> Hi,
>>
>> i'm using a Raspberry Pi B (rev 1) and Linux kernel 4.5rc-1. I have
>> connected a PiGlow (SN3218 at address 0x54) to the P1 Header. The I2C
>> bus clock is set to 100 kHz.  Every time i want to read data from i2c0
>> the following error appear:
>>
>> [   94.343612] i2c-bcm2835 20205000.i2c: i2c transfer failed: 100
>>
>> According to the BCM2835 datasheet this should be an ERR ACK (Slave has
>> not acknowledged its address).
>>
>>> i2cdetect -y 0
>> 0 1 2 3 4 5 6 7 8 9 a b c d e f
>> 00: -- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>>> i2cdetect -q -y 0
>>        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 50: -- -- -- -- 54 -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> Strangly writing data to the SN3218 works.
>>
>> Does anyone have an explanation for this error?
>>
>> Regards
>> Stefan
>>
>> _______________________________________________
>> linux-rpi-kernel mailing list
>> linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
