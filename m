From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 4/7] drivers/i2c: Add abort and hardware reset procedures
Date: Wed, 30 May 2018 03:20:04 +0300
Message-ID: <CAHp75VfZHCDzsmF3=Nauy2ftPNs+5yOqBY9oBkrmLrus1BnK8A@mail.gmail.com>
References: <1527632665-25707-1-git-send-email-eajames@linux.vnet.ibm.com> <1527632665-25707-5-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527632665-25707-5-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Edward A. James" <eajames@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 30, 2018 at 1:24 AM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> From: "Edward A. James" <eajames@us.ibm.com>
>
> Add abort procedure for failed transfers. Add engine and bus reset
> procedures to recover from as many faults as possible.

> +#define I2C_PORT_BUSY_RESET    0x80000000

BIT() ?

> +       for (i = 0; i < 9; ++i) {

i++ would work as well.

> +               rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_SCL, &dummy);
> +               if (rc)
> +                       return rc;
> +
> +               rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_SET_SCL, &dummy);
> +               if (rc)
> +                       return rc;
> +       }

> +       /* reset errors */
> +       dummy = 0;
> +       rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
> +       if (rc)
> +               return rc;

Ah, okay, discard my previous comments on dummy assignments. It seems
input and output.

> +       msleep(1);

msleep(1) usually a bad idea.
usleep_range() I guess what you need here.

> +}

> +       return -ETIME;

ETIMEDOUT ?

-- 
With Best Regards,
Andy Shevchenko
