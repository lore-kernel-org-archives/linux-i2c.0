From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [Question] When should a driver issue STOP condition?
Date: Fri, 31 Aug 2018 16:36:16 +0900
Message-ID: <CAK7LNAQO2aYLrtzg82jgKdKcOw20rNWBEY3DrdLcwOhnF9aa3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi.


A problem was found in my drivers.


Before sending out patches, please let me
ask a question to make sure the right fix.


The problem is, my driver is forcibly setting
STOP condition unless the next message is read.

Please see this line:
https://github.com/torvalds/linux/blob/v4.19-rc1/drivers/i2c/busses/i2c-uniphier-f.c#L405


Obviously, it it disturbing the I2C_RDWR ioctl functionality.

Documentation/i2c/dev-interface says:
ioctl(file, I2C_RDWR, struct i2c_rdwr_ioctl_data *msgset)
  Do combined read/write transaction without stop in between.


So, I want to be sure
what a driver should (or should not) do.

A driver should issue STOP when and only when the I2C_M_STOP flag
is set in msg->flags.

Is this correct?


In other words, do user-space programs need to explicitly set
I2C_M_STOP where the STOP condition is desired?



Then, another question popped up.

User-space programs can send a single transaction
with read() / write().

I2C_M_STOP is not set in this case.


If a driver does not take care of the STOP condition at all,
the I2C bus is never released.
Is this the right thing to do?


-- 
Best Regards
Masahiro Yamada
