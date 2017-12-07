From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: add eeprom "no-read-rollover" property
Date: Thu, 7 Dec 2017 09:40:34 -0600
Message-ID: <CAL_JsqLpTt_dOW3caVH6JYdV_OCirB-O+nzXqf-+OZb630PX_g@mail.gmail.com>
References: <1512657378-5221-1-git-send-email-svendev@arcx.com> <1512657378-5221-3-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512657378-5221-3-git-send-email-svendev@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <svendev@arcx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner <david@lechnology.com>, Javier Martinez Canillas <javier@dowhile0.org>, Divagar Mohandass <divagar.mohandass@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 7, 2017 at 8:36 AM, Sven Van Asbroeck <svendev@arcx.com> wrote:
> Adds an optional property for at24 eeproms.
> This parameterless property indicates that the multi-address eeprom
> does not automatically roll over reads to the next slave address.
>
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
