From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH RESEND 0/3] hwmon: convert remaining drivers to
 i2c_new_dummy_device()
Date: Tue, 3 Sep 2019 11:33:40 -0700
Message-ID: <20190903183340.GA29077@roeck-us.net>
References: <20190903181256.13450-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903181256.13450-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 03, 2019 at 08:12:53PM +0200, Wolfram Sang wrote:
> This series is part of a tree-wide movement to replace the I2C API call
> 'i2c_new_dummy' which returns NULL with its new counterpart returning an
> ERRPTR.
> 
> This series fixes the remaining hwmon drivers which could not be
> converted by my cocci script. So, I did it manually, yet all drivers
> still follow the same pattern. Build tested by me and by buildbot. No
> tests on HW have been performed, so testing is appreciated.
> 
I still have the previous version (with RFT) in my queue.
Question is what to do with it; I have not seen any test feedback.
I tend to just apply the series and wait for fallout.
Any objections ?

Guenter
