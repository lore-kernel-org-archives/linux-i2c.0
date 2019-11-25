From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH 2/4] i2c: i2c-cros-ec-tunnel: Fix ACPI identifier
Date: Mon, 25 Nov 2019 11:12:53 -0700
Message-ID: <CAHQZ30Dyj18+KQHZ9a5xAqDaGS4+gLAxQ9n8Liusn8eqE6pjFA@mail.gmail.com>
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.2.I68b9a92ed4def031c3f247d3b49996a2512d762d@changeid>
 <d82806a6-101e-181b-60de-0b32ff153ec6@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d82806a6-101e-181b-60de-0b32ff153ec6@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Akshu Agrawal <Akshu.Agrawal@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, Neil Armstrong <narmstrong@baylibre.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, dlaurie@chromium.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 25, 2019 at 9:23 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Raul,
>
> On 21/11/19 22:10, Raul E Rangel wrote:
> > The initial patch was using the incorrect identifier.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > There are currently no boards using the identifier so it's fine to
> > change it.
> >
>
> Right, I don't see GOOG001A being used but also I don't see GOOG0012. Anyway,
> for the CrOS EC side, the change looks good to me. I think this will go through
> the I2C tree?
>
Is you were curious, here is the firmware patch:
https://chromium-review.googlesource.com/c/chromiumos/third_party/coreboot/+/1928674
