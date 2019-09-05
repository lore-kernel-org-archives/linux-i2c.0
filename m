From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3 1/1] i2c: qcom-geni: Provide an option to disable DMA
 processing
Date: Thu, 5 Sep 2019 13:58:24 +0000
Message-ID: <3458ed2a-ae49-b46b-3e89-ce039a2749b4@axentia.se>
References: <20190905102247.27583-1-lee.jones@linaro.org>
 <20190905134941.GG1157@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905134941.GG1157@kunai>
Content-Language: en-US
Content-ID: <813F8E51C3E2B141AF9AC8B67D62FE76@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: "alokc@codeaurora.org" <alokc@codeaurora.org>, "agross@kernel.org" <agross@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2019-09-05 15:49, Wolfram Sang wrote:
> Hi Lee,
>=20
> I understand you are in a hurry, but please double check before
> sending...

Linus indicated that an rc8 is coming up, which should provide an extra wee=
k.
https://lwn.net/Articles/798152/

> On Thu, Sep 05, 2019 at 11:22:47AM +0100, Lee Jones wrote:
>> We have a production-level laptop (Lenovo Yoga C630) which is exhibiting
>> a rather horrific bug.  When I2C HID devices are being scanned for at
>> boot-time the QCom Geni based I2C (Serial Engine) attempts to use DMA.
>> When it does, the laptop reboots and the user never sees the OS.
>>
>> The beautiful thing about this approach is that, *if* the Geni SE DMA
>> ever starts working, we can remove the C code and any old properties
>> left in older DTs just become NOOP.  Older kernels with newer DTs (less
>> of a priority) *still* will not work - but they do not work now anyway.
>=20
> ... becasue this paragraph doesn't fit anymore. Needs to be reworded.
>=20
>>
>> Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
>=20
> As said in the other thread, I don't get it, but this is not a show
> stopper for me.

WAG: because ACPI made some driver load at all, and when it
did it something started happening which crashed some machines.

Cheers,
Peter
