From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: at24: consistently document the
 compatible property
Date: Tue, 2 Jan 2018 10:00:08 -0600
Message-ID: <20180102160008.pclglwmfwbjdakxi@rob-hp-laptop>
References: <20171228104913.29873-1-brgl@bgdev.pl>
 <20171228104913.29873-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46680 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeABQAM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 2 Jan 2018 11:00:12 -0500
Content-Disposition: inline
In-Reply-To: <20171228104913.29873-2-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 28, 2017 at 11:49:10AM +0100, Bartosz Golaszewski wrote:
> Current description of the compatible property for at24 is quite vague.
> 
> State explicitly that any "<manufacturer>,<model>" pair is accepted as
> long as a correct fallback is used for non-atmel chips.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 58 ++++++++++++++---------
>  1 file changed, 36 insertions(+), 22 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
