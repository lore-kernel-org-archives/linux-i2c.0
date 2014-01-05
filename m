From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Mon, 06 Jan 2014 00:12:16 +0100
Message-ID: <52C9E6D0.3000406@gmail.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com> <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com> <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch> <20140105172756.GA11280@obsidianresearch.com> <52C99851.70806@gmail.com> <20140105230746.GB11280@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140105230746.GB11280@obsidianresearch.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 01/06/2014 12:07 AM, Jason Gunthorpe wrote:
> On Sun, Jan 05, 2014 at 06:37:21PM +0100, Sebastian Hesselbarth wrote:
>
>> If you mean clock-gated with "powered down", the code is safe. It
>> enables the clock gate prior reading from the controller. Or is there
>> another way to power down the controller, so you cannot read from the
>> controller registers?
>
> There is a clock gate and a power down on kirkwood at least, Linux has
> no code for controlling the powerdown

Does that power down really disable reading from PCIe controller
registers or is it just PHY power down?

> In any event, I think processing a disabled DT node is not great..

Yeah, but you see another way to get the PCIe controller registers
instead? Or any other common id register to read? IMHO PCIe ids are
the best we can find here and Gregory found the first IP that really
depends on the SoC revision..

Sebastian
