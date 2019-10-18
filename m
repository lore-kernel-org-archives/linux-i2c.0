From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH][RESEND] New driver for TLV493D-A1B6 I2C chip, input and
 hwmon class device.
Date: Fri, 18 Oct 2019 13:56:37 -0700
Message-ID: <20191018205637.GS35946@dtor-ws>
References: <966f09b8-0936-6d90-2ec8-bcb1b94c81aa@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <966f09b8-0936-6d90-2ec8-bcb1b94c81aa@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Ladman <ladmanj@volny.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-i2c@vger.kernel.org

Hi Jakub,

On Fri, Oct 18, 2019 at 10:10:19PM +0200, Jakub Ladman wrote:
> Dear maintainers.
> 
> As a linux-patch newbie i made some mistakes in my first attempt to send
> this patch.
> This patch contains a new driver for i2c connected chip, Infineon
> TLV493D-A1B6.
> The chip is 3D hall-effect sensor with thermometer.
> 
> This particular driver senses magnetic field rotation in X/Y plane with 1
> degree resolution and +/- 1 degree error.
> 
> Input device is created for the angle sensing part.
> Hwmon device is created for the thermometer part.
> 
> Input device axis must be configured by device-tree. There are also optional
> parameters regarding absolute/relative mode switching, minimum step in
> relative mode, filtering and thermometer calibration.
> 
> We are using that device as high reliability rotary encoder.

I wonder if IIO subsystem that support s magnetometers and temperature
sensors would not be a better hone for this.

CC-ing Jonathan.

Also, your mailer mangled your patch pretty badly, please consider using
git send-email next time.

Thanks.

-- 
Dmitry
