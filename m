From: rishi gupta <gupt21@gmail.com>
Subject: Re: [PATCH v2] HID: mcp2221: add usb to i2c-smbus host bridge driver
Date: Wed, 22 Jan 2020 18:48:37 +0530
Message-ID: <CALUj-gsJ4aKDzir2qArSrt3uNMwO-L3KbOzUFpikj6K5pQ=wtw@mail.gmail.com>
References: <1579581860-29560-1-git-send-email-gupt21@gmail.com> <20200122131320.GA20984@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20200122131320.GA20984@ninjato>
Sender: linux-input-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, wsa+renesas@sang-engineering.com, Greg KH <gregkh@linuxfoundation.org>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

It is both I2C and SMBus.
Title of the product itself is "USB 2.0 to I^2C/UART Protocol
Converter with GPIO"
https://www.microchip.com/wwwproducts/en/MCP2221A

If I am mistaken in something, please help me with specific thing so
that I can dive more from that perspective.

On Wed, Jan 22, 2020 at 6:43 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Jan 21, 2020 at 10:14:20AM +0530, Rishi Gupta wrote:
> > MCP2221 is a USB HID to I2C/SMbus host bridge device. This
> > commit implements i2c and smbus host adapter support. 7-bit
> > address and i2c multi-message transaction is also supported.
> >
> > Signed-off-by: Rishi Gupta <gupt21@gmail.com>
>
> My main concern is there are quite some limitations in mcp_i2c_xfer().
> Looking at them, I think we should just drop it. This seems to be an
> SMBus controller, not I2C. Or?
>
