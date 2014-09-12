From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Date: Fri, 12 Sep 2014 10:08:12 +0200
Message-ID: <CAMuHMdWHDks85oFdE1zhRBFxoVdQuU0XCT0vFkdJwTxK-0w9QQ@mail.gmail.com>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
	<1591383.Xdy91rktuP@fb07-iapwap2>
	<20140911145421.GE5149@katana>
	<9935938.eKOCvCAtLt@fb07-iapwap2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <9935938.eKOCvCAtLt@fb07-iapwap2>
Sender: linux-sh-owner@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean Delvare <jdelvare@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Andrey Danin <danindrey@mail.ru>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-i2c@vger.kernel.org

Hi Marc,

On Fri, Sep 12, 2014 at 9:51 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> Am Donnerstag, 11. September 2014, 16:54:22 schrieb Wolfram Sang:
>> On Thu, Sep 11, 2014 at 04:52:22PM +0200, Marc Dietrich wrote:
>> > Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
>> > > > b) could be seen as a configuration thing since the functional=
ity
>> > > > backend could be changed at runtime even.
>> > >
>> > > Come to think of it, not only the functionality, also the addres=
s can be
>> > > changed at runtime. This makes me think it should really not be =
in DT
>> > > after all.
>> >
>> > even worse, there can be multiple masters and slaves changing thei=
r role
>> > on
>> > the fly AFAIK. So the best dt can do is to provide an initial
>> > configuration, so all drivers know where they are and where to sta=
rt.
>> > Everything else can be changed during runtime.
>>
>> Why do you want DT to be involved at all?
>
> Imagine a device which supports both, slave or master mode. The drive=
r needs
> to know in which mode it should operate. This cannot be hard coded, b=
ecause on
> different boards, different modes can be used.
>
> The point is, that if we define a dt binding for master device on sla=
ve
> adapters it will be there forever. So even if it makes no sense for t=
he
> example eeprom simulator (or even our embedded controller), it may ma=
ke sense
> for other or future devices.

DT describes the hardware. The most you can do is describe an i2c
adapter, and an i2c bus with (physical) i2c slaves, if any, and (other)
i2c masters[*], if any.

If the description contains i2c slaves, the i2c adapter can operate in
(but may be not limited to) master mode.

I2c slaves implemented in Linux are not physical i2c slaves, but just
a piece of software. They can appear/disappear/change at any time.
Hence I think this is something to be configured by userspace, like
"tie the i2c-eeprom-slave driver to address 64 on i2c bus 3".

And then you can have the mixed case, where the i2c adapter is both
a master, talking to the physical slaves, and a slave, being talked to =
by
another master. But that's just a superposition of the two cases above,
right?

[*] Are there bindings for other masters on an i2c bus?

Just my 0.02=E2=82=AC (as long as those coins still exist).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
