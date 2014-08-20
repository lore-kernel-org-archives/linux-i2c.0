From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] usb: add support for Diolan DLN-2 devices
Date: Wed, 20 Aug 2014 21:53:00 +0200
Message-ID: <201408202153.00289.arnd@arndb.de>
References: <1408533887-22727-1-git-send-email-daniel.baluta@intel.com> <1408533887-22727-2-git-send-email-daniel.baluta@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408533887-22727-2-git-send-email-daniel.baluta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org, pratyush.anand@st.com, pebolle@tiscali.nl, stern@rowland.harvard.edu, octavian.purdila@intel.com, matthew@mjdsystems.ca, linux-kernel@vger.kernel.org, laurentiu.palcu@intel.com, jdelvare@suse.de, sjg@chromium.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 20 August 2014, Daniel Baluta wrote:
> From: Octavian Purdila <octavian.purdila@intel.com>
> 
> This patch implements the USB part of the Diolan USB-I2C/SPI/GPIO
> Master Adapter DLN-2. Details about the device can be found here:
> 
> https://www.diolan.com/i2c/i2c_interface.html.
> 
> Information about the USB protocol can be found in the Programmer's
> Reference Manual [1], see section 1.7.
> 
> Because the hardware has a single transmit endpoint and a single
> receive endpoint the communication between the various DLN2 drivers
> and the hardware will be muxed/demuxed by this driver.
> 
> The functional DLN2 drivers (i2c, GPIO, etc.) will have to register
> themselves as DLN2 modules in order to send or receive data.
> 
> Each DLN2 module will be identified by the handle field within the DLN2
> message header. If a DLN2 module issues multiple commands in parallel
> they will be identified by the echo counter field in the message header.
> 
> The DLN2 modules can use the dln2_transfer() function to issue a
> command and wait for its response. They can also use an asynchronous
> mode of operation, in which case a receive callback function is going
> to be notified when messages for a specific handle are received.
> 
> Because the hardware reserves handle 0 for GPIO events, the driver
> also reserves handle 0. It will be allocated to a DLN2 module only if
> it is explicitly requested.
> 
> [1] https://www.diolan.com/downloads/dln-api-manual.pdf
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>

After a very brief review of the driver, I think this would be better
handled as an MFD driver in drivers/mfd that creates child devices and
has the high-level drivers get registered as platform_driver.

	Arnd
