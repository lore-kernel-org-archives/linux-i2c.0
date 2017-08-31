From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: add eeprom "size" property
Date: Thu, 31 Aug 2017 10:26:05 -0500
Message-ID: <20170831152605.zhpi46uu6b5omaou@rob-hp-laptop>
References: <1504112740-14072-1-git-send-email-divagar.mohandass@intel.com>
 <1504112740-14072-2-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504112740-14072-2-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: mark.rutland@arm.com, wsa@the-dreams.de, sakari.ailus@iki.fi, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 30, 2017 at 10:35:38PM +0530, Divagar Mohandass wrote:
> This adds eeprom "size" as optional property for i2c eeproms.
> The "size" property allows explicitly specifying the size of the
> EEPROM chip in bytes.
> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
>  1 file changed, 2 insertions(+)

Please add acks when posting new versions or state here why you didn't.

Acked-by: Rob Herring <robh@kernel.org>
