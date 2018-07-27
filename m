From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Fri, 27 Jul 2018 13:44:56 +0300
Message-ID: <CAHp75VfXXdzmp7M8rpcYTTKzwMT=QKt=_m7m7Bfp7uM4izMkrQ@mail.gmail.com>
References: <20180726225508.74612-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726225508.74612-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Derek Basehore <dbasehore@chromium.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Dmitry Torokhov <dtor@chromium.org>, venkateswarlu.v.vinjamuri@intel.corp-partner.google.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore <dbasehore@chromium.org> wrote:
> This enables the async suspend property for i2c devices. This reduces
> the suspend/resume time considerably on platforms with multiple i2c
> devices (such as a trackpad or touchscreen).

How did you test this?

Especially on Chromebooks based on Intel Cherrytrail / Braswell
platforms, they have a painful PMIC vs. OS design solution.

+Cc: Hans, who did a lot in this area.

-- 
With Best Regards,
Andy Shevchenko
