From: rishi gupta <gupt21@gmail.com>
Subject: Re: [PATCH v3] HID: mcp2221: add usb to i2c-smbus host bridge
Date: Tue, 10 Mar 2020 17:41:31 +0530
Message-ID: <CALUj-gvUthgPRFBje3uJf03S_Fh2m5Ez6JX-A3-mvdW9TYvHhg@mail.gmail.com>
References: <1580185137-11255-1-git-send-email-gupt21@gmail.com> <nycvar.YFH.7.76.2003101241580.19500@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.2003101241580.19500@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, wsa+renesas@sang-engineering.com, Greg KH <gregkh@linuxfoundation.org>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

I am really grateful to you and all other maintainers.
You really do a lot work; code review is a manual and time consuming task.

Regards,
Rishi

On Tue, Mar 10, 2020 at 5:12 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 28 Jan 2020, Rishi Gupta wrote:
>
> > MCP2221 is a USB HID to I2C/SMbus host bridge device. This
> > commit implements i2c and smbus host adapter support. 7-bit
> > address and i2c multi-message transaction is also supported.
>
> Applied; sorry this took me a bit longer to review.
>
> --
> Jiri Kosina
> SUSE Labs
>
