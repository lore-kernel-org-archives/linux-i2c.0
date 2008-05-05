From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] modpost: i2c aliases need no trailing wildcard
Date: Mon, 5 May 2008 10:09:05 +1000
Message-ID: <200805051009.06159.rusty@rustcorp.com.au>
References: <20080502203721.70c5dc09@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755618AbYEEAJY@vger.kernel.org>
In-Reply-To: <20080502203721.70c5dc09@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Kay Sievers <kay.sievers@vrfy.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday 03 May 2008 04:37:21 Jean Delvare wrote:
> Hi all,
>
> [Once more with Sam's address fixed, sorry for the noise.]
>
> Not all device types need a wildcard at the end of their module
> aliases. In particular, for i2c module aliases, the trailing wildcard
> is not only unneeded, it could also cause the wrong driver to be
> loaded.

Hi Jean,

   i2c would have been better using a terminator char after the device name.  
The wildcard would then allow future extensions without having the current 
potential confusion.

Still, there's nothing wrong with this patch, happy for you to send it.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Cheers,
Rusty.
