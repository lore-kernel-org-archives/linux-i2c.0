From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Thu, 21 Dec 2017 17:20:54 +0100
Message-ID: <0c2455ae-2f68-5342-14c6-14706d6f0e66@axentia.se>
References: <20171221134842.31287-1-brgl@bgdev.pl>
 <20171221134842.31287-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0115.outbound.protection.outlook.com ([104.47.1.115]:64144
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751220AbdLUQVD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 21 Dec 2017 11:21:03 -0500
In-Reply-To: <20171221134842.31287-2-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017-12-21 14:48, Bartosz Golaszewski wrote:
> Current description of the compatible property for at24 is quite vague.
> 
> Specify an exact list of accepted compatibles and document the - now
> deprecated - strings which were previously used in device tree files.

Why is it suddenly deprecated to correctly specify what hardware you
have, e.g. "nxp,24c32". In this case the manufacturer is nxp, damnit.
Sure, it happens to be compatible with "atmel,24c32", but that is
supposed to be written with a fallback as

	"nxp,24c32", "atmel,24c32"

if I understand correctly. So, why is that deprecated in this case?

What if (a few years down the line) it is discovered that some weird
quirk is needed that is only appropriate for nxp chips?

nxp is of course just an example, pick any manufacturer of eeproms
(supposedly) compatible with the atmel interface.

Cheers,
Peter
