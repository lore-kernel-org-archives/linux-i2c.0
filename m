From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v9 2/4] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Wed, 5 Nov 2014 16:49:47 +0100
Message-ID: <20141105154947.GV31358@localhost>
References: <1414427472-4100-1-git-send-email-octavian.purdila@intel.com>
 <1414427472-4100-3-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414427472-4100-3-git-send-email-octavian.purdila@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: gregkh@linuxfoundation.org, linus.walleij@linaro.org, gnurou@gmail.com, wsa@the-dreams.de, sameo@linux.intel.com, lee.jones@linaro.org, arnd@arndb.de, johan@kernel.org, daniel.baluta@intel.com, laurentiu.palcu@intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 27, 2014 at 06:31:10PM +0200, Octavian Purdila wrote:
> From: Laurentiu Palcu <laurentiu.palcu@intel.com>
> 
> This patch adds support for the Diolan DLN-2 I2C master module. Due
> to hardware limitations it does not support SMBUS quick commands.
> 
> Information about the USB protocol interface can be found in the
> Programmer's Reference Manual [1], see section 6.2.2 for the I2C
> master module commands and responses.
> 
> [1] https://www.diolan.com/downloads/dln-api-manual.pdf
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
