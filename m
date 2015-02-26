From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/8] Add proper support for Compulab CM-A510/SBC-A510
Date: Thu, 26 Feb 2015 21:35:39 +0100
Message-ID: <54EF839B.1070008@gmail.com>
References: <1424199129-22099-1-git-send-email-sebastian.hesselbarth@gmail.com> <54EF5E17.1070005@free-electrons.com> <54EF7684.80409@gmail.com> <54EF7B97.4060602@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EF7B97.4060602@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gabriel Dobato <dobatog@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 26.02.2015 21:01, Stephen Warren wrote:
> On 02/26/2015 12:39 PM, Sebastian Hesselbarth wrote:
>> On 26.02.2015 18:55, Gregory CLEMENT wrote:
>>> On 17/02/2015 19:52, Sebastian Hesselbarth wrote:
>>>> This patch set improves current mainline support for the Compulab
>>>> CM-A510 System-on-Module (SoM) and its default Compulab SBC-A510
>>>> base board. Thanks to Gabriel Dobato who agreed to remote debug and
>>>> test the provided DT changes.
>> [...]
>>>> Sebastian Hesselbarth (8):
>>>>    i2c: mux-pinctrl: Rework to honor disabled child nodes
>>>>    devicetree: vendor-prefixes: Add CompuLab to known vendors
>>>>    ARM: dts: dove: Fix uart[23] reg property
>>>>    ARM: dts: dove: Always include gpio and interrupt-controller headers
>>>>    ARM: dts: dove: Add node labels for PCIe ports 0 and 1
>>>>    ARM: dts: dove: Add some more common pinctrl settings
>>>>    ARM: dts: dove: Add internal i2c multiplexer node
>>>>    ARM: dts: dove: Add proper support for Compulab CM-A510/SBC-A510
>>>
>>> Patches 3 to 6 applied on mvebu/dt
>>>
>>> If I understood well patches 7 and 8 depend on patch 1 which had not
>>> been
>>> taken yet.
>>
>> Correct. Once I get a Tested-by from Stephen, I'll resend the 4
>> remaining patches.
>
> Me? For which patch? I thought there was going to be a v2 of the i2c mux
> driver patch given the comments on it, but perhaps I'm misremembering?

AFAIKS, your concerns were addressed to the wording of the binding doc
changes. You don't need that ones to be taken care of before you can
give the i2c-mux-pinctrl driver a functional test, do you? ;)

FWIW, it would be great if you can give patch 1 a test run on one of
the tegra boards using i2c-mux-pinctrl. I'll address the wording
comments if there is no issues with the driver changes.

Sebastian
