From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Date: Sun, 5 Aug 2018 17:09:15 +0300
Message-ID: <CAHp75Ve=WZj6OT7wwQuqmSbZxK7EZr2z=AWJFRA-_aG+4_7MHw@mail.gmail.com>
References: <cd8f37876a2e466ea066bcad10b0b8e4@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cd8f37876a2e466ea066bcad10b0b8e4@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "WANG Xin (BT-FIR/ENG1-Zhu)" <Xin.Wang7@cn.bosch.com>
List-Id: linux-i2c@vger.kernel.org

On Sun, Aug 5, 2018 at 3:26 PM, Jonas Mark (BT-FIR/ENG1)
<Mark.Jonas@de.bosch.com> wrote:
> Hi Andy,
>
> Thank you for your feedback.
>
>> > -#define at24_loop_until_timeout(tout, op_time)                         \
>> > -       for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),     \
>> > -            op_time = 0;                                               \
>> > -            op_time ? time_before(op_time, tout) : true;               \
>> > -            usleep_range(1000, 1500), op_time = jiffies)
>>
>> This one understandble and represents one operation.
>
> It just has the downside that it will not retry if the timeout is
> reached after the usleep_range().
>
> If you have a system which combines high CPU load with repeated EEPROM
> writes you will run into the following scenario:
>
> - System makes a successful regmap_bulk_write() to EEPROM.
> - System wants to perform another write to EEPROM but EEPROM is still
>   busy with the last write.
> - Because of high CPU load the usleep_range() will sleep more than
>   25 ms (at24_write_timeout).
> - Within the over-long sleeping the EEPROM finished the previous write
>   operation and is ready again.
> - at24_loop_until_timeout() will detect timeout and won't try to write.

>
> The scenario above happens very often on our system and we need a fix.

Thanks for explanation why. (it would be good partially move this to
the commit message).


>
>> > +#define at24_loop_until_timeout_begin(tout, op_time)           \
>> > +       tout = jiffies + msecs_to_jiffies(at24_write_timeout);  \
>> > +       while (true) {                                          \
>> > +               op_time = jiffies;
>> > +
>> > +#define at24_loop_until_timeout_end(tout, op_time)             \
>> > +               if (time_before(tout, op_time))                 \
>> > +                       break;                                  \
>> > +               usleep_range(1000, 1500);                       \
>> > +       }
>>
>> Besides `while (true)`, which is a red flag for timeout loops,
>> these are done in an hack way. Just open code them in both cases, or
>> rewrite original one to keel it's semantics.
>
> I have to admit that I am not sure what you mean.
>
> We kept the macro-style of the loop because we assumed it was good
> style in this context.

No way. It's a bad style when you have a macro like you proposing. It
would give you a bottle of sparkling bugs.

> What does "keel it's semantics" mean?

Macro should be standalone piece of code which does something from A
to Z, not from A-K when you need a complementary macro to do L-Z
parts.

> With "open code them in both cases" do you mean to rid of the macro
> and to directly write the loop into the code? Does the following
> match your proposals?
>
> ret = 0;
> tout = jiffies + msecs_to_jiffies(at24_write_timeout);
> do {
>         if (ret)
>                 usleep_range(1000, 1500);
>
>         read_time = jiffies;
>
>         ret = regmap_bulk_read(regmap, offset, buf, count);
>         dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
>                 count, offset, ret, jiffies);
>         if (!ret)
>                 return count;
> } while (!time_before(tout, read_time))

Yes, though, please, look at the examples in the existing code and
make it slightly better

timeout = ...
do {
ret = ...
if (ret) // or if (!ret)
 ...

usleep_range(...);
} while(time_before(...));

-- 
With Best Regards,
Andy Shevchenko
