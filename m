From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [PATCH 0/8] i2c: img-scb: fixes to support i2c on pistachio
Date: Mon, 7 Sep 2015 10:41:25 -0300
Message-ID: <CAAEAJfCW9cEMDZwta5Q6VVEZfzxTDZ50Fx=YeW6bPMnrtKNcbw@mail.gmail.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
	<20150731111252.GL1522@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150731111252.GL1522@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, jdelvare-l3A5Bk7waGM@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram, Jean:

On 31 July 2015 at 08:12, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Jul 27, 2015 at 12:47:13PM +0100, Sifan Naeem wrote:
>> Following patches are required to fix the existing driver to
>> support i2c on pistachio.
>>
>> Tested on Pistachio bub using an Adafruit I2C Non-Volatile FRAM Brea=
kout
>> (256Kbit / 32KByte) eeprom.
>>
>> Used i2c buildroot tools to test the eeprom and the other i2c blocks=
=2E
>> Also used dd commands to copy data to and then to dump data from the
>> eeprom. i2ctransfer was used to test repeated starts and verified
>> using a scope.
>
> That sounds like good testing \o/ If you are happy with i2ctransfer,
> then please consider adding Tested-by tags to the i2ctransfer patches=
,
> so Jean gets a more cosy feeling to include them to i2ctools.
>
>>

Definitely! i2ctransfer was a HUGE help while developing this driver,
specially when preparing involved transfers to test repeated starts.

Any chance it gets merged in its current state? I think it'll be useful=
, even
if the usage cli API is still a moving target.

We could print some warning "i2ctransfer is experimental"
or something like that.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
