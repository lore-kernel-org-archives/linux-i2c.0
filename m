From: Kalyan Kinthada <Kalyan.Kinthada@alliedtelesis.co.nz>
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Sun, 24 Sep 2017 21:44:21 +0000
Message-ID: <1506289460890.34765@alliedtelesis.co.nz>
References: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>,<87377fmbpw.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44780 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbdIXVo1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 24 Sep 2017 17:44:27 -0400
In-Reply-To: <87377fmbpw.fsf@free-electrons.com>
Content-Language: en-NZ
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Packham <Chris.Packham@alliedtelesis.co.nz>

Hi Gregory,=0A=
=0A=
I got this information from Armada-38x functional errata document.=0A=
=0A=
I can add the "marvell,mv78230-i2c" compatible string to the appropriate  d=
evice tree files =0A=
but the i2c-mv64xxx driver enables an additional  feature (offload i2c tran=
sactions)=0A=
based on the compatible string "marvell,mv78230-i2c".=0A=
=0A=
I am not sure if this feature (offload i2c transactions) should be enabled =
for Armada-38x devices.=0A=
That is the reason I felt for the need of a new compatible string specifica=
lly for Armada-38x SoCs.=0A=
=0A=
Thanks,=0A=
Kalyan=0A=
________________________________________=0A=
From: Gregory CLEMENT <gregory.clement@free-electrons.com>=0A=
Sent: Friday, 22 September 2017 7:30 p.m.=0A=
To: Kalyan Kinthada=0A=
Cc: devicetree@vger.kernel.org; wsa@the-dreams.de; robh+dt@kernel.org; pawe=
l.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@=
codeaurora.org; linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; Ch=
ris Packham=0A=
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding=0A=
=0A=
Hi Kalyan,=0A=
=0A=
 On ven., sept. 22 2017, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.=
nz> wrote:=0A=
=0A=
> All armada-38x variants(380, 385, 388) SoCs have an issue=0A=
> in i2c controller which violates the i2c repeated start timing.=0A=
=0A=
=0A=
Did you had an issue with one of the SoC ?=0A=
If yes what was your setting ?=0A=
On my side I never managed to have this sort of issue on Armada 38x.=0A=
=0A=
>=0A=
> This errata is fixed in the i2c-mv64xxx driver but enabled=0A=
> only for devices with compatible string "marvell,mv78230-i2c".=0A=
=0A=
In this case why not just adding the "marvell,mv78230-i2c" as compatible=0A=
string in the appropriate device tree files ?=0A=
=0A=
Gregory=0A=
=0A=
>=0A=
> This patch introduces a new compatible string=0A=
> "marvell,armada-38x-i2c" for the i2c controller on armada-38x SoCs=0A=
> so that the workaound is enabled.=0A=
=0A=
=0A=
>=0A=
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>=0A=
> ---=0A=
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-mv64xxx.txt=0A=
> index 5c30026921..fc100b6bdb 100644=0A=
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt=0A=
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt=0A=
> @@ -14,6 +14,7 @@ Required properties :=0A=
>                           very rare, initial version of the SoC which=0A=
>                           had broken offload support.  Linux=0A=
>                           auto-detects this and sets it appropriately.=0A=
> +                     - "marvell,armada-38x-i2c"=0A=
>   - interrupts      : The interrupt number=0A=
>=0A=
>  Optional properties :=0A=
> --=0A=
> 2.14.1=0A=
>=0A=
=0A=
--=0A=
Gregory Clement, Free Electrons=0A=
Kernel, drivers, real-time and embedded Linux=0A=
development, consulting, training and support.=0A=
http://free-electrons.com=0A=
