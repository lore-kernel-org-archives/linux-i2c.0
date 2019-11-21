From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH 4/4] platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c
 tunnel to MFD Cell
Date: Thu, 21 Nov 2019 14:49:51 -0700
Message-ID: <CAHQZ30CYQd1-ZHJeVnKi9CMeZGiRJmvfYN5PRrpN26gcEJZXOA@mail.gmail.com>
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
 <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <groeck@google.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Wolfram Sang <wsa@the-dreams.de>, Akshu Agrawal <Akshu.Agrawal@amd.com>, Guenter Roeck <groeck@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 21, 2019 at 2:40 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Thu, Nov 21, 2019 at 1:11 PM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > If the i2c-cros-ec-tunnel driver is compiled into the kernel, it is
> > possible that i2c-cros-ec-tunnel could be probed before cros_ec_XXX
> > has finished initializing and setting the drvdata. This would cause a
> > NULL pointer panic.
> >
> > Converting this driver over to an MFD solves the problem and aligns with
> > where the cros_ec is going.
> >
>
> I thought the mfd maintainer objects to the use of the mfd API outside
> drivers/mfd. Did that change recently ?

The MFD apis are only used in drivers/mfd/cros_ec_dev.c.
drivers/i2c/busses/i2c-cros-ec-tunnel.c just registers as a simple
driver.

Raul
