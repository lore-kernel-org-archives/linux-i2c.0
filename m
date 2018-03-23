From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Date: Fri, 23 Mar 2018 03:39:47 +0000
Message-ID: <8564c3ea3b3c4b08b940b02acf501722@svr-chch-ex1.atlnz.lc>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
 <20171029172918.2xtz2srh2meq45io@ninjato>
 <20171207104205.h5ejivdmtharmdln@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rich Felker <dalias@libc.org>
Cc: "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 07/12/17 23:42, Wolfram Sang wrote:=0A=
> On Sun, Oct 29, 2017 at 06:29:18PM +0100, Wolfram Sang wrote:=0A=
>> On Wed, Jul 05, 2017 at 10:13:54PM +1200, Chris Packham wrote:=0A=
>>> This series addresses some of the points identified by Andy. The series=
 is=0A=
>>> based on top of i2c/for-next. 2 of the patches from v1 have already bee=
n=0A=
>>> applied so I've dropped them from this version.=0A=
>>>=0A=
>>> I have compile tested patch 1/1 but I don't have access to sh hardware=
=0A=
>>> to actually test the changes on.=0A=
>>>=0A=
>>> Chris Packham (4):=0A=
>>>    sh: sh7785lcr: add GPIO lookup table for i2c controller reset=0A=
>>>    i2c: pca-platform: unconditionally use devm_gpiod_get_optional=0A=
>>>    i2c: pca-platform: use device_property_read_u32=0A=
>>>    i2c: pca-platform: drop gpio from platform data=0A=
>>>=0A=
>>>   arch/blackfin/mach-bf561/boards/acvilon.c |  1 -=0A=
>>>   arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-=0A=
>>>   drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++-------------=
---------=0A=
>>>   include/linux/i2c-pca-platform.h          |  3 ---=0A=
>>>   4 files changed, 20 insertions(+), 29 deletions(-)=0A=
>>=0A=
>> Series looks good to me, too. I'd need ACKs from the SH maintainers,=0A=
>> though. Technically, from Blackfin maintainers as well. But I haven't=0A=
>> heard from them in months, so I could go without that.=0A=
> =0A=
> Adding Rich Felker to CC...=0A=
> =0A=
=0A=
Ping. Was there any movement on this series? I think this may have been =0A=
caught up between the holiday period and various merge windows.=0A=
=0A=
Just wanted to check if there was anything I need to be doing to get =0A=
this through.=0A=
