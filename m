From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: RE: [PATCH v3 0/2] i2c: designware: Add support for a bus clock
Date: Wed, 20 Feb 2019 13:42:39 +0000
Message-ID: <TY2PR01MB401156288B6D81D7089D5020DF7D0@TY2PR01MB4011.jpnprd01.prod.outlook.com>
References: <1550669148-6027-1-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550669148-6027-1-git-send-email-gareth.williams.jx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Sorry, the email below was sent prematurely and will be resent shortly.

-Gareth

> On 20 February 2019 13:26 Gareth Williams wrote:
> The Synopsys I2C Controller has a bus clock that some SoCs require to acc=
ess
> the registers. This series also details the new clock property in the bin=
dings
> documentation.
>
> v3:
>  - busclk renamed to pclk.
>  - Added comment with dw_i2c_dev struct definition describing pclk.
>  - Added enable rollback of first clock if second fails to enable.
>  - Changed clocks and clock-names sections to use term "peripheral clock"
>    (pclk) instead of "bus clock" (busclk) in dt-bindings documentation.
> v2:
>  - Use new devm_clk_get_optional() function as it simplifies handling whe=
n
>    the optional clock is not present.
>
> Phil Edworthy (2):
>   dt: snps,designware-i2c: Add clock bindings documentation
>   i2c: designware: Add support for a bus clock
>
>  .../devicetree/bindings/i2c/i2c-designware.txt         |  9 +++++++++
>  drivers/i2c/busses/i2c-designware-common.c             | 18
> ++++++++++++++++--
>  drivers/i2c/busses/i2c-designware-core.h               |  2 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c            |  5 +++++
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> --
> 2.7.4



Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647
