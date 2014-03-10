From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] i2c-davinci: Implement a bus recovery that actually works
Date: Mon, 10 Mar 2014 07:54:23 +0100
Message-ID: <531D619F.5000803@topic.nl>
References: <1393583525-9555-1-git-send-email-mike.looijmans@topic.nl> <20140309202841.GB2835@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140309202841.GB2835@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: nsekhar@ti.com, khilman@deeprootsystems.com, davinci-linux-open-source@linux.davincidsp.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Looijmans <milo-software@users.sourceforge.net>
List-Id: linux-i2c@vger.kernel.org

=EF=BB=BFOn 03/09/2014 09:28 PM, Wolfram Sang wrote:
> On Fri, Feb 28, 2014 at 11:32:05AM +0100, mike.looijmans@topic.nl wro=
te:
>> From: Mike Looijmans <milo-software@users.sourceforge.net>
>>
>> Having a board where the I2C bus locks up occasionally made it clear
>> that the bus recovery in the i2c-davinci driver will only work on
>> some boards, because on regular boards, this will only toggle GPIO
>> lines that aren't muxed to the actual pins.
>>
>> The I2C controller has the built-in capability to bit-bang its lines=
=2E
>> Use this to implement a generic recovery routine that puts the
>> controller in GPIO mode and pulse the clk lines until both SDA and
>> SCL return to a high state.
>>
>> Because the controller must be held in reset while doing so, the
>> recovery routine must re-init the controller. Since this was already
>> being done after each call to i2c_recover_bus, move that call into
>> the recovery routine as well.
>>
>> Tested on a custom board with OMAP-L138, and after this change, the
>> board can recover from chips keeping SDA low.
>>
>> Note: This is an adapted port from 2.6.37 code, and was only tested
>> with that kernel.
>
> What about using struct i2c_bus_recovery_info, so the actual recovery
> logic is taken from the core?

I never knew such a thing existed, but it sounds like a sensible thing =
to do.

In addition, one could also remove the "sda_pin" and "scl_pin" members =
from=20
the platform data struct, as they no longer serve any purpose after thi=
s patch.

I won't be doing those changes though. My sponsor's budget is limited, =
so I'm=20
just having to do the minimum I can get away with. Maybe someone from T=
I can=20
take it further?

Mike.


Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail
