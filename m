From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/3] i2c: add ACPI support for i2c-piix4
Date: Tue, 30 Jan 2018 20:23:28 +0200
Message-ID: <CAHp75Ve3vgbfV6pRYxWMOQidh_J=kPkxGTOU0g6GWg9ePOcu=g@mail.gmail.com>
References: <cover.1517195327.git.andrew.cooks@opengear.com>
 <f6b7e8e5dc31d294c08d1c218b59e1afce820b37.1517195327.git.andrew.cooks@opengear.com>
 <CAHp75VeZ6fXJsRAj=4ozhLe=X=yL8y3pBVk1c4H7_niQ88Gfhw@mail.gmail.com>
 <56310e2c-eedc-a71a-3247-d418ec10052d@opengear.com> <CAHp75VeFym8ei2M9_de0Wqg7g1dDV1TAq6DxTigfHfeT4TFopg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeFym8ei2M9_de0Wqg7g1dDV1TAq6DxTigfHfeT4TFopg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Cooks <andrew.cooks@opengear.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 30, 2018 at 8:22 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jan 30, 2018 at 3:43 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:
>> On 29/01/18 23:30, Andy Shevchenko wrote:
>>> On Mon, Jan 29, 2018 at 5:54 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:

>>>> +       if (has_acpi_companion(&dev->dev)) {
>>>> +               acpi_preset_companion(&adap->dev,
>>>> +                                     ACPI_COMPANION(&dev->dev),
>>>> +                                     piix4_adapter_count++);
>>>> +       }

>> It is similar to the topology shown in commit 8eb5c87a ("i2c: add ACPI support for I2C mux ports")
>
> Ah, I see now. Your initial approach seems fine.
>
> Perhaps even new helper can be made for users (currently i2c mux,
> sdio, libata) in the future.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
