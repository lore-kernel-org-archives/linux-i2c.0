From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Fri, 27 Jul 2018 14:07:11 +0200
Message-ID: <1c3aba3d-0dfb-dc24-bd7a-5289a19a9065@redhat.com>
References: <20180726225508.74612-1-dbasehore@chromium.org>
 <CAHp75VfXXdzmp7M8rpcYTTKzwMT=QKt=_m7m7Bfp7uM4izMkrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfXXdzmp7M8rpcYTTKzwMT=QKt=_m7m7Bfp7uM4izMkrQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Derek Basehore <dbasehore@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Dmitry Torokhov <dtor@chromium.org>, venkateswarlu.v.vinjamuri@intel.corp-partner.google.com
List-Id: linux-i2c@vger.kernel.org

Hi,

On 07/27/2018 12:44 PM, Andy Shevchenko wrote:
> On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore <dbasehore@chromium.org> wrote:
>> This enables the async suspend property for i2c devices. This reduces
>> the suspend/resume time considerably on platforms with multiple i2c
>> devices (such as a trackpad or touchscreen).
> 
> How did you test this?
> 
> Especially on Chromebooks based on Intel Cherrytrail / Braswell
> platforms, they have a painful PMIC vs. OS design solution.
> 
> +Cc: Hans, who did a lot in this area.

We disable suspend of the i2c controller for the i2c-bus
to which the PMIc is connected on these platforms, so I do not
expect this to cause any new issues.

But this is something to keep an eye on,

Regards,

Hans
