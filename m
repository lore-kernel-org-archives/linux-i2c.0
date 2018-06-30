From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 5/6] i2c: Add Actions Semi OWL family S900 I2C driver
Date: Sat, 30 Jun 2018 16:04:20 +0300
Message-ID: <CAHp75Ve5Thjsux6oaZis7axF3jZwqhr2CfrXFcpZuziszB_E9A@mail.gmail.com>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <20180628181042.2239-6-manivannan.sadhasivam@linaro.org>
 <CAHp75Vd__qOXVxZTdxREwD6p1sEw49R2Kqb+esAmr_EhtT=gFg@mail.gmail.com>
 <20180630124400.GB16775@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180630124400.GB16775@Mani-XPS-13-9360>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: devicetree <devicetree@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Mani Sadhasivam <manivannanece23@gmail.com>, hzhang@ucrobotics.com, Wolfram Sang <wsa@the-dreams.de>, Thomas Liau <thomas.liau@actions-semi.com>, Linus Walleij <linus.walleij@linaro.org>, 96boards@ucrobotics.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amit.kucheria@linaro.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, jeff.chen@actions-semi.com, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, =?UTF-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, bdong@ucrobotics.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, mp-cs@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 30, 2018 at 3:44 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> On Sat, Jun 30, 2018 at 03:14:37PM +0300, Andy Shevchenko wrote:
>> On Thu, Jun 28, 2018 at 9:10 PM, Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:

>> > +static int owl_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>> > +                               int num)
>> > +{
>>
>> > +       int ret = 0, idx;
>>
>> Redundant assignment.
>>
>
> No. Actually the return path will be fixed in next iteration. Please
> see my reply to Peter's review for explanation.

How come? I didn't find anything related to this comment in reply you
are referring to.
I left deliberately the below part to show you the pointlessness of an
assignment to 0.

>> > +       ret = owl_i2c_hw_init(i2c_dev);
>> > +       if (ret)
>> > +               return ret;

Do you mean you are dropping this in next revision?

-- 
With Best Regards,
Andy Shevchenko
