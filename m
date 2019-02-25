From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: RE: [PATCH v4 0/2] i2c: designware: Add support for a bus clock
Date: Mon, 25 Feb 2019 09:28:16 +0000
Message-ID: <TYAPR01MB4015D859E542280ABB5D9DC2DF7A0@TYAPR01MB4015.jpnprd01.prod.outlook.com>
References: <1550765459-14519-1-git-send-email-gareth.williams.jx@renesas.com>
 <20190223093207.GC1018@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190223093207.GC1018@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Phil Edworthy <phil.edworthy@renesas.com>
List-Id: linux-i2c@vger.kernel.org

> On Sat, Feb 23, 2019 at 09:32 +0100, wsa@the-dreams.de wrote:
>> On Thu, Feb 21, 2019 at 04:10:57PM +0000, Gareth Williams wrote:
>> The Synopsys I2C Controller has a peripheral clock that some SoCs
>> require to access the registers. This series also details the new
>> clock property in the bindings documentation.
>
> On Sat, Feb 23, 2019 at 09:32 +0100, wsa@the-dreams.de wrote:
> Your SoB is missing for patch 1. And besides my ack, I'd still like some =
feedback from the actual driver maintainers.

Thanks for the feedback Wolfram. I will wait for input from the driver main=
tainers.


Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647
