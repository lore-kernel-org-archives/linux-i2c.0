From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Date: Sat, 4 Aug 2018 23:51:37 +0300
Message-ID: <CAHp75Veo__Zu_Uk5-CN5q_yEUHs0fDsKZu9van89JBX2Prs7-w@mail.gmail.com>
References: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533404620-18536-1-git-send-email-mark.jonas@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jonas <mark.jonas@de.bosch.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wang Xin <xin.wang7@cn.bosch.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 4, 2018 at 8:43 PM, Mark Jonas <mark.jonas@de.bosch.com> wrote:


> -#define at24_loop_until_timeout(tout, op_time)                         \
> -       for (tout = jiffies + msecs_to_jiffies(at24_write_timeout),     \
> -            op_time = 0;                                               \
> -            op_time ? time_before(op_time, tout) : true;               \
> -            usleep_range(1000, 1500), op_time = jiffies)

This one understandble and represents one operation.

> +#define at24_loop_until_timeout_begin(tout, op_time)           \
> +       tout = jiffies + msecs_to_jiffies(at24_write_timeout);  \
> +       while (true) {                                          \
> +               op_time = jiffies;
> +
> +#define at24_loop_until_timeout_end(tout, op_time)             \
> +               if (time_before(tout, op_time))                 \
> +                       break;                                  \
> +               usleep_range(1000, 1500);                       \
> +       }

Besides `while (true)`, which is a red flag for timeout loops,
these are done in an hack way. Just open code them in both cases, or
rewrite original one to keel it's semantics.

-- 
With Best Regards,
Andy Shevchenko
