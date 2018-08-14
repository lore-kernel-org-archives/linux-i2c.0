From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Date: Tue, 14 Aug 2018 15:50:40 +0300
Message-ID: <CAHp75VeVvJhkz2b5SVwaKFzGUtiRiqcKnCDXxcQhV6ke3pyzLA@mail.gmail.com>
References: <cf106f99b8794bb38c16c7a5a83e128b@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cf106f99b8794bb38c16c7a5a83e128b@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "WANG Xin (BT-FIR/ENG1-Zhu)" <Xin.Wang7@cn.bosch.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 6, 2018 at 2:39 PM, Jonas Mark (BT-FIR/ENG1)
<Mark.Jonas@de.bosch.com> wrote:

> tout = jiffies + msecs_to_jiffies(at24_write_timeout);
> do {
>          read_time = jiffies;
>
>          ret = regmap_bulk_read(regmap, offset, buf, count);
>          dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
>                  count, offset, ret, jiffies);
>          if (!ret)
>                  return count;
>
>          usleep_range(1000, 1500);
> } while (!time_before(tout, read_time))
>
> The advantage of this code is that the usleep_range() is unconditional.

> The disadvantage of the new proposal is that in case of a timeout one
> more unnecessary sleep is made. Is that acceptable?

Yes.

> An alternative would be to duplicate the regmap_bulk_read() and the
> debugging code outside the loop.

> Is this preferable?

No.

-- 
With Best Regards,
Andy Shevchenko
