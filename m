From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
Date: Tue, 26 Jun 2018 15:11:43 +0300
Message-ID: <c4ad247dd1e0b4b13a2ca4e822bc569675556a7d.camel@linux.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
         <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
         <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chiang, AlanX" <alanx.chiang@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Yeh, Andy" <andy.yeh@intel.com>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "brgl@bgdev.pl" <brgl@bgdev.pl>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-06-26 at 15:11 +0800, Chiang, AlanX wrote:

> If it is, I would like to modify it as below:
> 
> case 8:
> 	If (chip->flags & AT24_FLAG_ADDR16) {
> 		chip->flags &= ~AT24_FLAG_ADDR16;
> 		dev_warn(dev, "address-width is 8, clear the ADDR16
> bit\n");
> 	}
> 	break;

No need to put bit clearing inside the loop, something like below would
be slightly better.

if (chip->flags & AT24_FLAG_ADDR16)
	dev_warn(dev, "address-width is 8, clear the ADDR16 bit\n");
chip->flags &= ~AT24_FLAG_ADDR16;

On top of this the message would sound clearer if you put it like

"Override address width to be 8, while default is 16"

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
