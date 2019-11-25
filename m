From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH] i2c: i2c-cros-ec-tunnel: Fix slave device enumeration
Date: Mon, 25 Nov 2019 11:08:46 -0700
Message-ID: <CAHQZ30ALpF+2N8ZrA3LxNsh4Umf6x8YzEwTKCPst6LDpYU58Nw@mail.gmail.com>
References: <20191121090620.75569-1-akshu.agrawal@amd.com> <15b0a142-a62f-1783-fe46-f5654b618f33@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15b0a142-a62f-1783-fe46-f5654b618f33@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Wolfram Sang <wsa@the-dreams.de>, Neil Armstrong <narmstrong@baylibre.com>, Chanwoo Choi <cw00.choi@samsung.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 25, 2019 at 8:32 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Akshu,
>
> On 21/11/19 10:06, Akshu Agrawal wrote:
> > During adding of the adapter the slave device registration
> > use to fail as the acpi companion field was not populated.
> >
>
> I am wondering if this a fix that needs to picked on stable kernels? Which
> chrome platform are you using?
>
It's a fixup of https://lore.kernel.org/patchwork/patch/1151436/ so
unless that patch has been ported to stable kernels, I wouldn't worry
about it.
