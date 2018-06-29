From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 0/6] Add Actions Semi S900 I2C support
Date: Fri, 29 Jun 2018 07:09:59 +0200
Message-ID: <565B1582-69F8-450E-8A4C-2BD528E9F07D@axentia.se>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org> <76F2EEF1-A266-4E05-8C72-74492928A531@axentia.se> <20180629044439.GA29931@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629044439.GA29931@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de, linus.walleij@linaro.org, linux-i2c@vger.kernel.org, liuwei@actions-semi.com, mp-cs@actions-semi.com, 96boards@ucrobotics.com, devicetree@vger.kernel.org, andy.shevchenko@gmail.com, daniel.thompson@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, hzhang@ucrobotics.com, bdong@ucrobotics.com, manivannanece23@gmail.com, thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On June 29, 2018 6:44:39 AM GMT+02:00, Manivannan Sadhasivam <manivannan=2E=
sadhasivam@linaro=2Eorg> wrote:
>Hi Peter,
>
>On Fri, Jun 29, 2018 at 06:13:31AM +0200, Peter Rosin wrote:

>> Hi!
>>=20
>> I don't know for sure, but over here the arch/arm64/boot/dts/actions
>folder has no pinctrl nodes at all (v4=2E18-rc2)=2E So, what is this seri=
es
>based on? The reason I started looking was that patch 2 *appears* to
>depend on patch 3, and I just wanted to double check that=2E=2E=2E
>>=20
>
>You are right=2E The pinctrl patch [1] is still not merged by the
>platform
>maintainer Andreas but it has been reviewed by the pinctrl maintainer
>Linus Walleij=2E For your reference, I have queued up all reviewed dts
>patches
>in my tree [2] from which Andreas is picking them for 4=2E19=2E

Would have been helpful if this was mentioned from the start, and as I sus=
pected, patch 3 does indeed depend on patch 2=2E

>For this series, since the dts patches will go through the ARM SoC
>tree,
>Andreas will pick it up once it is reviewed=2E
>
>Hope this clarifies!

Yup=2E

Cheers,
Peter

>Thanks,
>Mani
>
>[1] https://patchwork=2Ekernel=2Eorg/patch/10322937/
>[2]
>https://git=2Elinaro=2Eorg/people/manivannan=2Esadhasivam/linux=2Egit/log=
/?h=3Ds900-for-next
>
>> Cheers,
>> Peter

Hi!
