From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: Re: [PATCH 3/3] i2c: add ACPI support for i2c-piix4
Date: Tue, 30 Jan 2018 11:13:44 +1000
Message-ID: <09827d60-7c23-99ea-8d48-8231f4a50ace@opengear.com>
References: <cover.1517195327.git.andrew.cooks@opengear.com>
 <f6b7e8e5dc31d294c08d1c218b59e1afce820b37.1517195327.git.andrew.cooks@opengear.com>
 <CAHp75VeZ6fXJsRAj=4ozhLe=X=yL8y3pBVk1c4H7_niQ88Gfhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeZ6fXJsRAj=4ozhLe=X=yL8y3pBVk1c4H7_niQ88Gfhw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andy

Thanks for the review!

On 29/01/18 23:30, Andy Shevchenko wrote:
> On Mon, Jan 29, 2018 at 5:54 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:
>> This enables the i2c-piix4 SMBus controller driver to enumerate I2C
>> slave devices using ACPI. It builds on the related I2C mux device work
>> in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")
>>
>> In the i2c-piix4 driver the adapters are enumerated as:
>>  Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)
>>
>> However, in the AMD BKDG documentation[1], the implied order of ports is:
>>  Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...
>>
>> This ordering difference is unfortunate, and we assume that ACPI
>> developers will use the Linux ordering.
>>
>> [1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
>> Models 30h-3Fh Processors
> 
>> +       if (has_acpi_companion(&dev->dev)) {
>> +               acpi_preset_companion(&adap->dev,
>> +                                     ACPI_COMPANION(&dev->dev),
>> +                                     piix4_adapter_count++);
>> +       }
> 
> Wouldn't be enough just following:
> 
>      ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&dev->dev));

That seems much cleaner, but it doesn't seem to do what I need (my devices don't show up). I'm still investigating.

> 
> ?
> 
> Or if this increment is needed:
> 
> struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> 
> if (adev) {
>     ACPI_COMPANION_SET(&adap->dev, adev);
>     piix4_adapter_count++);
> }
> 
