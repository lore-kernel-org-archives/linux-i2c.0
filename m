From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] hmc6352: Add driver for the HMC6352 compass
Date: Thu, 17 Jun 2010 16:17:54 +0100
Message-ID: <20100617161754.39bd116e@lxorguk.ukuu.org.uk>
References: <20100616121534.26294.12540.stgit@localhost.localdomain>
	<20100616151056.181234b0@hyperion.delvare>
	<20100617125056.6d648ee7@lxorguk.ukuu.org.uk>
	<4C1A12C6.6070704@cam.ac.uk>
	<20100617141440.030f1de9@lxorguk.ukuu.org.uk>
	<20100617165250.5986fbf7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100617165250.5986fbf7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> These functions are supposed to return count on success. Instead, you
> are returning 1.

Ah yes - I only tested with 1 byte sized I/O.

Fixed - do you want this to go via the I2C tree ?
