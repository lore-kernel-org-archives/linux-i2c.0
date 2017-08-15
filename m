From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: add eeprom "size" property
Date: Tue, 15 Aug 2017 14:13:37 -0500
Message-ID: <CAL_JsqLwUOY87ZuJGzeRa_vbUvBbFTfBgob4y2zG0ffnfSGbRQ@mail.gmail.com>
References: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com> <1502736119-32084-2-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502736119-32084-2-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajmohan Mani <rajmohan.mani@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 14, 2017 at 1:41 PM, Divagar Mohandass
<divagar.mohandass@intel.com> wrote:
> This adds eeprom "size" as optional property for i2c eeproms.
>
> "size" should be mentioned in byte and it should refer
> to the eeprom size. This will be read by the driver and
> used to calculating the number of bytes in read/write calls.
>
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
