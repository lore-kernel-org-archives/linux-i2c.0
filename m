From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: i2c: at91: fix i2c-sda-hold-time-ns
  documentation for sam9x60
Date: Wed, 18 Dec 2019 15:37:53 -0600
Message-ID: <20191218213753.GA31975@bogus>
References: <1575886763-19089-1-git-send-email-eugen.hristev@microchip.com>
 <1575886763-19089-4-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575886763-19089-4-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh@kernel.org, Ludovic.Desroches@microchip.com, wsa@the-dreams.de, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Codrin.Ciubotariu@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

On Mon, 9 Dec 2019 10:20:07 +0000, <Eugen.Hristev@microchip.com> wrote:
> 
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> SAM9X60 also supports i2c-sda-hold-time-ns. Fix the documentation accordingly.
> 
> Fixes: 2034e3f4c9a5 ("dt-bindings: i2c: at91: add new compatible")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v3:
> - new patch
> 
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
