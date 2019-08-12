From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Mon, 12 Aug 2019 12:43:34 +0200
Message-ID: <fe5cf25f-1804-dc45-7010-01e602b3f3e5@enpas.org>
References: <20190811043253.24938-1-max@enpas.org>
 <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Geert,

Thanks for your feedback!
Replies below.

On 08/12/2019 11:37 AM, Geert Uytterhoeven wrote:
> What about the RTC? The schematics show both a ds1620 and pcf8583.

Oh no! I missed those in the original project, in my mind it didn't have any extra hardware at all.

I only own the new board with the LTC2990, and I'm pretty sure there are more of these in circulation than the original board. So if it's okay, I'll skip the DS1620 and PCF8583.


>> +static void icy_pcf_setbyte(void *data, int ctl, int val)
> 
> icy_pcf_setpcf(), to match the callback name?

Fair. I kept the name when I cloned i2c-elektor.c.


> zorro_request_device()?
> Ah, there's no devm_*() variant yet. OK.

Also, I only wanted to reserve the first 4 bytes. Thinking about it now, it makes more sense to reserve the whole AutoConfig'd space, as I don't know whether the bus GAL maps the PCF8584 across the whole 64k repeatedly.


>> +       /*
>> +        * The 2019 a1k.org PCBs have an LTC2990 at 0x4c, so start
>> +        * it automatically once ltc2990 is modprobed.
>> +        *
>> +        * in0 is the voltage of the internal 5V power supply.
>> +        * temp1 is the temperature inside the chip.
>> +        *
>> +        * Configuration 0x18 enables all sensors on this PCB:
>> +        *  # modprobe i2c-dev
>> +        *  # i2cset 0 0x4c 1 0x18
> 
> What's the reason for the i2cset command?

It sets the sensor modes in the LTC2990 and enables the three sensors listed below. I should have clarified this.

I tried to integrate this in the driver, but ltc2990 only allows reading this configuration out of a device tree. Is there a good way to fake a DT entry in the init function?


> 
>> +        *  # modprobe ltc2990
>> +        * in1 will be the voltage of the 5V rail, divided by 2.
>> +        * in2 will be the voltage of the 12V rail, divided by 4.
>> +        * temp3 will be measured using a PCB loop next the chip.
>> +        */
>> +       i2c->client_ltc2990 = i2c_new_probed_device(&i2c->adapter,
>> +                                                   &icy_ltc2990_info,
>> +                                                   icy_ltc2990_addresses,
>> +                                                   NULL);
>> +
>> +       return 0;
>> +}


Thanks for your feedback,
Max
