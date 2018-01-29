From: Andrew Cooks <andrew.cooks@opengear.com>
Subject: Re: [PATCH] gpio-pca953x: fall back to byte-at-a-time for 24-bit io
Date: Mon, 29 Jan 2018 14:11:35 +1000
Message-ID: <0f82783e-3f78-34dd-4f80-8e21328f9c91@opengear.com>
References: <1512440242-8983-1-git-send-email-andrew.cooks@opengear.com>
 <CAHp75Vcpdh36yjXCCOQthYKdY3vPi5EDrqFWauyv9WDgjcZPYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vcpdh36yjXCCOQthYKdY3vPi5EDrqFWauyv9WDgjcZPYQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, platypus-sw@opengear.com, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Andy

On 29/12/17 19:44, Andy Shevchenko wrote:
> On Tue, Dec 5, 2017 at 4:17 AM, Andrew Cooks <andrew.cooks@opengear.com> wrote:
>> Using TCA6424A with i2c-piix4 bus driver requires byte-at-a-time IO,
>> because the i2c-piix4 driver (and probably some SMBus controllers) don't
>> support I2C_SMBUS_I2C_BLOCK_DATA.
> 
> Why not to fix piix4 for now?

The piix4 driver applies to so many chips and has been around for such a long time, that I don't know if this kind of change is safe to make. Do you think it's safe to assume that all the implementations that use this driver can handle the 3byte block writes?

I've added Jean to the CC list to get the piix4 maintainer's perspective.

> 
>>  static int pca953x_write_regs_24(struct pca953x_chip *chip, int reg, u8 *val)
>>  {
>> +       int ret, i;
>>         int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
>>
>> -       return i2c_smbus_write_i2c_block_data(chip->client,
>> +       if (i2c_check_functionality(chip->client->adapter,
>> +                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
>> +               return i2c_smbus_write_i2c_block_data(chip->client,
>>                                               (reg << bank_shift) | REG_ADDR_AI,
>>                                               NBANK(chip), val);
> 
>> +       } else {
> 
> Redundant and makes useless indentation level below.

Thanks, will fix this.

> 
>> +               for (i = 0; i < NBANK(chip); i++) {
>> +                       ret = i2c_smbus_write_byte_data(chip->client,
>> +                                                       (reg << 1) + i, val[i]);
>> +                       if (ret < 0)
>> +                               return ret;
>> +               }
>> +               return ret;
>> +       }
>>  }
>>
>>  static int pca953x_write_regs(struct pca953x_chip *chip, int reg, u8 *val)
>> @@ -249,7 +261,7 @@ static int pca953x_read_regs_24(struct pca953x_chip *chip, int reg, u8 *val)
>>  {
>>         int bank_shift = fls((chip->gpio_chip.ngpio - 1) / BANK_SZ);
>>
>> -       return i2c_smbus_read_i2c_block_data(chip->client,
>> +       return i2c_smbus_read_i2c_block_data_or_emulated(chip->client,
>>                                              (reg << bank_shift) | REG_ADDR_AI,
>>                                              NBANK(chip), val);
> 
> Don't we have a counter part for writing?
> 
> Perhaps, it might be another option.
> 

Again, I don't know if it's safe to assume that the i2c controllers can do this and would appreciate comments.

Thanks for your review!

a.
