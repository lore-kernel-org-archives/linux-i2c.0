From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: i2c-mxs: Problems with PIO mode on iMX28
Date: Fri, 28 Jun 2013 11:56:24 +0200
Message-ID: <51CD5DC8.7030606@free-electrons.com>
References: <19340213.PSZe5UysTs@linux-1fbo.site> <20130628091332.GA2948@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130628091332.GA2948@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

It really seems like what I observed in
http://www.spinics.net/lists/linux-i2c/msg11985.html
I still didn't have a deeper look at it.

Also, ccing Fabio that seemed interested in the resoultion of that issue

On 28/06/2013 11:13, Wolfram Sang wrote:
>
> CCing Marek Vasut and Pengutronix...
>
> On Thu, Jun 27, 2013 at 07:39:45PM +0200, Torsten Fleischer wrote:
>> Hi,
>>
>> on my board there is a temperature sensor TCN75A (compatible to LM75)
>> connected to the iMX283.
>> In the user space the temperature is periodically polled by reading
the file
>> /sys/bus/i2c/devices/0-0048/temp1_input.
>> When triggering this file the LM75 driver consecutively reads 3
registers from
>> the sensor and outputs the current temperature read from register 0.
>>
>> With linux 3.9.7 I sometimes get a communication timeout when reading
the
>> sensor.
>>
>> Since several patches have been added to the driver, I tried linux
3.10-rc7.
>> With this version no timeout will be reported, but sometimes the value
>> returned seems to be wrong. Normally I get a value of round about
30000. But
>> sometimes it takes some seconds to read the temperature and the
returned value
>> is 75000. This value is not the current temperature but the temperature
>> hysteresis that is the content of register 2 of the sensor.
>>
>> After some investigation I found that the i2c-mxs driver sometimes
times out
>> while waiting for the MXS_I2C_DEBUG0_DMAREQ bit when writing data (the
>> I2C_M_RD flag is not set).
>> Unfortunately this error is never reported to the I2C core and thus
to the
>> LM75 driver. So the LM75 driver assumes that it has received the correct
>> values.
>>
>> This problem seems to be only in the PIO mode. After changing the
driver so
>> that the DMA is always used it works as expected.
>>
>> Best regards,
>> Torsten Fleischer
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


- -- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJRzV26AAoJEKbNnwlvZCyzkQAP/RjzuLb3rq7GR4IFizpFJ/u7
VbPQuNO6xgFRU5kqB4tmrljxdXDt84Xecgh+dFpOF5CcIDb8ap8x3JN6RTVNFu5a
XGKY2INImW7ShAiw8ZrB/lylRcD/5rwfEnIwpkcx9v2CaNlFbDjAxOmprrkwrI0t
uuCzbhk0l8FHG1RaAzvvPaD8Aai05qwuIvkwwtoT539zVVGx+xb2f0I7i5/3NhML
5N35EPnTwG1k1yi8IemUauf9uPCjKR02vYiTJa+rURVjxa+7RjLP+wHd49JMvbln
CzXNbbnUtKFfIOARFclCzCoMOIp9J9VtbpWy4vvBeHBrj8I8hKqyL0tMmwu3ReKl
FATYCbJVTD9ipjesB2KIUf8vUgVJJZWzOAZWWEeC2x0E2EGj0LdNY7Emmu6u3kWp
5PL6ra6iU1DxPwuFVN1hr3kLvvoI/8d1m4+aMg13VnA+C+h/EeWalZF9ULt4QK99
cPGRwxMRUfZsQFv515XVUeaeiYnd4vAMPZfmMl5WL7LDN6jqkeeM0nJm4jgfGmIv
2PzLhcOyOpSnkONVzn2A/G+948LI3odv6plWjnDqPWcl83zAIFyYmA2NmDirYX1W
JU0DSU26un90IZw0AjwlTeOOxEtE8+KheKFHR7YBj91m36DPvlxZL0kQOL67ibBi
VHt7PanQ3OvbKC70AqCA
=aY1b
-----END PGP SIGNATURE-----
