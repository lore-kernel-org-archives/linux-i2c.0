From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/5] i2c: designware: Add slave definitions
Date: Tue, 13 Dec 2016 08:11:49 -0600
Message-ID: <CAL_Jsq+DDx460jcLj34_X9MdtCqyc4izwc=3ThnFri+NjBaGUA@mail.gmail.com>
References: <cover.1481131072.git.lolivei@synopsys.com> <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei@synopsys.com>
 <20161212170214.4cydp256jsp7srar@rob-hp-laptop> <BCF0D4927F9C694C9AEA8827D4A9C7C897CE12@de02wembxa.internal.synopsys.com>
 <CAL_JsqJwjX1Y=bDD-hKcXqa1aBKjVhXjEZm6j2tMAQszyv-QhA@mail.gmail.com> <BCF0D4927F9C694C9AEA8827D4A9C7C897CEDB@de02wembxa.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BCF0D4927F9C694C9AEA8827D4A9C7C897CEDB@de02wembxa.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Oliveira <Luis.Oliveira@synopsys.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ramiro.Oliveira@synopsys.com" <Ramiro.Oliveira@synopsys.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
List-Id: linux-i2c@vger.kernel.org

Again, please don't top post. And your line wrapping is messed up.
IOW, you can't use Outlook.

On Tue, Dec 13, 2016 at 4:50 AM, Luis de Oliveira
<Luis.Oliveira@synopsys.com> wrote:
> The controller for i2c-designware cannot be slave/master at the same time and it has to be enabled knowing beforehand if we want it to be slave or master by something outside of the controller itself.
>
> I as looking and I see the use of this I2C_OWN_SLAVE_ADDRESS with the "linux,slave-24c02" slave interface  but I am not seeing how it will help me identify a selected i2c-designware block as a "slave" device before instantiation. I'm sorry if I'm not understanding properly.
> I use the "linux,slave-24c02" to instantiate the i2c-designware as a slave with an address so I can do write/read operations, it is how I tested it.

Something like this:

of_for_each_child_node(child) {
  of_property_read_u32(child, "reg", &reg);
  if (reg & I2C_OWN_SLAVE_ADDRESS))
    im_a_slave = true;
}

...rather than testing "mode" is equal to "slave".

Rob

>
> Luis
>
> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Monday, December 12, 2016 23:16
> To: Luis de Oliveira <Luis.Oliveira@synopsys.com>
> Cc: wsa@the-dreams.de; mark.rutland@arm.com; jarkko.nikula@linux.intel.com; andriy.shevchenko@linux.intel.com; mika.westerberg@linux.intel.com; linux-i2c@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ramiro.Oliveira@synopsys.com; Joao.Pinto@synopsys.com; CARLOS.PALMINHA@synopsys.com
> Subject: Re: [PATCH v4 3/5] i2c: designware: Add slave definitions
>
> On Mon, Dec 12, 2016 at 12:35 PM, Luis de Oliveira <Luis.Oliveira@synopsys.com> wrote:
>> Hi all,
>
> Please don't top post.
>
>>
>> The slave address could be set by the I2C slave backend so I can't use it to setup the controller.
>> A boolean property was my initial approach then Andy and Wolfram Sang suggested the use of compatible strings and later It was suggested to use a property to select mode but I can do it again if it's the best way.
>> Can you please tell me where should it be documented?
>
> bindings/i2c/i2c.txt.
>
> Actually, looking at this some more, we already have a way to describe the controller being a slave device with the I2C_OWN_SLAVE_ADDRESS flag in the reg property. We should just need a helper to read reg property of each child and check for the bit set.
>
> Rob
