From: Jim Broadus <jbroadus@gmail.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by a i2c client device.
Date: Mon, 18 Feb 2019 10:25:10 -0800
Message-ID: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
References: <20190216001533.5465-1-jbroadus@gmail.com> <20190218100652.GB27940@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218100652.GB27940@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: benjamin.tissoires@redhat.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Thank you Charles. I should probably correct the typos in my commit message.

On Mon, Feb 18, 2019 at 2:06 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Fri, Feb 15, 2019 at 04:15:33PM -0800, Jim Broadus wrote:
> > A previous change allowed i2c client devices to discover new IRQs upon
> > reprobe. By clearing the IRQ in i2c_device_remove. However, if an IRQ was
> > assigned in i2c_new_device, that information is lost.
> >
> > For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> > are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> > client device structures are initialized during an ACPI walk. After
> > removing the i2c_hid device, modprobe fails.
> >
> > This change caches the initial IRQ value in i2c_new_device and then resets
> > the client device IRQ to the initial value in i2c_device_remove.
> >
> > Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> > ---
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Apologies for the issues caused. I think this looks like a good fix
> to me.
>
> Thanks,
> Charles
