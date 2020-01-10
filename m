From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 5/5] at24: Support probing while off
Date: Fri, 10 Jan 2020 12:16:14 +0100
Message-ID: <CAMRc=MfqRqtW=nMuKFcpLrBHYg7wwPboUEvYpj2sBXM8yWEM_w@mail.gmail.com>
References: <20200109154529.19484-1-sakari.ailus@linux.intel.com> <20200109154529.19484-6-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200109154529.19484-6-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rajmohan Mani <rajmohan.mani@intel.com>, Tomasz Figa <tfiga@chromium.org>
List-Id: linux-i2c@vger.kernel.org

czw., 9 sty 2020 o 16:44 Sakari Ailus <sakari.ailus@linux.intel.com> napisa=
=C5=82(a):
>
> In certain use cases (where the chip is part of a camera module, and the
> camera module is wired together with a camera privacy LED), powering on
> the device during probe is undesirable. Add support for the at24 to
> execute probe while being powered off. For this to happen, a hint in form
> of a device property is required from the firmware.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Why am I not Cc'ed on this patch?

Bart
