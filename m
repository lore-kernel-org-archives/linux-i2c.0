From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH 1/4] i2c: i2c-cros-ec-tunnel: Pass ACPI node to i2c adapter
Date: Mon, 25 Nov 2019 11:05:41 -0700
Message-ID: <CAHQZ30AXvNbT54LsYtF=W_xgnY35QByzGYbjaY0xc92O6h+SRA@mail.gmail.com>
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.1.Iae79baaa31014e8b1d8177bcfbcd41514af724f9@changeid>
 <2dcedacb-8d08-6a58-23af-e834ef9e80fd@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2dcedacb-8d08-6a58-23af-e834ef9e80fd@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Akshu Agrawal <Akshu.Agrawal@amd.com>, Guenter Roeck <groeck@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, Benson Leung <bleung@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 25, 2019 at 9:06 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 21/11/19 22:10, Raul E Rangel wrote:
> > The I2C bus needs to share the same ACPI node as the tunnel device so
> > that the I2C bus can be referenced from ACPI.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>
> Hmm, isn't this change the same as https://lkml.org/lkml/2019/11/21/208 ?
>
We both found the same problem. I wasn't sure if it would be better to
include it as part of this patch set since it was required for the MFD
patch, or to reference it. Let's just take Akshu's patch and ignore
this one.
