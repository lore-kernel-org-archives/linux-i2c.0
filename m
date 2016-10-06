From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCHv1] hwmon: Add tc654 driver
Date: Thu, 6 Oct 2016 23:13:50 +0000
Message-ID: <5dcea99a8a5f40be85d021ae74d2ed35@svr-chch-ex1.atlnz.lc>
References: <20161006225702.GA9365@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-hwmon-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, Masahiko Iwamoto <iwamoto@allied-telesis.co.jp>, Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>, Kevin Tsai <ktsai@capellamicro.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 10/07/2016 11:57 AM, Guenter Roeck wrote:=0A=
> On Fri, Oct 07, 2016 at 10:36:47AM +1300, Chris Packham wrote:=0A=
>> Add support for the tc654 and tc655 fan controllers from Microchip.=0A=
>>=0A=
>> http://ww1.microchip.com/downloads/en/DeviceDoc/20001734C.pdf=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>=0A=
>> Hi Gunter,=0A=
>>=0A=
>> I realise this isn't using the new hwmon registration API. This is=0A=
>> essentially a forward port from an older kernel. I can attempt a=0A=
>> conversion as a follow up patch but I loose the ability to actually test=
=0A=
>> the driver.=0A=
>>=0A=
> No problem.=0A=
>=0A=
> Can you send me a register dump for this chip ?=0A=
=0A=
Here you go=0A=
=0A=
[root@awplus /flash]# i2cdump /dev/i2c-0 0x1b=0A=
Dump of device 0x1b on /dev/i2c-0=0A=
  0: 76 00 0a 0a 2a 02 00 54 00 b3 31 01 ff ff ff 00  v...*..T..1.....=0A=
=0A=
I'll read through the rest of your comments and reply with a v2 later.=0A=
=0A=
=0A=
